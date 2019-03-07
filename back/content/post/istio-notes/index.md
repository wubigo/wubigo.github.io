+++
title = "Istio Notes"
date = 2017-03-04T16:38:38+08:00
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

# 准备

```
docker pull istio/proxyv2:1.0.6
docker tag istio/proxyv2:1.0.6 gcr.io/istio-release/proxyv2:release-1.0-latest-daily
docker push  registry.cn-beijing.aliyuncs.com/co1/istio_proxyv2:1.0.6
docker pull istio/pilot:1.0.6
docker tag istio/pilot:1.0.6 gcr.io/istio-release/pilot:release-1.0-latest-daily
docker pull istio/mixer:1.0.6
docker tag istio/mixer:1.0.6 gcr.io/istio-release/mixer:release-1.0-latest-daily
docker pull istio/galley:1.0.6
docker tag istio/galley:1.0.6 gcr.io/istio-release/galley:release-1.0-latest-daily
docker pull istio/citadel:1.0.6
docker tag istio/citadel:1.0.6 gcr.io/istio-release/citadel:release-1.0-latest-daily
docker pull istio/sidecar_injector:1.0.6
docker tag istio/sidecar_injector:1.0.6 gcr.io/istio-release/sidecar_injector:release-1.0-latest-daily


git clone https://github.com/istio/istio.git
cd istio
git checkout 1.0.6 -b 1.0.6
````

# 安装

Istio by default uses LoadBalancer service object types. Some platforms do not support LoadBalancer service objects. For platforms lacking LoadBalancer support, install Istio with NodePort support instead with the flags --set gateways.istio-ingressgateway.type=NodePort --set gateways.istio-egressgateway.type=NodePort appended to the end of the Helm operation.

```
helm install install/kubernetes/helm/istio --name istio --namespace istio-system --set gateways.istio-ingressgateway.type=NodePort --set gateways.istio-egressgateway.type=NodePort
```

# 精简安装

```
helm install -v install/kubernetes/helm/istio --name istio --namespace istio-system \
  --set security.enabled=false \
  --set ingress.enabled=false \
  --set gateways.istio-ingressgateway.enabled=false \
  --set gateways.istio-egressgateway.enabled=false \
  --set galley.enabled=false \
  --set sidecarInjectorWebhook.enabled=false \
  --set mixer.enabled=false \
  --set prometheus.enabled=false \
  --set global.proxy.envoyStatsd.enabled=false \
  --set pilot.sidecar=false \
  --set gateways.istio-ingressgateway.type=NodePort \
  --set gateways.istio-egressgateway.type=NodePort
```

Ensure the istio-pilot-* Kubernetes pod is deployed and its container is up and running:

```
kubectl get pods -n istio-system
```

# 删除

```
helm delete --purge istio
kubectl -n istio-system delete job --all
kubectl delete -f install/kubernetes/helm/istio/templates/crds.yaml -n istio-system
```

https://istio.io/docs/concepts/traffic-management/