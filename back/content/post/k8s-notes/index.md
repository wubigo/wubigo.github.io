---
layout: post
title: K8S notes
date: 2017-07-13
tags: ["K8S", "PAAS"]
---

# 节点维护

```
kubectl drain <node name>
```

维护有DaemonSet-managed pod的节点

```
kubectl drain <node name> --delete-local-data --force --ignore-daemonsets
kubectl delete node <node name>
sudo iptables -F
sudo iptables -S
```

# create a regular pod

必须使用**--restart=Never**

```
kubectl run -it curl --image=curlimages/curl:7.72.0 --restart=Never -- sh
```

- Never acts like a cronjob which is scheduled immediately.
- Always creates a deployment and the deployment monitors the pod and restarts in case of failure.

# kubeadm install mirror in china

```
apt-get update && apt-get install -y apt-transport-https
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF  
apt-get update
apt-cache madison kubeadm
apt install kubeadm=1.18.3-00
apt-get install -y kubelet kubeadm kubectl
```


# join node

```
kubeadm token create --print-join-command
```

# swapoff

kubelet服务不会正常启动，如果交换分区没有关闭

```
dpkg-query -L kubelet
```

# docker Entrypoint vs k8s command

| |  docker | k8s
:---|:---|:---
entry |ENTRYPOINT| command
arguments |CMD| args

**k8s command and args override the default Entrypoint and Cmd**

`Dockerfile`

```
FROM alpine:3.8
RUN apk add --no-cache curl ethtool && rm -rf /var/cache/apk/*
CMD ["--version"]
ENTRYPOINT ["curl"]
```

`cmd-override-pod.yaml`

```
apiVersion: v1
kind: Pod
metadata:
  name: command-override
  labels:
    purpose: override-command
spec:
  containers:
  - name: command-override-container
    image: bigo/curl:v1
    command: ["curl"]
    args: ["--help"]
  restartPolicy: Never
```

```
docker run -it bigo/curl:v1
curl 7.61.1 (x86_64-alpine-linux-musl) libcurl/7.61.1 LibreSSL/2.0.0 zlib/1.2.11 libssh2/1.8.0 nghttp2/1.32.0
Release-Date: 2018-09-05
```

```
kubectl apply -f cmd-override-pod.yaml
kubectl logs command-override

Usage: curl [options...] <url>
     --abstract-unix-socket <path> Connect via abstract Unix domain socket
     --anyauth       Pick any authentication method
 -a, --append        Append to target file when uploading

```


# 工具POD

```
apiVersion: v1
kind: Pod
metadata:
  name: busybox
  namespace: default
spec:
  containers:
  - name: busybox
    image: busybox:1.28
    command:
      - sleep
      - "13600"
    imagePullPolicy: IfNotPresent
  restartPolicy: Always
```

**busybox:latest has bug on nslookup**

```
docker network create test
32024cd09daca748f8254468f4f00893afc2e1173c378919b1f378ed719f1618
docker run -dit --name nginx --network test nginx:alpine
7feaf1f0b4f3d421603bbb984854b753c7cbc6b581dd0a304d3b8fccf8c6604b
$ docker run -it --rm --network test busybox:1.28 nslookup nginx
Server:    127.0.0.11
Address 1: 127.0.0.11
Name:      nginx
Address 1: 172.22.0.2 nginx.test
docker stop nginx
docker network rm test
```


```
kubectl exec -ti busybox -- nslookup kubernetes.default
kubectl run -it --image busybox  test --restart=Never --rm  nslookup kubernetes.default

```



# 无选择器服务

使用场景：

- 通过SERVICE连接到外部服务
- 连接到另一个名字空间或集群
- 迁移过程中访问遗留系统

步骤

- 创建服务

```
kind: Service
apiVersion: v1
metadata:
  name: ext-db
spec:
  ports:
  - protocol: TCP
    port: 80
    targetPort: 3316
```

- 手动创建一个端点

```
kind: Endpoints
apiVersion: v1
metadata:
  name: my-service
subsets:
  - addresses:
      - ip: 10.8.0.2
    ports:
      - port: 3316
```

# kube-proxy  mode

```
kubectl get cm kube-proxy -n kube-system -o yaml > kube-proxy.yaml
sed -i s/mode:""/mode:"ipvs/  kube-proxy.yaml
sec -i s/creationTimestamp:*// kube-proxy.yaml
sed -i s/resourceVersion: "*"// kube-proxy.yaml
kubectl apply -f kube-proxy.yaml
sudo ipvsadm -Ln
...
IP Virtual Server version 1.2.1 (size=4096)
Prot LocalAddress:Port Scheduler Flags
  -> RemoteAddress:Port           Forward Weight ActiveConn InActConn
TCP  10.96.0.1:443 rr
  -> 192.168.1.11:6443            Masq    1      1          0         
TCP  10.96.0.10:53 rr
  -> 10.2.0.129:53                Masq    1      0          0         
  -> 10.2.0.132:53                Masq    1      0          0         
TCP  10.99.128.143:44134 rr
  -> 10.2.12.103:44134            Masq    1      0          0         
TCP  10.101.148.51:8080 rr
  -> 10.2.12.102:8080             Masq    1      0          0         
TCP  10.101.148.51:9093 rr
  -> 10.2.12.102:9093             Masq    1      0          0         
TCP  10.101.148.51:15010 rr
  -> 10.2.12.102:15010            Masq    1      0          0         
TCP  10.101.148.51:15011 rr
  -> 10.2.12.102:15011            Masq    1      0          0         
TCP  10.102.2.50:443 rr
  -> 10.2.0.131:8443              Masq    1      0          0         
UDP  10.96.0.10:53 rr
  -> 10.2.0.129:53                Masq    1      0          0         
  -> 10.2.0.132:53                Masq    1      0          0         
...
```

# Creating sample user

* Create Service Account

`dashboard-adminuser.yaml`

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kube-system
```

* Create ClusterRoleBinding

asumming that cluster-admin exists(provisioned by kubeadmin or kops)

`adminuser-bind-clusteramdin.yaml`

```
apiVersion: rbac.authorization.K8S.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.K8S.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kube-system
```

```
kubectl apply -f dashboard-adminuser.yaml
```

* login with Bearer Token

```
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')
```


# multi-tenant K8S clusters at network-level:

- Namespaces
- Ingress rules
- allow/deny and ingress/egress Network Policies
- Network-aware Zones

# Architect a multi-tenant system with kubernetes
I don't think there is one document out there really summaries everything. The link below is a bit old but can help outline some of the basics on how they build on K8S. Ultimately the primitives are the same but they abstract namespaces a bit and build it around RBAC. Coupled with a default vxlan (isolated) SDN plugin and their ingress routing, its a compelling multi-tenant solution that provides isolation and quotes at multiple levels.

Openshift really just adds some glue (a lot of it being devleoper workflow) on top of Kubernetes. What is nice is that RedHat continues to try and upstream features of origin into K8S where it makes sense.

https://blog.openshift.com/building-kubernetes-bringing-google-scale-container-orchestration-to-the-enterprise/
[https://www.reddit.com/r/kubernetes/comments/6qp24h/ask_kubernetes_how_would_you_architect_a/](https://www.reddit.com/r/kubernetes/comments/6qp24h/ask_kubernetes_how_would_you_architect_a/)
