+++
title = "容器工具--Skafflod"
date = 2020-10-29T09:36:06+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = []
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

## 安装kubectl 

```
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF  
apt-get update
apt-get install -y kubectl=1.18.3-00
```

- Installing bash completion on Linux

```
kubectl completion bash > ~/.kube/kubectl.bash.inc
printf "
# Kubectl shell completion
source '$HOME/.kube/kubectl.bash.inc'
" >> $HOME/.bashrc
source $HOME/.bashrc
```

## 

```
git clone git@github.com:GoogleCloudPlatform/microservices-demo.git 
```


## 

```
cat /etc/docker/daemon.json

{
  "insecure-registries" : ["10.8.5.211"]
}

```

##  

`microservices-demo/src/shippingservice/Dockerfile`


```
RUN go env -w GOPROXY=https://goproxy.cn,direct 
```


`microservices-demo/src/recommendationservice/Dockerfile`

```
ENV DISABLE_DEBUGGER=1
ENV DISABLE_PROFILER=1
```

## 

```
skaffold run --default-repo=10.8.5.211/library
```



```
kubectl port-forward deployment/frontend 8080:8080
```