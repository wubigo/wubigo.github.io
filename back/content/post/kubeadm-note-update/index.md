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
kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl delete -f https://docs.projectcalico.org/manifests/calico.yaml

kubectl delete pod -n kube-system coredns-

kubeadm token list

```

> pod-network-cidr should not overlap with your local netowrk


## troubleshooting

- Loop (127.0.0.1:46732 -> :53) detected for zone

```
kubectl logs -n kube-system coredns-94d74667-9t778

2020-06-14T09:20:33.480Z [INFO] CoreDNS-1.3.1
2020-06-14T09:20:33.480Z [INFO] linux/amd64, go1.11.4, 6b56a9c
CoreDNS-1.3.1
linux/amd64, go1.11.4, 6b56a9c
2020-06-14T09:20:33.480Z [INFO] plugin/reload: Running configuration MD5 = 5d5369fbc12f985709b924e721217843
2020-06-14T09:20:33.481Z [FATAL] plugin/loop: Loop (127.0.0.1:46732 -> :53) detected for zone ".", see https://coredns.io/plugins/loop#troubleshooting. Query: "HINFO 5542328687544567010.7848882517153318095."
```

https://coredns.io/plugins/loop#troubleshooting

方法一：

```
kubectl edit -n kube-system cm kubelet-config-1.15

resolvConf: /opt/etc/resolv.conf
```


方法二：


https://tecadmin.net/disable-local-dns-caching-ubuntu/


方法三：

```
kubectl edit -n kube-system cm coredns

forward . /etc/resolv.conf  -> forward . 192.168.137.180
```

- 系统重启后k8s没有自动启动

在/etc/fstab永久关闭swap


