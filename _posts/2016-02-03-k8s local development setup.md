---
layout: post
title: k8s local development setup
date: 2016-02-03
tag: [Paas, k8s]
---

[https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.11.md#external-dependencies](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.11.md#external-dependencies)

***KUBEADM IS CURRENTLY IN BETA***

# kubeadm maturity
![kubeadm maturity](/images/posts/kubeadm_maturiy.png)


* docker v17.03

```
sudo apt-get install docker-ce=17.03.3~ce-0~ubuntu-xenial
docker tag mirrorgooglecontainers/kube-apiserver-amd64:v1.11.7 k8s.gcr.io/kube-apiserver-amd64:v1.11.7
docker pull mirrorgooglecontainers/kube-controller-manager-amd64:v1.11.7 k8s.gcr.io/kube-controller-manager-amd64:v1.11.7
docker pull mirrorgooglecontainers/kube-controller-manager-amd64:v1.11.7
docker tag  mirrorgooglecontainers/kube-controller-manager-amd64:v1.11.7 k8s.gcr.io/kube-controller-manager-amd64:v1.11.7
docker pull mirrorgooglecontainers/kube-scheduler-amd64:v1.11.7
docker tag mirrorgooglecontainers/kube-scheduler-amd64:v1.11.7 k8s.gcr.io/kube-scheduler-amd64:v1.11.7
docker pull mirrorgooglecontainers/kube-proxy-amd64:v1.11.7
docker tag mirrorgooglecontainers/kube-proxy-amd64:v1.11.7 k8s.gcr.io/kube-proxy-amd64:v1.11.7
docker pull mirrorgooglecontainers/pause:3.1
docker pull mirrorgooglecontainers/pause:3.1
docker pull mirrorgooglecontainers/pause:3.1
docker tag mirrorgooglecontainers/pause:3.1 k8s.gcr.io/pause:3.1
docker pull mirrorgooglecontainers/etcd-amd64:3.2.18
docker tag mirrorgooglecontainers/etcd-amd64:3.2.18 k8s.gcr.io/etcd-amd64:3.2.18
docker pull coredns/coredns:1.1.3
docker tag coredns/coredns:1.1.3 k8s.gcr.io/coredns:1.1.3


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
```

* kubelet hosted by systemd 
```
sudo cp ./_output/release-stage/client/linux-amd64/kubernetes/client/bin/kubectl /usr/bin/
sudo cp ./_output/release-stage/server/linux-amd64/kubernetes/server/bin/kubeadm /usr/bin/
sudo cp ./_output/release-stage/server/linux-amd64/kubernetes/server/bin/kubelet /usr/bin/
sudo cp ./build/debs/kubelet.service /etc/systemd/system/kubelet.service
sudo mkdir -p /etc/kubernetes/manifests
sudo mkdir -p /etc/systemd/system/kubelet.service.d/
sudo cp ./build/debs/10-kubeadm.conf /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
```
* disable swap

* build cni v0.6.0
```
git clone -b v0.6.0 https://github.com/containernetworking/cni.git
cd cni
./build.sh
```

* Configure NetworkManager for calio

NetworkManager manipulates the routing table for interfaces in the default network namespace where Calico veth pairs are anchored for connections to containers. This can interfere with the Calico agent’s ability to route correctly.
Create the following configuration file at /etc/NetworkManager/conf.d/calico.conf to prevent NetworkManager from interfering with the interfaces:
```
[keyfile]
unmanaged-devices=interface-name:cali*;interface-name:tunl*
```

* bootstrap a secure Kubernetes cluster
debug level with -v
```
sudo kubeadm init --pod-network-cidr 10.2.0.0/16 -v 4
```

* configure kubectl
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

* calico setup
```
curl https://docs.projectcalico.org/v3.5/getting-started/kubernetes/installation/hosted/calico.yaml> calico.yaml
# update CALICO_IPV4POOL_CIDR to  the above pod-network-cidr
kubectl apply -f calico.yaml
```

* kubectl completion code for bash
```
  # Installing bash completion on Linux
  ## Load the kubectl completion code for bash into the current shell
  source <(kubectl completion bash)
  ## Write bash completion code to a file and source if from .bash_profile
  kubectl completion bash > ~/.kube/completion.bash.inc
  printf "
  # Kubectl shell completion
  source '$HOME/.kube/completion.bash.inc'
  " >> $HOME/.bashrc
  source $HOME/.bashrc
```





* tear down cluster
```
kubectl drain <node name> --delete-local-data --force --ignore-daemonsets
kubectl delete node <node name>
```
Then, on the node being removed, reset all kubeadm installed state:
```
kubeadm reset
```
The reset process does not reset or clean up iptables rules or IPVS tables. 
If you wish to reset iptables, you must do so manually:
```
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X
```
If you want to reset the IPVS tables, you must run the following command:
```
ipvsadm -C
```



