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

