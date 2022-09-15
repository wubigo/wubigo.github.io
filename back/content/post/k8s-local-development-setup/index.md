+++
title = "K8S local development setup from source code"
subtitle = "K8S local development setup"
summary = "Setup a local development environment from source code with kubeadm"
date = 2016-02-03T11:38:27+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["PAAS", "K8S"]
categories = ["IT"]

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++


更新到最新正式发布版**V1.13.3**

# Main external dependencies
- go
- docker
- cri
- cni

[external-dependencies](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.11.md#external-dependencies)

![release/stable-1.11.txt](/img/post/kubernetes-release.png)

***KUBEADM IS CURRENTLY IN BETA***

# kubeadm maturity
![kubeadm maturity](/img/post/kubeadm_maturiy.png)


# build k8s
* docker v17.03

```
sudo apt-get install docker-ce=17.03.3~ce-0~ubuntu-xenial
docker pull mirrorgooglecontainers/kube-apiserver-amd64:v1.11.7
docker tag mirrorgooglecontainers/kube-apiserver-amd64:v1.11.7 k8s.gcr.io/kube-apiserver-amd64:v1.11.7
docker pull mirrorgooglecontainers/kube-controller-manager-amd64:v1.11.7
docker tag  mirrorgooglecontainers/kube-controller-manager-amd64:v1.11.7 k8s.gcr.io/kube-controller-manager-amd64:v1.11.7
docker pull mirrorgooglecontainers/kube-scheduler-amd64:v1.11.7
docker tag mirrorgooglecontainers/kube-scheduler-amd64:v1.11.7 k8s.gcr.io/kube-scheduler-amd64:v1.11.7
docker pull mirrorgooglecontainers/kube-proxy-amd64:v1.11.7
docker tag mirrorgooglecontainers/kube-proxy-amd64:v1.11.7 k8s.gcr.io/kube-proxy-amd64:v1.11.7
docker pull mirrorgooglecontainers/pause:3.1
docker tag mirrorgooglecontainers/pause:3.1 k8s.gcr.io/pause:3.1
docker pull mirrorgooglecontainers/etcd-amd64:3.2.18
docker tag mirrorgooglecontainers/etcd-amd64:3.2.18 k8s.gcr.io/etcd-amd64:3.2.18
docker pull coredns/coredns:1.1.3
docker tag coredns/coredns:1.1.3 k8s.gcr.io/coredns:1.1.3


```
* cri-tools v1.11.0
```
git clone  https://github.com/kubernetes-sigs/cri-tools.git $GOPATH/src/github.com/kubernetes-sigs/
git checkout tags/v1.13.0 -b v1.13.0
make
$GOPATH/bin/crictl -version
cp $GOPATH/bin/cri* /usr/local/bin/
```

* [install-go-1.10](https://wubigo.com/2018/02/go-notes/#install-go-110)

* checkout v1.11.7
```
git clone https://github.com/kubernetes/kubernetes.git $GOPATH/src/k8s.io/
git fetch --all
git checkout tags/v1.11.7 -b v1.11.7
```
or
```
git clone -b v1.11.7 https://github.com/kubernetes/kubernetes.git
```

* LOCAL ETCD INTEGRATION 
```
+++ source /home/bigo/go/src/k8s.io/kubernetes/hack/lib/etcd.sh
++++ ETCD_VERSION=3.2.24
++++ ETCD_HOST=127.0.0.1
++++  
++++ KUBE_INTEGRATION_ETCD_URL=http://127.0.0.1:2379
```

* build v1.11.7

```
cd kubernetes
git remote add upstream https://github.com/kubernetes/kubernetes.git
git remote set-url --push upstream no_push
git fetch upstream
git tag|grep v1.11.7
git checkout tags/v1.11.7 -b <branch_name>
docker pull mirrorgooglecontainers/kube-cross:v1.10.7-1
docker tag mirrorgooglecontainers/kube-cross:v1.10.7-1 k8s.gcr.io/kube-cross:v1.10.7-1
```

```
export ETCD_HOST=192.168.1.9
export KUBE_INTEGRATION_ETCD_URL=http://$ETCD_HOST:2379
bash -x ./build/run.sh make > run.log 2>&1
./_output/dockerized/bin/linux/amd64/kubeadm version| grep v1.11.7
```
or
```
make  quick-release
./_output/release-stage/client/linux-amd64/kubernetes/client/bin/kubeadm version| grep v1.11.7
```

# deploy K8S with kubeadm

* install kubectl 
```
sudo cp ./_output/release-stage/client/linux-amd64/kubernetes/client/bin/kubectl /usr/bin/
sudo cp ./_output/release-stage/server/linux-amd64/kubernetes/server/bin/kubeadm /usr/bin/
sudo cp ./_output/release-stage/server/linux-amd64/kubernetes/server/bin/kubelet /usr/bin/
```

* kubeadm kubectl bash completion
```
kubeadm completion bash > ~/.kube/kubeadm_completion.bash.inc
echo "source '$HOME/.kube/kubeadm_completion.bash.inc'\n" >> $HOME/.bashrc
```



* install kubelet service
```
sudo cp ./build/debs/kubelet.service /etc/systemd/system/kubelet.service
sudo mkdir -p /etc/kubernetes/manifests
sudo mkdir -p /etc/systemd/system/kubelet.service.d/
sudo cp ./build/debs/10-kubeadm.conf /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
sudo systemctl daemon-reload
sudo systemctl enable kubelet --now
sudo systemctl start kubelet
sudo useradd -G systemd-journal $USER
journalctl -xeu kubelet
```

* disable swap
```
sudo swapoff -a
```

* build cni v0.6.0
```
git clone -b v0.6.0 https://github.com/containernetworking/cni.git
cd cni
./build.sh
mkdir -p /opt/cni/bin
cp bin/* /opt/cni/bin/
```

* Configure NetworkManager for calio

NetworkManager manipulates the routing table for interfaces in the default network namespace where Calico veth pairs are anchored for connections to containers. This can interfere with the Calico agent’s ability to route correctly.
Create the following configuration file at `/etc/NetworkManager/conf.d/calico.conf` to prevent NetworkManager from interfering with the interfaces:
```
[keyfile]
unmanaged-devices=interface-name:cali*;interface-name:tunl*
```

* bootstrap a secure Kubernetes cluster
debug level with -v
```
sudo kubeadm init --kubernetes-version=v1.11.7 --pod-network-cidr 10.2.0.0/16 -v 4
```

* configure kubectl
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

* calico setup

[calico etcd setup](https://wubigo.com/post/2011-01-01-shell-script#calico-etcd-setup)

```
kubectl apply -f calico.yaml (https://docs.projectcalico.org/v3.7/getting-started/kubernetes/installation/hosted/calico.yaml)
```

* kubectl completion code for bash
```
  # Installing bash completion on Linux
  kubectl completion bash > ~/.kube/kubectl.bash.inc
  printf "
  # Kubectl shell completion
  source '$HOME/.kube/kubectl.bash.inc'
  " >> $HOME/.bashrc
  source $HOME/.bashrc
```



* Control plane node isolation

By default, the cluster will not schedule pods on the master for security reasons. 
If you want to be able to schedule pods on the master, e.g. for a single-machine 
Kubernetes cluster for development, run:
```
kubectl taint nodes --all node-role.kubernetes.io/master-
```

# view cluster config

```
kubectl describe configmaps kubeadm-config -n kube-system
journalctl -xe | grep -i etcd
```

or
```
cd /etc/kubernetes/manifests
etcd.yaml  kube-apiserver.yaml  kube-controller-manager.yaml  kube-scheduler.yaml
```
# ETCD liveness probe 
```
kubectl describe pods etcd-bigo-vm3 -n kube-system
Liveness:       exec [/bin/sh -ec ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt --key=/etc/kubernetes/pki/etcd/healthcheck-client.key get foo]
sudo curl -v -l https://127.0.0.1:2379/v3/keys --cacert /etc/kubernetes/pki/etcd/ca.crt --cert /etc/kubernetes/pki/etcd/healthcheck-client.crt --key /etc/kubernetes/pki/etcd/healthcheck-client.key 
```

```
kubectl exec -it etcd-bigo-vm1 -n kube-system -- sh
ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt --key=/etc/kubernetes/pki/etcd/healthcheck-cl
ient.key member list
```


# join a node
*  [install docker v17.03](http://wubigo.com/2012/06/linux/#instll-docker-v1703)
*  IPVS proxier
[load IPVS mod](http://wubigo.com/2012/06/linux/#ipvs)
* install  ebtables socat

```
apt install ebtables socat
```

* install kubelet service
*  get token

```
kubeadm token list
```

* get token-ca-cert-hash

```
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | \
   openssl dgst -sha256 -hex | sed 's/^.* //'
```

>all in one shell

[deploy-work-node.sh](http://wubigo.com/2011/01/shell-script/#deploy-K8S-working-node)



* token recreate
By default, tokens expire after 24 hours. Joining a node to the cluster after the current token has expired, you can create a new token by running the following command on the master node:
```
kubeadm token create
```

* Deploying the Dashboard

`sa-admin-user.yaml`
```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kube-system
```

`rb-admin-user.yaml`
```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kube-system
```

```
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml

```

Bearer Token

```
kubectl proxy
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')
http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
```

* depoly nginx and verify

creates a Deployment object and an associated ReplicaSet object with 2 pods
```
kubectl run nginx1-14 --generator=run-pod/v1 --labels="run=nginx1.14" --image=nginx:1.14-alpine  --port=80
POD_IP=$(kubectl get pods -o wide | grep nginx1-14 | awk '{print $6}' | head -n 1)
curl $POD_IP
kubectl get pods -o wide | grep nginx1-14 | awk '{print $6}' | head -n 2 |xargs printf -- 'http://%s\n'|xargs curl
```


# Kubernetes requires a none-stop app/CMD
Docker container stop automatically after running
**K8S will restart it at default if a container stop **

test/curl/Dockerfile

***let kubectl never restart container

```
FROM alpine:3.8
RUN apk add --no-cache curl
CMD ["sh"]
docker build .
docker tag curl-alpine:1.0
kubectl run curl -it --image=curl-alpine:1.0 --restart=Never sh
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




sudo kubeadm init phase etcd local --config=configfile.yaml -v4

--kubernetes-version=v1.11.7

kubeadm init --config 
```
etcd:
  local:
     serverCertSANs:
     - "0.0.0.0"
     peerCertSANs:
     - "0.0.0.0"     
  extraArgs:
    listen-client-urls: --listen-client-urls=https://0.0.0.0:2379
 ```





