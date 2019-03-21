+++
title = "K8s日志EFK"
date = 2016-04-17T14:12:02+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["K8S", "EFK"]
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

- namespace

`kube-logging.yaml`

```
kind: Namespace
apiVersion: v1
metadata:
  name: kube-logging
```

- headless service 

```
kubectl create -f kube-logging.yaml
```

`elasticsearch_svc.yaml`

```
kind: Service
apiVersion: v1
metadata:
  name: elasticsearch
  namespace: kube-logging
  labels:
    app: elasticsearch
spec:
  selector:
    app: elasticsearch
  clusterIP: None
  ports:
    - port: 9200
      name: rest
    - port: 9300
      name: inter-node
```

- PROVISION local PV for EFK

[local PV](/post/k8s-kubectl-cheatsheet#PVC-using-local-PV)

- Creating the StatefulSet

`elasticsearch_statefulset.yaml`

```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: es-cluster
  namespace: kube-logging
spec:
  serviceName: elasticsearch
  replicas: 1
  selector:
    matchLabels:
      app: elasticsearch
  template:
    metadata:
      labels:
        app: elasticsearch
    spec:
      containers:
      - name: elasticsearch
        image: docker.elastic.co/elasticsearch/elasticsearch-oss:6.4.3
        resources:
            limits:
              cpu: 1000m
            requests:
              cpu: 100m
        ports:
        - containerPort: 9200
          name: rest
          protocol: TCP
        - containerPort: 9300
          name: inter-node
          protocol: TCP
        volumeMounts:
        - name: data
          mountPath: /usr/share/elasticsearch/data
        env:
          - name: cluster.name
            value: k8s-logs
          - name: node.name
            valueFrom:
              fieldRef:
                fieldPath: metadata.name
          - name: discovery.zen.ping.unicast.hosts
            value: "es-cluster-0.elasticsearch"
          - name: discovery.zen.minimum_master_nodes
            value: "1"
          - name: ES_JAVA_OPTS
            value: "-Xms512m -Xmx512m"
      initContainers:
      - name: fix-permissions
        image: busybox
        command: ["sh", "-c", "chown -R 1000:1000 /usr/share/elasticsearch/data"]
        securityContext:
          privileged: true
        volumeMounts:
        - name: data
          mountPath: /usr/share/elasticsearch/data
      - name: increase-vm-max-map
        image: busybox
        command: ["sysctl", "-w", "vm.max_map_count=262144"]
        securityContext:
          privileged: true
      - name: increase-fd-ulimit
        image: busybox
        command: ["sh", "-c", "ulimit -n 65536"]
        securityContext:
          privileged: true
  volumeClaimTemplates:
  - metadata:
      name: data
      labels:
        app: elasticsearch
    spec:
      accessModes: [ "ReadWriteOnce" ]
      storageClassName: local-hdd
      resources:
        requests:
          storage: 10Gi    

```

**elasticsearch-<oss>**-oss suffix ensures the open-source version of Elasticsearch
the default version(without suffix) containing X-Pack

# check Elasticsearch is ready

```
kubectl port-forward es-cluster-0 9200:9200 --namespace=kube-logging
curl http://localhost:9200/_cluster/state?pretty | grep master_node
...
{
  "cluster_name" : "k8s-logs",
  "compressed_size_in_bytes" : 230,
  "cluster_uuid" : "9dm998tzS-Ko45dGEOtnDQ",
  "version" : 2,
  "state_uuid" : "oLlQU_qiT8iit4SYx9S1-g",
  "master_node" : "icsCEGzzRCmITCGzGbsSSg",
  "blocks" : { },
  "nodes" : {
    "icsCEGzzRCmITCGzGbsSSg" : {
      "name" : "es-cluster-0",
      "ephemeral_id" : "PoResMCsTyG99qfK-U44_w",
      "transport_address" : "10.2.12.86:9300",
      "attributes" : { }
    }
  },
  "metadata" : {
    "cluster_uuid" : "9dm998tzS-Ko45dGEOtnDQ",
    "templates" : { },
    "indices" : { },
    "index-graveyard" : {
      "tombstones" : [ ]
    }
  },
  "routing_table" : {
    "indices" : { }
  },
  "routing_nodes" : {
    "unassigned" : [ ],
    "nodes" : {
      "icsCEGzzRCmITCGzGbsSSg" : [ ]
    }
  },
  "restore" : {
    "snapshots" : [ ]
  },
  "snapshots" : {
    "snapshots" : [ ]
  },
  "snapshot_deletions" : {
    "snapshot_deletions" : [ ]
  }
}
...
```


# Deploy Kibana 

`kibana.yaml`

```
apiVersion: v1
kind: Service
metadata:
  name: kibana
  namespace: kube-logging
  labels:
    app: kibana
spec:
  ports:
  - port: 5601
  selector:
    app: kibana
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: kibana
  namespace: kube-logging
  labels:
    app: kibana
spec:
  replicas: 1
  selector:
    matchLabels:
      app: kibana
  template:
    metadata:
      labels:
        app: kibana
    spec:
      containers:
      - name: kibana
        image: docker.elastic.co/kibana/kibana-oss:6.4.3
        resources:
          limits:
            cpu: 1000m
          requests:
            cpu: 100m
        env:
          - name: ELASTICSEARCH_URL
            value: http://elasticsearch:9200
        ports:
        - containerPort: 5601

```

- 检查kibana

```
kubectl port-forward svc/kibana 5601:5601 -n kube-logging
curl http://localhost:5601
```

# Deploy Fluentd DaemonSet

**DaemonSet is a Kubernetes workload type that runs a copy of a given Pod on each Node in the Kubernetes cluster**

- ServiceAccount 

`fluentd.yaml`

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: fluentd
  namespace: kube-logging
  labels:
    app: fluentd
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: fluentd
  labels:
    app: fluentd
rules:
- apiGroups:
  - ""
  resources:
  - pods
  - namespaces
  verbs:
  - get
  - list
  - watch
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: fluentd
roleRef:
  kind: ClusterRole
  name: fluentd
  apiGroup: rbac.authorization.k8s.io
subjects:
- kind: ServiceAccount
  name: fluentd
  namespace: kube-logging
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluentd
  namespace: kube-logging
  labels:
    app: fluentd
spec:
  selector:
    matchLabels:
      app: fluentd
  template:
    metadata:
      labels:
        app: fluentd
    spec:
      serviceAccount: fluentd
      serviceAccountName: fluentd
      tolerations:
      - key: node-role.kubernetes.io/master
        effect: NoSchedule
      restartPolicy: Never
      containers:
      - name: fluentd
        image: fluent/fluentd-kubernetes-daemonset:v1.3.3-debian-elasticsearch-1.3        
        env:
          - name:  FLUENT_ELASTICSEARCH_HOST
            value: "elasticsearch.kube-logging.svc.cluster.local"
          - name:  FLUENT_ELASTICSEARCH_PORT
            value: "9200"
          - name: FLUENT_ELASTICSEARCH_SCHEME
            value: "http"
          - name: FLUENT_UID
            value: "0"
        resources:
          limits:
            memory: 512Mi
          requests:
            cpu: 100m
            memory: 200Mi
        volumeMounts:
        - name: varlog
          mountPath: /var/log
        - name: varlibdockercontainers
          mountPath: /var/lib/docker/containers
          readOnly: true
      terminationGracePeriodSeconds: 30
      volumes:
      - name: varlog
        hostPath:
          path: /var/log
      - name: varlibdockercontainers
        hostPath:
          path: /var/lib/docker/containers

```

>tolerations:
      - key: node-role.kubernetes.io/master
        effect: NoSchedule
>

```
kubectl run fluent -it --image=fluent/fluentd-kubernetes-daemonset:v0.12-debian-elasticsearch --restart=Never

Error attaching, falling back to logs: 
standard_init_linux.go:207: exec user process caused "no such file or directory"
pod default/fluent terminated (Error)
```

https://www.digitalocean.com/community/tutorials/how-to-set-up-an-elasticsearch-fluentd-and-kibana-efk-logging-stack-on-kubernetes