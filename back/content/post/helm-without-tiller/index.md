+++
title = "避开Tiller使用Helm部署K8S应用"
date = 2018-06-04T21:02:56+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["K8S", "DEVOPS"]
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

避开Tiller使用Helm部署K8S应用

# Tiller存在的问题

- 破坏RBAC访问机制

全局的Tiller拥有cluster-admin角色，所以在安装过程中，服务以cluster-admin
角色可以越权访问资源

- 部署名字不能重复且唯一

部署名字唯一且很多chart中部署名字也添加到服务名中，导致服务名字混乱。

# 独立使用helm

- 获取模板
- 使用配置修改模板
- 生产yaml文件

```
git clone https://github.com/istio/istio.git
cd istio
git checkout 1.0.6 -b 1.0.6
helm template install/kubernetes/helm/istio --name istio --namespace istio-system \
  --set security.enabled=false \
  --set ingress.enabled=false \
  --set gateways.istio-ingressgateway.enabled=false \
  --set gateways.istio-egressgateway.enabled=false \
  --set galley.enabled=false \
  --set sidecarInjectorWebhook.enabled=false \
  --set mixer.enabled=false \
  --set prometheus.enabled=false \
  --set global.proxy.envoyStatsd.enabled=false \
  --set pilot.sidecar=false > $HOME/istio-minimal.yaml

kubectl create namespace istio-system
kubectl apply -f $HOME/istio-minimal.yaml
```

