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
git clone -b v1.11.0 https://github.com/kubernetes-sigs/cri-tools.git
make
$GOPATH/bin/crictl -version
cp $GOPATH/bin/cri* /usr/local/bin/
```

* [install-go-1.10](https://github.com/wubigo/wubigo.github.io/blob/master/_posts/2018-02-11-go%20notes.md#install-go-110)

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

# deploy k8s with kubeadm

* install kubectl 
```
sudo cp ./_output/release-stage/client/linux-amd64/kubernetes/client/bin/kubectl /usr/bin/
sudo cp ./_output/release-stage/server/linux-amd64/kubernetes/server/bin/kubeadm /usr/bin/
sudo cp ./_output/release-stage/server/linux-amd64/kubernetes/server/bin/kubelet /usr/bin/
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
```

* disable swap

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
Create the following configuration file at /etc/NetworkManager/conf.d/calico.conf to prevent NetworkManager from interfering with the interfaces:
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
```
curl https://docs.projectcalico.org/v3.5/getting-started/kubernetes/installation/hosted/calico.yaml> calico.yaml
# update CALICO_IPV4POOL_CIDR to  the above pod-network-cidr
kubectl apply -f calico.yaml
cat /etc/kubernetes/pki/etcd/ca.crt | base64 -w 0    --> {.calico-etcd-secrets.etcd-key}
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
# update config
```
kubectl exec -it etcd-bigo-vm1 -n kube-system -- sh
ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt --key=/etc/kubernetes/pki/etcd/healthcheck-cl
ient.key member list
```


# join a node
*  [install docker v17.03](http://wubigo.com/2012/06/linux/#instll-docker-v1703)
*  IPVS proxier
[load IPVS mod](http://wubigo.com/2012/06/linux/#ipvs)
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
```











CGROUPS_MEMORY: enabled
	[WARNING Service-Kubelet]: kubelet service does not exist
[preflight] Some fatal errors occurred:
	[ERROR FileContent--proc-sys-net-bridge-bridge-nf-call-iptables]: /proc/sys/net/bridge/bridge-nf-call-iptables does not exist
	[ERROR FileContent--proc-sys-net-ipv4-ip_forward]: /proc/sys/net/ipv4/ip_forward contents are not set to 1
	[ERROR Swap]: running with swap on is not supported. Please disable swap
	[ERROR FileExisting-crictl]: crictl not found in system path
	[ERROR SystemVerification]: failed to get docker info: Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?


```

* token recreate
By default, tokens expire after 24 hours. Joining a node to the cluster after the current token has expired, you can create a new token by running the following command on the master node:
```
kubeadm token create
```

* depoly nginx and verify

creates a Deployment object and an associated ReplicaSet object with 2 pods
```
kubectl run nginx1-14 --replicas=2 --labels="run=nginx1.14" --image=nginx:1.14-alpine  --port=80
POD_IP=$(kubectl get pods -o wide | grep nginx1-14 | awk '{print $6}' | head -n 1)
curl $POD_IP
kubectl get pods -o wide | grep nginx1-14 | awk '{print $6}' | head -n 2 |xargs printf -- 'http://%s\n'|xargs curl
```

* deploy mysql
```
$kubectl run mysql-5-5 --replicas=1 --labels="run=mysql-5-5" --image=mysql:5.5 --env="MYSQL_ROOT_PASSWORD=mysql" --port=3306
$kubectl exec -it mysql-5-5 -c mysql-5-5 -- bash
# mysql -u root -pmysql
mysql> 
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


# kubectl cheat sheet
```
kubectl get configmaps --all-namespaces
kubectl describe configmaps kubeadm-config -n kube-system

kubectl -n kube-system get deployment coredns -o yaml | \
  sed 's/allowPrivilegeEscalation: false/allowPrivilegeEscalation: true/g' | \
  kubectl apply -f -
  
kubectl scale --current-replicas=2 --replicas=1 deployments.apps/nginx1-14
kubectl logs calico-node-4mb5z -n kube-system  
  
```



# Kubernetes requires a none-stop app/CMD
Docker container stop automatically after running
***the container dies after running everything correctly but crashes because all the commands ended in k8s. 
Either you make your services run on the foreground, or you create a keep alive script. By doing so, 
Kubernetes will show that your application is running. We have to note that in the Docker environment,
this problem is not encountered. It is only Kubernetes that wants a running app***
```
FROM alpine:3.8
RUN apk add --no-cache curl
STOPSIGNAL SIGTERM
CMD ["/usr/bin/tail", "-f", "/dev/null"]
kubectl run  curl --image=curl-alpine:1.0
kubectl exec -it curl -c curl -- sh
```

***let kubectl never restart container
```
FROM alpine:3.8
RUN apk add --no-cache curl
docker build .
docker tag curl-alpine:1.0
kubectl run busybox -it --image=curl-alpine:1.0 --restart=Never --rm
```



sudo kubeadm init phase etcd local --config=configfile.yaml -v4

--kubernetes-version=v1.11.7
