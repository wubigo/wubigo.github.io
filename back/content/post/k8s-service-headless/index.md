+++
title = "K8s Service Headless"
date = 2018-04-01T17:20:32+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["K8S"]
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



To ensure stable network ID , need to define a headless service for stateful applications

StatefulSets are valuable for applications that require one or more of the following.

- Stable, unique network identifiers.
- Stable, persistent storage.
- Ordered, graceful deployment and scaling.
- Ordered, automated rolling updates


`headless-nginx.yaml'

```
apiVersion: v1
kind: Service
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  ports:
  - port: 80
    name: web
  clusterIP: None
  selector:
    app: nginx
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
spec:
  selector:
    matchLabels:
      app: nginx # has to match .spec.template.metadata.labels
  serviceName: "nginx"
  replicas: 1 
  template:
    metadata:
      labels:
        app: nginx # has to match .spec.selector.matchLabels
    spec:
      terminationGracePeriodSeconds: 10
      containers:
      - name: nginx
        image: nginx:1.14-alpine
        ports:
        - containerPort: 80
          name: web
```

**the .spec.selector field of a StatefulSet must
match the labels of its .spec.template.metadata.labels**

```
kubectl apply -f headless-nginx.yaml

kubectl exec -it web-0 -- nslookup nginx

Name:      nginx
Address 1: 10.2.12.86 web-0.nginx.default.svc.cluster.local
```

```
kubectl run -it --image busybox  test --restart=Never --rm  nslookup web-0.nginx
```


# enable KUBE-DNS LOG

```
kubectl -n kube-system edit configmap coredns

```


Then add log in the Corefile section

```
   Corefile: |
     .:53 {
        log
        errors
        health
        kubernetes cluster.local in-addr.arpa ip6.arpa {
          pods insecure
          upstream
          fallthrough in-addr.arpa ip6.arpa
        }
        prometheus :9153
        proxy . /etc/resolv.conf
        cache 30
        loop
        reload
        loadbalance
    }

```

```
kubectl exec busybox cat /etc/resolv.conf
nameserver 10.96.0.10
search default.svc.cluster.local svc.cluster.local cluster.local
options ndots:5

```

```
kubectl get svc -n kube-system -o wide|grep dns
kube-dns     ClusterIP   10.96.0.10      <none>   53/UDP,53/TCP   41d   k8s-app=kube-dns

```