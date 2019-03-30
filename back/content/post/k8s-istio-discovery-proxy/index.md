+++
title = "K8s Istio Discovery Proxy"
date = 2017-04-30T15:04:55+08:00
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


# 安装

- 启用代理envoy（pilot.sidecar=true）

```
helm install --debug install/kubernetes/helm/istio --name istio --namespace istio-system --set security.enabled=false --set ingress.enabled=false --set gateways.istio-ingressgateway.enabled=false --set gateways.istio-egressgateway.enabled=false --set galley.enabled=false --set mixer.enabled=false --set prometheus.enabled=false --set global.proxy.envoyStatsd.enabled=false --set sidecarInjectorWebhook.enabled=false --set pilot.sidecar=true
```

- 检查POD

istio-pilot包含两个容器： discovery 和 istio-proxy

```
kubectl get pods -n istio-system 
NAME                           READY   STATUS    RESTARTS   AGE
istio-pilot-786dc4c88d-vnsr9   2/2     Running   0          15m
```

- 检查代理

```
kubectl exec -it -n istio-system istio-pilot-786dc4c88d-vnsr9 -c istio-proxy -- bash
# cd /etc/istio/proxy/
# ls
envoy.yaml  envoy_pilot.yaml.tmpl  envoy_policy.yaml.tmpl  envoy_telemetry.yaml.tmpl


# ps fax
  PID TTY      STAT   TIME COMMAND
   64 pts/2    Ss     0:00 bash
   74 pts/2    R+     0:00  \_ ps fax
    1 ?        Ssl    0:00 /usr/local/bin/pilot-agent proxy --serviceCluster istio-pilot --templateFile /etc/istio/proxy/envoy_pilot.yaml.tmpl --controlPlaneAuthPolicy NONE
   15 ?        Sl     0:14 /usr/local/bin/envoy -c /etc/istio/proxy/envoy.yaml --restart-epoch 0 --drain-time-s 2 --parent-shutdown-time-s 3 --service-cluster istio-pilot --service-node sidecar~10.2.12.70
```

- 检查 discovery

```
kubectl exec -it -n istio-system istio-pilot-786dc4c88d-vnsr9 -c discovery -- bash
# ls -l /etc/istio/config/
total 0
lrwxrwxrwx 1 root root 11 Mar 30 06:52 mesh -> ..data/mesh
# ps fax
  PID TTY      STAT   TIME COMMAND
   61 pts/0    Ss     0:00 bash
   71 pts/0    R+     0:00  \_ ps fax
    1 ?        Ssl    1:55 /usr/local/bin/pilot-discovery discovery
```


- 检查日志

```  
PodUID=kubectl get pod istio-pilot-786dc4c88d-vnsr9 -o=jsonpath='{.metadata.uid}'
scp vm4:/var/log/pods/50f3507c-52b8-11e9-9372-08002775f493/istio-proxy/1.log ~./
```

- 检查proxy by adminPort

进入容器查看
```
kubectl exec -it -n istio-system istio-pilot-786dc4c88d-vnsr9 -c discovery -- bash
#curl http://localhost:15000/
```

或本地代理

```
kubectl port-forward -n istio-system istio-pilot-786dc4c88d-vnsr9 15000:15000
```


pilot地址

```
kubectl exec -it -n istio-system istio-pilot-786dc4c88d-vnsr9 -c discovery -- bash
#cat /etc/istio/config/mesh | grep discoveryAddress
```


- pilot-agent

|| default |  debug
  :---|:---|:---
  --log_output_level    |default:info|  default:debug
  --log_stacktrace_level   |default:none|  default:debug

```
Comma-separated minimum per-scope logging level of messages to output, in the form of

 <scope>:<level>,<scope>:<level>,... where scope can be one of [default, model, rbac] 
 
 and level can be one of [debug, info, warn, error, fatal, none] (default `default:info`)
```