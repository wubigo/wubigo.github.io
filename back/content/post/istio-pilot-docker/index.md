+++
title = "Istio Pilot Docker"
date = 2017-04-02T15:31:41+08:00
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


使用一个没有被占用的网段设置DOCKER_GATEWAY

```
export DOCKER_GATEWAY=172.28.0.1
```

```
URL=https://github.com/istio/istio/releases/download/1.1.1/istio-1.1.1-linux.tar.gz
curl -L "$URL" | tar xz
cd istio-1.1.1
docker-compose -f install/consul/istio.yaml up -d

```


Configure kubectl to use mapped local port for the API server:

```
kubectl config set-context istio --cluster=istio
kubectl config set-cluster istio --server=http://localhost:8080
kubectl config use-context istio
```


```
docker-compose -f samples/bookinfo/platform/consul/bookinfo.yaml up -d
```


```
kubectl apply -f samples/bookinfo/platform/consul/destination-rule-all.yaml
kubectl get destinationrules -o yaml
```



```
kubectl apply -f samples/bookinfo/platform/consul/virtual-service-all-v1.yaml
```

```
docker-compose -f bookinfo.yaml exec  details-v1 sh
#cat /etc/resolv.conf 
search service.consul
nameserver 127.0.0.11
options ndots:0

```


```
docker run -it --rm --network consul_istiomesh  busybox:glibc
#cat /etc/resolv.conf

```




`destinationrules`

```
apiVersion: v1
items:
- apiVersion: networking.istio.io/v1alpha3
  kind: DestinationRule
  metadata:
    annotations:
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"networking.istio.io/v1alpha3","kind":"DestinationRule","metadata":{"annotations":{},"name":"details","namespace":"default"},"spec":{"host":"details.service.consul","subsets":[{"labels":{"version":"v1"},"name":"v1"},{"labels":{"version":"v2"},"name":"v2"}]}}
    clusterName: ""
    creationTimestamp: "2019-04-02T10:15:43Z"
    deletionGracePeriodSeconds: null
    deletionTimestamp: null
    name: details
    namespace: default
    resourceVersion: "106"
    selfLink: /apis/networking.istio.io/v1alpha3/namespaces/default/destinationrules/details
    uid: 4666f266-5530-11e9-bf95-0242ac1c000d
  spec:
    host: details.service.consul
    subsets:
    - labels:
        version: v1
      name: v1
    - labels:
        version: v2
      name: v2
- apiVersion: networking.istio.io/v1alpha3
  kind: DestinationRule
  metadata:
    annotations:
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"networking.istio.io/v1alpha3","kind":"DestinationRule","metadata":{"annotations":{},"name":"productpage","namespace":"default"},"spec":{"host":"productpage.service.consul","subsets":[{"labels":{"version":"v1"},"name":"v1"}]}}
    clusterName: ""
    creationTimestamp: "2019-04-02T10:15:43Z"
    deletionGracePeriodSeconds: null
    deletionTimestamp: null
    name: productpage
    namespace: default
    resourceVersion: "103"
    selfLink: /apis/networking.istio.io/v1alpha3/namespaces/default/destinationrules/productpage
    uid: 465ee98f-5530-11e9-bf95-0242ac1c000d
  spec:
    host: productpage.service.consul
    subsets:
    - labels:
        version: v1
      name: v1
- apiVersion: networking.istio.io/v1alpha3
  kind: DestinationRule
  metadata:
    annotations:
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"networking.istio.io/v1alpha3","kind":"DestinationRule","metadata":{"annotations":{},"name":"ratings","namespace":"default"},"spec":{"host":"ratings.service.consul","subsets":[{"labels":{"version":"v1"},"name":"v1"}]}}
    clusterName: ""
    creationTimestamp: "2019-04-02T10:15:43Z"
    deletionGracePeriodSeconds: null
    deletionTimestamp: null
    name: ratings
    namespace: default
    resourceVersion: "105"
    selfLink: /apis/networking.istio.io/v1alpha3/namespaces/default/destinationrules/ratings
    uid: 4662363d-5530-11e9-bf95-0242ac1c000d
  spec:
    host: ratings.service.consul
    subsets:
    - labels:
        version: v1
      name: v1
- apiVersion: networking.istio.io/v1alpha3
  kind: DestinationRule
  metadata:
    annotations:
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"networking.istio.io/v1alpha3","kind":"DestinationRule","metadata":{"annotations":{},"name":"reviews","namespace":"default"},"spec":{"host":"reviews.service.consul","subsets":[{"labels":{"version":"v1"},"name":"v1"},{"labels":{"version":"v2"},"name":"v2"},{"labels":{"version":"v3"},"name":"v3"}]}}
    clusterName: ""
    creationTimestamp: "2019-04-02T10:15:43Z"
    deletionGracePeriodSeconds: null
    deletionTimestamp: null
    name: reviews
    namespace: default
    resourceVersion: "104"
    selfLink: /apis/networking.istio.io/v1alpha3/namespaces/default/destinationrules/reviews
    uid: 46605c8c-5530-11e9-bf95-0242ac1c000d
  spec:
    host: reviews.service.consul
    subsets:
    - labels:
        version: v1
      name: v1
    - labels:
        version: v2
      name: v2
    - labels:
        version: v3
      name: v3
kind: List
metadata:
  resourceVersion: ""
  selfLink: ""


```

