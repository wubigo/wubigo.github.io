---
layout: post
title: shell script
date: 2011-01-01
tag: shell
---

# kube image pull then tag
```
#!/usr/bin/env bash
docker pull  mirrorgooglecontainers/kube-apiserver:v1.13.3
docker pull  mirrorgooglecontainers/kube-controller-manager:v1.13.3
docker pull  mirrorgooglecontainers/kube-scheduler:v1.13.3
docker pull  mirrorgooglecontainers/kube-proxy:v1.13.3
docker pull  mirrorgooglecontainers/pause:3.1
docker pull  mirrorgooglecontainers/etcd:3.2.24
docker pull  coredns/coredns:1.2.6
docker tag  mirrorgooglecontainers/kube-apiserver:v1.13.3 k8s.gcr.io/kube-apiserver:v1.13.3
docker tag  mirrorgooglecontainers/kube-controller-manager:v1.13.3          k8s.gcr.io/kube-controller-manager:v1.13.3
docker tag  mirrorgooglecontainers/kube-scheduler:v1.13.3 k8s.gcr.io/kube-scheduler:v1.13.3
docker tag  mirrorgooglecontainers/kube-proxy:v1.13.3 k8s.gcr.io/kube-proxy:v1.13.3
docker tag  mirrorgooglecontainers/pause:3.1 k8s.gcr.io/pause:3.1
docker tag  mirrorgooglecontainers/etcd:3.2.24 k8s.gcr.io/etcd:3.2.24
docker tag  coredns/coredns:1.2.6 k8s.gcr.io/coredns:1.2.6

```

# scp kubeadm from build to k8s master or worker

```
cd build
run.sh make

#!/usr/bin/env bash
scp ~/go/src/k8s.io/kubernetes/_output/dockerized/bin/linux/amd64/kube???  vm1:~/

```
