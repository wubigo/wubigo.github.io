+++
title = "Kubeadm Note Update"
date = 2020-05-23T06:32:11+08:00
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

## 准备

---

- iptables

```
cat <<EOF | sudo tee /etc/modules
br_netfilter
EOF
sudo modprobe br_netfilter
lsmod | grep br_netfilter


cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

```

- install container runtime

```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
apt-cache madison docker-ce
sudo apt-get install docker-ce=17.12.1~ce-0~ubuntu
sudo usermod -aG docker bigo
```

- setup vpn and proxy

[VPN and proxy](/post/ubuntu-vpn-client/)

- install kubeadm

```
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-cache madison kubectl
sudo apt-get install -y kubelet=1.15.12-00 kubeadm=1.15.12-00 kubectl=1.15.12-00
sudo apt-mark hold kubelet kubeadm kubectl
```

- SWAPOFF

```
sudo swapoff -a
```

## 安装

---

`kubeadm.init.yml`

```
apiVersion: kubeadm.k8s.io/v1beta2
kind: ClusterConfiguration
clusterName: kubernetes
imageRepository: registry.aliyuncs.com/google_containers
kubernetesVersion: v1.15.12
networking:
  podSubnet: 10.244.0.0/16
```



```

KUBERNETES_RELEASE_VERSION="$(curl -sSL https://dl.k8s.io/release/stable.txt)"
kubeadm config images list
kubeadm config images pull --config kubeadm.init.yml
sudo kubeadm init --config kubeadm.init.yml  

kubectl delete -f https://docs.projectcalico.org/manifests/calico.yaml

kubectl delete pod -n kube-system coredns-
```

> pod-network-cidr should not overlap with your local netowrk