`VirtualService`

```
apiVersion: v1
items:
- apiVersion: networking.istio.io/v1alpha3
  kind: VirtualService
  metadata:
    annotations:
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"networking.istio.io/v1alpha3","kind":"VirtualService","metadata":{"annotations":{},"name":"details","namespace":"default"},"spec":{"hosts":["details.service.consul"],"http":[{"route":[{"destination":{"host":"details.service.consul","subset":"v1"}}]}]}}
    clusterName: ""
    creationTimestamp: "2019-04-02T10:17:57Z"
    deletionGracePeriodSeconds: null
    deletionTimestamp: null
    name: details
    namespace: default
    resourceVersion: "110"
    selfLink: /apis/networking.istio.io/v1alpha3/namespaces/default/virtualservices/details
    uid: 95f21f5f-5530-11e9-bf95-0242ac1c000d
  spec:
    hosts:
    - details.service.consul
    http:
    - route:
      - destination:
          host: details.service.consul
          subset: v1
- apiVersion: networking.istio.io/v1alpha3
  kind: VirtualService
  metadata:
    annotations:
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"networking.istio.io/v1alpha3","kind":"VirtualService","metadata":{"annotations":{},"name":"productpage","namespace":"default"},"spec":{"hosts":["productpage.service.consul"],"http":[{"route":[{"destination":{"host":"productpage.service.consul","subset":"v1"}}]}]}}
    clusterName: ""
    creationTimestamp: "2019-04-02T10:17:57Z"
    deletionGracePeriodSeconds: null
    deletionTimestamp: null
    name: productpage
    namespace: default
    resourceVersion: "107"
    selfLink: /apis/networking.istio.io/v1alpha3/namespaces/default/virtualservices/productpage
    uid: 95ea84fc-5530-11e9-bf95-0242ac1c000d
  spec:
    hosts:
    - productpage.service.consul
    http:
    - route:
      - destination:
          host: productpage.service.consul
          subset: v1
- apiVersion: networking.istio.io/v1alpha3
  kind: VirtualService
  metadata:
    annotations:
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"networking.istio.io/v1alpha3","kind":"VirtualService","metadata":{"annotations":{},"name":"ratings","namespace":"default"},"spec":{"hosts":["ratings.service.consul"],"http":[{"route":[{"destination":{"host":"ratings.service.consul","subset":"v1"}}]}]}}
    clusterName: ""
    creationTimestamp: "2019-04-02T10:17:57Z"
    deletionGracePeriodSeconds: null
    deletionTimestamp: null
    name: ratings
    namespace: default
    resourceVersion: "109"
    selfLink: /apis/networking.istio.io/v1alpha3/namespaces/default/virtualservices/ratings
    uid: 95ee32e2-5530-11e9-bf95-0242ac1c000d
  spec:
    hosts:
    - ratings.service.consul
    http:
    - route:
      - destination:
          host: ratings.service.consul
          subset: v1
- apiVersion: networking.istio.io/v1alpha3
  kind: VirtualService
  metadata:
    annotations:
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"networking.istio.io/v1alpha3","kind":"VirtualService","metadata":{"annotations":{},"name":"reviews","namespace":"default"},"spec":{"hosts":["reviews.service.consul"],"http":[{"route":[{"destination":{"host":"reviews.service.consul","subset":"v1"}}]}]}}
    clusterName: ""
    creationTimestamp: "2019-04-02T10:17:57Z"
    deletionGracePeriodSeconds: null
    deletionTimestamp: null
    name: reviews
    namespace: default
    resourceVersion: "108"
    selfLink: /apis/networking.istio.io/v1alpha3/namespaces/default/virtualservices/reviews
    uid: 95eb9df1-5530-11e9-bf95-0242ac1c000d
  spec:
    hosts:
    - reviews.service.consul
    http:
    - route:
      - destination:
          host: reviews.service.consul
          subset: v1
kind: List
metadata:
  resourceVersion: ""
  selfLink: ""
```


