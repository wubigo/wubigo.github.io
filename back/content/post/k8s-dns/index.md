+++
title = "K8s DNS"
date = 2017-04-01T23:30:42+08:00
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


Before Kubernetes version 1.11, the Kubernetes DNS service was based on kube-dns. Version 1.11 introduced CoreDNS to address some security and stability concerns with kube-dns.

Regardless of the software handling the actual DNS records, both implementations work in a similar manner:

- A service named kube-dns and one or more pods are created.
- The kube-dns service listens for service and endpoint events from the Kubernetes API and updates its DNS records as needed. These events are triggered when you create, update or delete Kubernetes services and their associated pods.
- kubelet sets each new pod's /etc/resolv.conf nameserver option to the cluster IP of the kube-dns service, with appropriate search options to allow for shorter hostnames to be used:
- Applications running in containers can then resolve hostnames such as example-service.namespace into the correct cluster IP addresses.


# Kubernetes DNS Records

- SVC
  
  >service.namespace.svc.cluster.local

- POD
  
  >10.2.9.4.namespace.pod.cluster.local


addressing a service in the same namespace

```
nslookup other-svc
```

addressing a service in a different namespace

```
nslookup other-svc.other-ns
```

# Pod’s dnsPolicy

Note: “Default” is not the default DNS policy. If dnsPolicy is not explicitly specified, then “ClusterFirst” is used.

“ClusterFirst“: Any DNS query that does not match the configured cluster domain suffix, such as “www.kubernetes.io”, is forwarded to the upstream nameserver inherited from the node. Cluster administrators may have extra stub-domain and upstream DNS servers configured. See related discussion for details on how DNS queries are handled in those cases.


# customize pod dns with dnsConfig


busybox has bug on nslookup of k8s svc addressing,

use alpine instead


```
bigo@bigo-HP:~/wubigo.github.io$ kubectl run -it --image curl:v1 curl  --restart=Never --rm -- sh
If you don't see a command prompt, try pressing enter.
/ # nslookup kubernetes
Name:      kubernetes
Address 1: 10.96.0.1 kubernetes.default.svc.cluster.local
/ # nslookup nginx
Name:      nginx
Address 1: 10.2.12.99 web-0.nginx.default.svc.cluster.local
```


# coredns CM


```
kubectl -n kube-system get configmap coredns -o yaml

kubectl -n kube-system edit configmap coredns



data:
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
kind: ConfigMap
metadata:
  creationTimestamp: "2019-02-19T06:54:07Z"
  name: coredns
  namespace: kube-system
  resourceVersion: "561721"
  selfLink: /api/v1/namespaces/kube-system/configmaps/coredns
  uid: 2732a277-3413-11e9-86cc-08002775f493





```