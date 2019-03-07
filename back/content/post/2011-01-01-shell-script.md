+++
title = "shell script"
date = 2011-01-01T19:39:03+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["SHELL", "LINUX"]
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


# push docker images to ali

- registry-mirrors



> https://cr.console.aliyun.com

```
#!/usr/bin/env bash

docker login --username=wubigo registry.cn-beijing.aliyuncs.com
docker images  | grep v1.13 | awk '{ print $1 }' | sed --expression=s'/K8S.gcr.io\///' | xargs -i -t docker tag K8S.gcr.io/{}:v1.13.3 registry.cn-beijing.aliyuncs.com/co1/{}:v1.13.3
docker images |grep "registry.cn-beijing.aliyuncs.com"| awk '{ print $1 }'| sed --expression=s'/registry.cn-beijing.aliyuncs.com\/co1\///' | xargs -i -t docker push registry.cn-beijing.aliyuncs.com/co1/{}:v1.13.3
```

#  docker push through cache 

```
#!/usr/bin/env bash

if [ -z "$VM" ]; then
    VM = t1
    echo "VAR VM is not set"
    exit
fi

tee daemon.json << EOF
{
  "registry-mirrors": ["https://registry.docker-cn.com", "https://11h2ev58.mirror.aliyuncs.com"]
}
EOF

scp daemon.json $VM:~/

tee d.sh << EOF
sudo mkdir -p /etc/docker
sudo mv daemon.json /etc/docker
sudo systemctl daemon-reload
sudo systemctl restart docker
EOF
```

ssh $VM 'bash -s' < d.sh
rm daemon.json
# claim docker disk space
docker-clean.sh
```
#!/usr/bin/env bash

# ignoring pipe fail of non-zero exit code
set -o pipefail
docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs -r docker rmi
docker ps --filter status=dead --filter status=exited -aq | xargs docker rm -v
[ ! -z "$VM" ] && ssh $VM 'bash -s' < docker-clean.sh.sh

```
# kube build

```
export K8S_VERSION = v1.13.3
git clone https://github.com/kubernetes/kubernetes.git $GOPATH/src/K8S.io/
git fetch --all
git checkout tags/$K8S_VERSION -b v$K8S_VERSION
```

```
#!/usr/bin/env bash
export ETCD_HOST=192.168.1.9
export KUBE_INTEGRATION_ETCD_URL=http://$ETCD_HOST:2379
cd $GOPATH/src/K8S.io/kubernetes/build/
bash -x ./run.sh make > run.log 2>&1
```

# kubeadm init

```
#!/usr/bin/env bash

cat << EOF > init.sh
#!/usr/bin/env bash
sudo kubeadm reset -f
sudo kubeadm init --kubernetes-version=v1.13.3 --pod-network-cidr 10.2.0.0/16 -v 4 > kubeadm.init.log 2>&1
mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
EOF
ssh $VM 'bash -s' < init.sh
rm init.sh
```

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
docker tag  mirrorgooglecontainers/kube-apiserver:v1.13.3 K8S.gcr.io/kube-apiserver:v1.13.3
docker tag  mirrorgooglecontainers/kube-controller-manager:v1.13.3          K8S.gcr.io/kube-controller-manager:v1.13.3
docker tag  mirrorgooglecontainers/kube-scheduler:v1.13.3 K8S.gcr.io/kube-scheduler:v1.13.3
docker tag  mirrorgooglecontainers/kube-proxy:v1.13.3 K8S.gcr.io/kube-proxy:v1.13.3
docker tag  mirrorgooglecontainers/pause:3.1 K8S.gcr.io/pause:3.1
docker tag  mirrorgooglecontainers/etcd:3.2.24 K8S.gcr.io/etcd:3.2.24
docker tag  coredns/coredns:1.2.6 K8S.gcr.io/coredns:1.2.6

```

# prepare kubelet for kubeadm deploy

> build
```
cd build
run.sh make
scp ~/go/src/K8S.io/kubernetes/_output/dockerized/bin/linux/amd64/kube???  vm1:~/
```

# deploy K8S master

```
#!/usr/bin/env bash

if [ ! -z "$VM" ]; then
    VM = t1
    echo "VAR VM is not set"
    exit    
fi

if [ ! -z "$KV" ]; then
    KV = v1.13.3
    echo "VAR VM is not set ,set to $KV"    
    exit
fi 
if [ ! -z "$PN" ]; then
    PN = 10.2.0.0/16
    echo "VAR PN is not set, set to $PN"
    exit
fi

