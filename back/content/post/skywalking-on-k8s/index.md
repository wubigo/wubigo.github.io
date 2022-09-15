+++
title = "Skywalking on K8s"
date = 2020-11-04T15:58:19+08:00
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


## 安装ECK(禁用TLS)

[](/post/elastic-cloud-on-k8s/)

## 安装helm3

## 安装skywalking8

```
git clone git@github.com:wubigo/skywalking-kubernetes.git
cd skywalking-kubernetes/chart
helm repo add elastic https://helm.elastic.co
helm dep up skywalking
export SKYWALKING_RELEASE_NAME=skywalking
export SKYWALKING_RELEASE_NAMESPACE=default  
```

- 配置ES

`skywalking/values-my-es.yaml`


```
oap:
  image:
    tag: 8.1.0-es7      # Set the right tag according to the existing Elasticsearch version
  storageType: elasticsearch7

ui:
  image:
    tag: 8.1.0

elasticsearch:
  enabled: false
  config:               
    host: 10.101.24.19
    port:
      http: 9200
    user: "elastic"         #[optional]
    password: "8FfgPZu0985bAm2x4243ncxJ"     # [optional]
```


```
helm install "${SKYWALKING_RELEASE_NAME}" skywalking -n "${SKYWALKING_RELEASE_NAMESPACE}" \
  -f ./skywalking/values-my-es.yaml

```

## 检查

```
kubectl get svc
NAME                      TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)               AGE
kubernetes                ClusterIP   10.96.0.1        <none>        443/TCP               4h31m
quickstart-es-default     ClusterIP   None             <none>        9200/TCP              123m
quickstart-es-http        ClusterIP   10.101.24.19     <none>        9200/TCP              123m
quickstart-es-transport   ClusterIP   None             <none>        9300/TCP              123m
skywalking-oap            ClusterIP   10.105.155.189   <none>        12800/TCP,11800/TCP   8m4s
skywalking-ui             ClusterIP   10.111.140.232   <none>        80/TCP                8m4s

```



```
kubectl port-forward service/skywalking-ui 8080:80

curl http://localhost:8080
```

## 查询

对于Trace 信息， 数据的采集与存储是一个典型的写多读少的业务场景。

ElasticSearch 存储主要分为两大部分：服务/操作索引和 Span 索引。

利用 ElasticSearch 会对数据进行分片，分 index 的存储，防止历史数据丢失，

方便对历史问题进行回溯。对于超过 30 天的数据进行归档，转存到 ES 之外以备

不时之需。ElasticSearch 只对相对较“热”的数据提供检索服务

https://github.com/imperialwicket/elasticsearch-logstash-index-mgmt

