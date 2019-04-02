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
docker-compose -f samples/bookinfo/platform/consul/bookinfo.yaml up -d --remove-orphans
```


```
kubectl apply -f samples/bookinfo/platform/consul/destination-rule-all.yaml
kubectl get destinationrules -o yaml
```



```
kubectl apply -f samples/bookinfo/platform/consul/virtual-service-all-v1.yaml
```