+++
title = "ECK notes"
date = 2020-11-02T18:03:25+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = []
categories = []

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++


## 什么是ECK

```
Built on the Kubernetes Operator pattern, Elastic Cloud on Kubernetes (ECK) extends the basic Kubernetes orchestration capabilities to support the setup and management of Elasticsearch, Kibana and APM Server on Kubernetes
```


## install Elasticsearch CRD

```
kubectl apply -f https://download.elastic.co/downloads/eck/1.2.1/all-in-one.yaml
kubectl -n elastic-system logs -f statefulset.apps/elastic-operator
```

## 创建PV(两种方法任选其一)


- hostPath

`localPath.yaml`

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: es-pv-volume
  labels:
    type: local
spec:
  storageClassName: local-hdd
  capacity:
    storage: 200Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"
```




- Local volume

**Local volumes do not currently support dynamic provisioning**
**创建目录/mnt/pv**

`sc.yaml`

```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
```

`local-pv.yaml`

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: local-hdd
spec:
  capacity:
    storage: 200Gi
  volumeMode: Filesystem
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Delete
  storageClassName: local-hdd
  local:
    path: /mnt/pv/
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - ssh
```

## 单节点

`es.yml`

```
apiVersion: elasticsearch.k8s.elastic.co/v1
kind: Elasticsearch
metadata:
  name: quickstart
spec:
  version: 7.9.3
  nodeSets:
  - name: default
    count: 1
    config:
      node.master: true
      node.data: true
      node.ingest: true
      node.store.allow_mmap: false
    volumeClaimTemplates:
    - metadata:
        name: elasticsearch-data
      spec:
        accessModes:
        - ReadWriteOnce
        resources:
          requests:
            storage: 100Gi
        storageClassName: local-hdd
```


## 禁用TLS

`es-no-tls.yml`

```
apiVersion: elasticsearch.k8s.elastic.co/v1
kind: Elasticsearch
metadata:
  name: quickstart
spec:
  version: 7.9.3
  nodeSets:
  - name: default
    count: 1
    config:
      node.master: true
      node.data: true
      node.ingest: true
      node.store.allow_mmap: false
    volumeClaimTemplates:
    - metadata:
        name: elasticsearch-data
      spec:
        accessModes:
        - ReadWriteOnce
        resources:
          requests:
            storage: 100Gi
        storageClassName: local-hdd
  http:
    tls:
      selfSignedCertificate:
        disabled: true

```


```
kubectl get elasticsearch
NAME         HEALTH   NODES   VERSION   PHASE   AGE
quickstart   green    1       7.9.3     Ready   50m

```


## 检查


```
kubectl get service quickstart-es-http
```


- 密码

```
kubectl get secret quickstart-es-elastic-user -o go-template='{{.data.elastic | base64decode}}'
```



- http/s

```
kubectl port-forward service/quickstart-es-http 9200


curl -u "elastic:$PASSWORD" -k "https://localhost:9200"

curl -u "elastic:8FfgPZu0985bAm2x4243ncxJ" -k "https://10.101.24.19:9200"



```


## 安装kibana

`kibana.yml`

```
apiVersion: kibana.k8s.elastic.co/v1
kind: Kibana
metadata:
  name: quickstart
spec:
  version: 7.9.3
  count: 1
  elasticsearchRef:
    name: quickstart
    namespace: default
  http:
    tls:
      selfSignedCertificate:
        disabled: true
```

```
kubectl get svc
NAME                      TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)               AGE
kubernetes                ClusterIP   10.96.0.1        <none>        443/TCP               10h
quickstart-es-default     ClusterIP   None             <none>        9200/TCP              8h
quickstart-es-http        ClusterIP   10.101.24.19     <none>        9200/TCP              8h
quickstart-es-transport   ClusterIP   None             <none>        9300/TCP              8h
quickstart-kb-http        ClusterIP   10.110.209.226   <none>        5601/TCP              15m


kubectl port-forward service/quickstart-kb-http 5601
```

## 安装filebeat

Filebeat is a lightweight shipper for forwarding and centralizing log data. Installed as an

agent on your servers, Filebeat monitors the log files or locations that you specify, 

collects log events, and forwards them either to Elasticsearch or Logstash for indexing.

```
curl -L -O https://raw.githubusercontent.com/elastic/beats/7.9/deploy/kubernetes/filebeat-kubernetes.yaml
```

