+++
title = "K8s HA Setup With Kubeadm"
date = 2017-03-16T13:23:32+08:00
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

# setup external ETCD

- install docker, kubelet, and kubeadm
- Configure the kubelet to be a service manager for etcd
- Create configuration files for kubeadm

`/tmp/${HOST0}/kubeadmcfg.yaml`
```
apiVersion: "kubeadm.k8s.io/v1beta1"
kind: ClusterConfiguration
etcd:
    local:
        serverCertSANs:
        - "192.168.1.10"
        peerCertSANs:
        - "192.168.1.10"
        extraArgs:
            initial-cluster: infra0=https://192.168.1.10:2380
            initial-cluster-state: new
            name: infra0
            listen-peer-urls: https://192.168.1.10:2380
            listen-client-urls: https://192.168.1.10:2379
            advertise-client-urls: https://192.168.1.10:2379
            initial-advertise-peer-urls: https://192.168.1.10:2380
```
- Generate the certificate authority
```
sudo kubeadm init phase certs etcd-ca
export HOST0="192.168.1.10"
sudo kubeadm init phase certs etcd-server --config=/tmp/${HOST0}/kubeadmcfg.yaml
sudo kubeadm init phase certs etcd-peer --config=/tmp/${HOST0}/kubeadmcfg.yaml
sudo kubeadm init phase certs etcd-healthcheck-client --config=/tmp/${HOST0}/kubeadmcfg.yaml
sudo kubeadm init phase certs apiserver-etcd-client --config=/tmp/${HOST0}/kubeadmcfg.yaml
```

- Create the static pod manifests

```
kubeadm init phase etcd local --config=/tmp/${HOST0}/kubeadmcfg.yaml
```
`/etc/kubernetes/manifests`

```
apiVersion: v1
kind: Pod
metadata:
  annotations:
    scheduler.alpha.kubernetes.io/critical-pod: ""
  creationTimestamp: null
  labels:
    component: etcd
    tier: control-plane
  name: etcd
  namespace: kube-system
spec:
  containers:
  - command:
    - etcd
    - --advertise-client-urls=https://192.168.1.10:2379
    - --initial-advertise-peer-urls=https://192.168.1.10:2380
    - --initial-cluster=infra0=https://192.168.1.10:2380
    - --initial-cluster-state=new
    - --listen-client-urls=https://192.168.1.10:2379
    - --listen-peer-urls=https://192.168.1.10:2380
    - --name=infra0
    - --cert-file=/etc/kubernetes/pki/etcd/server.crt
    - --client-cert-auth=true
    - --data-dir=/var/lib/etcd
    - --key-file=/etc/kubernetes/pki/etcd/server.key
    - --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
    - --peer-client-cert-auth=true
    - --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
    - --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    - --snapshot-count=10000
    - --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    image: k8s.gcr.io/etcd:3.2.24
    imagePullPolicy: IfNotPresent
    livenessProbe:
      exec:
        command:
        - /bin/sh
        - -ec
        - ETCDCTL_API=3 etcdctl --endpoints=https://[192.168.1.10]:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt
          --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt --key=/etc/kubernetes/pki/etcd/healthcheck-client.key
          get foo
      failureThreshold: 8
      initialDelaySeconds: 15
      timeoutSeconds: 15
    name: etcd
    resources: {}
    volumeMounts:
    - mountPath: /var/lib/etcd
      name: etcd-data
    - mountPath: /etc/kubernetes/pki/etcd
      name: etcd-certs
  hostNetwork: true
  priorityClassName: system-cluster-critical
  volumes:
  - hostPath:
      path: /etc/kubernetes/pki/etcd
      type: DirectoryOrCreate
    name: etcd-certs
  - hostPath:
      path: /var/lib/etcd
      type: DirectoryOrCreate
    name: etcd-data
status: {}

```


- ensure the etcd pod is running

```
journalctl -xeu kubelet
 remote_image.go:112] PullImage "k8s.gcr.io/etcd:3.2.24" from image service failed: rpc error: code = Unknown desc = Error response fro
3月 16 14:41:53 bigo-vm2 kubelet[4221]: E0316 14:41:53.537292    4221 kuberuntime_image.go:51] Pull image "k8s.gcr.io/etcd:3.2.24" failed: rpc error: code = Unknown desc = Error response from daemon: Get 
3月 16 14:41:53 bigo-vm2 kubelet[4221]: E0316 14:41:53.537393    4221 kuberuntime_manager.go:749] container start failed: ErrImagePull: rpc error: code = Unknown desc = Error response from daemon: Get htt
3月 16 14:41:53 bigo-vm2 kubelet[4221]: E0316 14:41:53.537469    4221 pod_workers.go:190] Error syncing pod 30ecbbae123bb7b8baaa2f08cb762164 ("etcd-bigo-vm2_kube-system(30ecbbae123bb7b8baaa2f08cb762164)")
```

```
docker pull mirrorgooglecontainers/etcd:3.2.24
docker tag mirrorgooglecontainers/etcd:3.2.24 k8s.gcr.io/etcd:3.2.24
```
- Check the cluster health

```
docker run --rm -it \
--net host \
-v /etc/kubernetes:/etc/kubernetes k8s.gcr.io/etcd:3.2.24 etcdctl \
--cert-file /etc/kubernetes/pki/etcd/peer.crt \
--key-file /etc/kubernetes/pki/etcd/peer.key \
--ca-file /etc/kubernetes/pki/etcd/ca.crt \
--endpoints https://${HOST0}:2379 cluster-health
```


# Set up the first control plane node

- Copy the following files from any node from the etcd cluster

```
export CONTROL_PLANE="192.168.1.9"
scp /etc/kubernetes/pki/etcd/ca.crt "${CONTROL_PLANE}":
scp /etc/kubernetes/pki/apiserver-etcd-client.crt "${CONTROL_PLANE}":
scp /etc/kubernetes/pki/apiserver-etcd-client.key "${CONTROL_PLANE}":
```


`kubeadm-config.yaml`

```
apiVersion: kubeadm.k8s.io/v1beta1
kind: ClusterConfiguration
kubernetesVersion: stable
apiServer:
  certSANs:
  - "192.168.1.9"
controlPlaneEndpoint: "192.168.1.9:6443"
etcd:
    external:
        endpoints:
        - https://192.168.1.10:2379        
        caFile: /etc/kubernetes/pki/etcd/ca.crt
        certFile: /etc/kubernetes/pki/apiserver-etcd-client.crt
        keyFile: /etc/kubernetes/pki/apiserver-etcd-client.key
networking:
  podSubnet: "10.2.0.0/16"
```

```
kubeadm init --pod-network-cidr 10.2.0.0/16 --config kubeadm-config.yaml -v 4
kubeadm init --config kubeadm-config.yaml -v 4
```


# setup CNI


```
ssh $ETCD

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
```

# join a node


https://blog.scottlowe.org/2018/08/21/bootstrapping-etcd-cluster-with-tls-using-kubeadm/
https://github.com/kelseyhightower/standalone-kubelet-tutorial 