scp ~/go/src/K8S.io/kubernetes/build/debs/kubelet.service $VM:~/
scp ~/go/src/K8S.io/kubernetes/build/debs/10-kubeadm.conf $VM:~/
scp ~/go/src/github.com/containernetworking/cni/bin/*  $VM:~/
scp ~/go/bin/cri*  $VM:~/
cat << EOF > d.sh
#!/usr/bin/env bash
sudo cp ~/kube??? /usr/bin/
sudo cp ~/kubelet.service /etc/systemd/system/kubelet.service
sudo mkdir -p /etc/kubernetes/manifests
sudo mkdir -p /etc/systemd/system/kubelet.service.d/
sudo cp ~/10-kubeadm.conf /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

sudo systemctl daemon-reload
sudo systemctl enable kubelet --now
sudo systemctl start kubelet

mkdir -p /opt/cni/bin
sudo cp ~/cnitool  ~/noop  /opt/cni/bin

sudo cp ~/cri* /usr/local/bin/
#clean up
rm -f kube??? crictl critest cnitool noop kubelet.service 10-kubeadm.conf

# sudo kubeadm init --kubernetes-version=$KV --pod-network-cidr 10.2.0.0/16 -v 4
if [ -d "$HOME/.kube" ]; then
  mkdir -p $HOME/.kube
fi  
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


curl https://docs.projectcalico.org/v3.5/getting-started/kubernetes/installation/hosted/calico.yaml> calico.yaml
# calico etcd setup
sed -i -e "s/\(^etcd_endpoints: \"http.*$\)/etcd_endpoints: \"https:\/\/$VM:2379\"/g" calico.yaml 
# etcd_ca: "/calico-secrets/etcd-ca"
sed -i -e 's/etcd_ca: \"\"   \# \"\/calico-secrets/etcd-ca\"/etcd_ca: \"\/calico-secrets\/etcd-ca\"/g' calico.yaml
sed -i -e 's/etcd_cert: \"\" # \"\/calico-secrets\/etcd-cert\"/etcd_cert: \"\/calico-secrets\/etcd-cert\"/g' calico.yaml
sed -i -e 's/etcd_key: \"\"  # \"\/calico-secrets\/etcd-key\"/etcd_key: \"\/calico-secrets\/etcd-key\"/g' calico.yaml
CA=$(cat /etc/kubernetes/pki/etcd/ca.crt | base64 -w 0)
CERT=$(cat /etc/kubernetes/pki/etcd/server.crt | base64 -w 0)
KEY=$(sudo cat /etc/kubernetes/pki/etcd/server.key | base64 -w 0)
sed -i -e "s/# etcd-ca: null/etcd-ca: $CA/g" calico.yaml
sed -i -e "s/# etcd-cert: null/etcd-cert: $CERT/g" calico.yaml
sed -i -e "s/# etcd-key: null/etcd-key: $KEY/g" calico.yaml

kubectl apply -f calico.yaml

EOF
# execute the local script on the remote server
ssh $VM 'bash -s' < d.sh
rm d.sh
```

# deploy K8S working node

```
#!/usr/bin/env bash

if [ ! -z "$VM" ]; then
    VM = t1
    echo "VAR VM is not set"
    exit    
fi
scp ~/go/src/K8S.io/kubernetes/build/debs/kubelet.service $VM:~/
scp ~/go/src/K8S.io/kubernetes/build/debs/10-kubeadm.conf $VM:~/
scp ~/go/src/github.com/containernetworking/cni/bin/*  $VM:~/
scp ~/go/bin/cri*  $VM:~/
cat << EOF > d.sh
#!/usr/bin/env bash
sudo cp ~/kube??? /usr/bin/
sudo cp ~/kubelet.service /etc/systemd/system/kubelet.service
sudo mkdir -p /etc/kubernetes/manifests
sudo mkdir -p /etc/systemd/system/kubelet.service.d/
sudo cp ~/10-kubeadm.conf /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

sudo systemctl daemon-reload
sudo systemctl enable kubelet --now
sudo systemctl start kubelet

mkdir -p /opt/cni/bin
sudo cp ~/cnitool  ~/noop  /opt/cni/bin

sudo cp ~/cri* /usr/local/bin/
#clean up

rm -f kube??? crictl critest cnitool noop kubelet.service 10-kubeadm.conf
EOF


TOKEN=$(kubeadm token list)
CA_HASH=$(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | \
   openssl dgst -sha256 -hex | sed 's/^.* //')
cat << EOF > d.sh
#!/usr/bin/env bash
kubeadm join 192.168.1.11:6443 --token $TOKEN --discovery-token-ca-cert-hash sha256:$CA_HASH
EOF
# execute the local script on the remote server
ssh $VM 'bash -s' < d.sh
rm d.sh
```

# replace spaces in file names using a bash script

```
find -name "* *" -type d | rename 's/ /_/g'    # do the directories first
find -name "* *" -type f | rename 's/ //g'
```

# docker PID

`$PATH/docker-pid`

```
#!/usr/bin/env bash
exec docker inspect --format '{{ .State.Pid }}' "$@"

```

#!/usr/bin/env bash

`$PATH/docker-ip`

```
#!/usr/bin/env bash

exec docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"
```
