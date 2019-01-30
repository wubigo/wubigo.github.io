---
layout: post
title: k8s local development setup
date: 2016-02-03
tag: [Paas, k8s]
---

[https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.11.md#external-dependencies](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.11.md#external-dependencies)
* docker v17.03

```
sudo apt-get install docker-ce=17.03.3~ce-0~ubuntu-xenial
```
* cri-tools v1.11.0
```
git clone -b v1.11.0 https://github.com/kubernetes-sigs/cri-tools.git
make install
```

* build v1.11.7

```
git clone -b v1.11.7 https://github.com/wubigo/kubernetes.git (https://github.com/kubernetes/kubernetes.git)
cd kubernetes
git remote add upstream https://github.com/kubernetes/kubernetes.git
git remote set-url --push upstream no_push
git fetch upstream
git tag|grep v1.11.7
git checkout tags/v1.11.7 -b <branch_name>
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-cross:v1.11.4-1
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-cross:v1.11.4-1 k8s.gcr.io/kube-cross:v1.11.4-1
./build/run.sh make quick-release
./_output/release-stage/client/linux-amd64/kubernetes/client/bin/kubeadm version| grep v1.11.7
sudo cp ./_output/release-stage/client/linux-amd64/kubernetes/client/bin/kubectl /usr/bin/
sudo cp ./_output/release-stage/server/linux-amd64/kubernetes/server/bin/kubeadm /usr/bin/
sudo cp ./_output/release-stage/server/linux-amd64/kubernetes/server/bin/kubelet /usr/bin/
sudo mkdir -p /etc/kubernetes/manifests
sudo mkdir -p /etc/systemd/system/kubelet.service.d/

```
* disable swap
* build cni v0.6.0
```
git clone -b v0.6.0 https://github.com/containernetworking/cni.git
cd cni
./build.sh
```

* Configure NetworkManager for calio
Configure NetworkManager before attempting to use Calico networking.
NetworkManager manipulates the routing table for interfaces in the default network namespace where Calico veth pairs are anchored for connections to containers. This can interfere with the Calico agent’s ability to route correctly.
Create the following configuration file at /etc/NetworkManager/conf.d/calico.conf to prevent NetworkManager from interfering with the interfaces:
```
[keyfile]
unmanaged-devices=interface-name:cali*;interface-name:tunl*
```


