---
layout: post
title: k8s local development setup
date: 2016-02-03
tag: [Paas, k8s]
---


* build v1.11.7

```
git clone -b v1.11.7 https://github.com/wubigo/kubernetes.git
cd kubernetes
git remote add upstream https://github.com/kubernetes/kubernetes.git
git remote set-url --push upstream no_push
git fetch upstream
git tag|grep v1.11.7
git checkout tags/v1.11.7 -b <branch_name>
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-cross:v1.11.4-1
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-cross:v1.11.4-1 k8s.gcr.io/kube-cross:v1.11.4-1
./build/run.sh make quick-release
./_output/dockerized/bin/linux/amd64/kubeadm version| grep v1.11.7
```
* disable swap