```
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: filebeat-config  
  labels:
    k8s-app: filebeat
data:
  filebeat.yml: |-
    # filebeat.inputs:
    # - type: container
    #   paths:
    #     - /var/log/containers/*.log
    #   processors:
    #     - add_kubernetes_metadata:
    #         host: ${NODE_NAME}
    #         matchers:
    #         - logs_path:
    #             logs_path: "/var/log/containers/"
    filebeat.autodiscover:
     providers:
       - type: kubernetes
         node: ${NODE_NAME}
         hints.enabled: true
         hints.default_config:
           type: container
           paths:
             - /var/log/containers/*${data.kubernetes.container.id}.log
    processors:
      - add_cloud_metadata:
      - add_host_metadata:
      - add_locale: ~
    cloud.id: ${ELASTIC_CLOUD_ID}
    cloud.auth: ${ELASTIC_CLOUD_AUTH}
    output.elasticsearch:
      hosts: ['http://${ELASTICSEARCH_HOST:elasticsearch}:${ELASTICSEARCH_PORT:9200}']
      username: ${ELASTICSEARCH_USERNAME}
      password: ${ELASTICSEARCH_PASSWORD}
      ssl.enabled: false
      ssl.certificate_authorities:
      - /mnt/elastic/tls.crt
    setup.dashboards.enabled: true
    setup.kibana:
      host: "http://${KIBANA_HOST}:5601"
      username: ${ELASTICSEARCH_USERNAME}
      password: ${ELASTICSEARCH_PASSWORD}
      protocol: "http"
      ssl.enabled: false
    filebeat.config:
      modules:
        path: ${path.config}/modules.d/*.yml
        reload.enabled: false
    filebeat.modules:
      - module: system
        syslog:
          enabled: true
          var.paths: ["/var/log/messages"]
          var.convert_timezone: true
        auth:
          enabled: true
          var.paths: ["/var/log/secure"]
          var.convert_timezone: true
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: filebeat
  labels:
    k8s-app: filebeat
spec:
  selector:
    matchLabels:
      k8s-app: filebeat
  template:
    metadata:
      labels:
        k8s-app: filebeat
    spec:
      tolerations:
        - key: node-role.kubernetes.io/master
          effect: NoSchedule
      serviceAccountName: filebeat
      terminationGracePeriodSeconds: 30
      hostNetwork: true
      dnsPolicy: ClusterFirstWithHostNet
      containers:
      - name: filebeat
        image: docker.elastic.co/beats/filebeat:7.9.3
        args: [
          "-c", "/etc/filebeat.yml",
          "-e",
        ]
        env:
        - name: ELASTICSEARCH_HOST
          value: quickstart-es-http
        - name: ELASTICSEARCH_PORT
          value: "9200"
        - name: ELASTICSEARCH_USERNAME
          value: elastic
        - name: ELASTICSEARCH_PASSWORD
          valueFrom:
            secretKeyRef:
              key: elastic
              name: quickstart-es-elastic-user
        - name: KIBANA_HOST
          value: quickstart-kb-http
        - name: ELASTIC_CLOUD_ID
          value:
        - name: ELASTIC_CLOUD_AUTH
          value:
        - name: NODE_NAME
          valueFrom:
            fieldRef:
              fieldPath: spec.nodeName
        securityContext:
          runAsUser: 0
          # If using Red Hat OpenShift uncomment this:
          #privileged: true
        resources:
          limits:
            memory: 200Mi
          requests:
            cpu: 100m
            memory: 100Mi
        volumeMounts:
        - name: config
          mountPath: /etc/filebeat.yml
          readOnly: true
          subPath: filebeat.yml
        - name: data
          mountPath: /usr/share/filebeat/data
        - name: varlibdockercontainers
          mountPath: /var/lib/docker/containers
          readOnly: true
        - name: varlog
          mountPath: /var/log
          readOnly: true
        - name: es-certs
          mountPath: /mnt/elastic/tls.crt
          readOnly: true
          subPath: tls.crt
        - name: localtime
          mountPath: /etc/localtime
          readOnly: true
      volumes:
      - name: config
        configMap:
          defaultMode: 0600
          name: filebeat-config
      - name: varlibdockercontainers
        hostPath:
          path: /var/lib/docker/containers
      - name: varlog
        hostPath:
          path: /var/log
      # data folder stores a registry of read status for all files, so we don't send everything again on a Filebeat pod restart
      - name: data
        hostPath:
          path: /var/lib/filebeat-data
          type: DirectoryOrCreate
      - name: es-certs
        secret:
          secretName: quickstart-es-http-certs-public
      - name: localtime
        hostPath:
          path: /etc/localtime
          type: File
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: filebeat
subjects:
- kind: ServiceAccount
  name: filebeat
  namespace: default
roleRef:
  kind: ClusterRole
  name: filebeat
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: filebeat
  labels:
    k8s-app: filebeat
rules:
- apiGroups: [""] # "" indicates the core API group
  resources:
  - namespaces
  - pods
  verbs:
  - get
  - watch
  - list
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: filebeat
  labels:
    k8s-app: filebeat
---

```