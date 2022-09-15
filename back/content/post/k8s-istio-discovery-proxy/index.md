+++
title = "K8s Istio Pilot as envoy control place"
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

 # side car proxy

 - 方法1

Namespace labels

```
kubectl label ns servicea istio-injection=enabled
```

Istio watches over all the deployments and adds the side car container to our pods.This is achieved by leveraging what is called MutatingAdmissionWebhooks, this feature was introduced in Kubernetes 1.9. So before the resources get created, the web hook intercepts the requests, checks if “Istio injection” is enabled for that namespace, and then adds the side car container to the pod

- istioctl command line tool
  





PILOT = ENVOY CONTROL PLANE API SERVER

![](./PilotAdapters.svg)

Pilot maintains a canonical representation of services in the mesh that is independent of the underlying platform. Platform-specific adapters in Pilot are responsible for populating this canonical model appropriately. For example, the Kubernetes adapter in Pilot implements the necessary controllers to watch the Kubernetes API server for changes to the pod registration information, ingress resources, and third-party resources that store traffic management rules. This data is translated into the canonical representation. An Envoy-specific configuration is then generated based on the canonical representation

Pilot enables service discovery, dynamic updates to load balancing pools and routing tables.

You can specify high-level traffic management rules through Pilot’s Rule configuration. These rules are translated into low-level configurations and distributed to Envoy instances



# K8S KUBE-PROXY

Kubernetes services take care of maintaining the list of Pod endpoints it can route traffic to. And usually kube-proxy does the load balancing between these pod endpoints. ENVOY client side load balancing do not want kube-proxy to load balance, we want to get the list of Pod endpoints and load balance it ourselves. For this we can use a “headless service”, which will just return the list of endpoints. 


- Client-side Load Balancing

Many are familiar with what server-side load balancing is but the lesser known, client-side load balancing, has begun to climb in popularity due to SOA and microservices. Instead of relying on another service to distribute the load, the client itself, is responsible for deciding where to send the traffic also using an algorithm like round-robin. It can either discover the instances, via service discovery, or can be configured with a predefined list. Netflix Ribbon is an example of a client-side load balancer.




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
PodUID=${kubectl get pod -n istio-system istio-pilot-786dc4c88d-vnsr9 -o=jsonpath='{.metadata.uid}}'
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

istio-pilot:release-1.0-latest-daily没有把服务端口通过EXPOSE暴露，
通过inspect查找

```
kubectl exec -n istio-system istio-pilot-786dc4c88d-ls2z6  -c discovery env | grep "ISTIO_PILOT"
ISTIO_PILOT_PORT=tcp://10.111.94.9:15010
ISTIO_PILOT_PORT_8080_TCP_ADDR=10.111.94.9
ISTIO_PILOT_SERVICE_PORT_HTTP_MONITORING=9093
ISTIO_PILOT_PORT_15010_TCP_PROTO=tcp
ISTIO_PILOT_PORT_15010_TCP_PORT=15010
ISTIO_PILOT_SERVICE_PORT=15010
ISTIO_PILOT_PORT_15011_TCP=tcp://10.111.94.9:15011
ISTIO_PILOT_PORT_15011_TCP_PROTO=tcp
ISTIO_PILOT_PORT_9093_TCP_PROTO=tcp
ISTIO_PILOT_SERVICE_PORT_HTTP_LEGACY_DISCOVERY=8080
ISTIO_PILOT_PORT_15011_TCP_PORT=15011
ISTIO_PILOT_PORT_8080_TCP=tcp://10.111.94.9:8080
ISTIO_PILOT_PORT_8080_TCP_PROTO=tcp
ISTIO_PILOT_SERVICE_PORT_HTTPS_XDS=15011
ISTIO_PILOT_PORT_9093_TCP=tcp://10.111.94.9:9093
ISTIO_PILOT_SERVICE_PORT_GRPC_XDS=15010
ISTIO_PILOT_PORT_8080_TCP_PORT=8080
ISTIO_PILOT_PORT_9093_TCP_ADDR=10.111.94.9
ISTIO_PILOT_SERVICE_HOST=10.111.94.9
ISTIO_PILOT_PORT_15010_TCP=tcp://10.111.94.9:15010
ISTIO_PILOT_PORT_15010_TCP_ADDR=10.111.94.9
ISTIO_PILOT_PORT_15011_TCP_ADDR=10.111.94.9
ISTIO_PILOT_PORT_9093_TCP_PORT=9093

```



```
docker inspect --format='{{range .Config.Env}}{{println .}}{{end}}' istio-pilot

docker inspect --format='{{range .Config.Env}}{{println .}}{{end}}' ab92d1c866ce | grep "ISTIO_PILOT_*"


ISTIO_PILOT_PORT=tcp://10.111.94.9:15010
ISTIO_PILOT_PORT_8080_TCP_ADDR=10.111.94.9
ISTIO_PILOT_SERVICE_PORT_HTTP_MONITORING=9093
ISTIO_PILOT_PORT_15010_TCP_PROTO=tcp
ISTIO_PILOT_PORT_15010_TCP_PORT=15010
ISTIO_PILOT_SERVICE_PORT=15010
ISTIO_PILOT_PORT_15011_TCP=tcp://10.111.94.9:15011
ISTIO_PILOT_PORT_15011_TCP_PROTO=tcp
ISTIO_PILOT_PORT_9093_TCP_PROTO=tcp
ISTIO_PILOT_SERVICE_PORT_HTTP_LEGACY_DISCOVERY=8080
ISTIO_PILOT_PORT_15011_TCP_PORT=15011
ISTIO_PILOT_PORT_8080_TCP=tcp://10.111.94.9:8080
ISTIO_PILOT_PORT_8080_TCP_PROTO=tcp
ISTIO_PILOT_SERVICE_PORT_HTTPS_XDS=15011
ISTIO_PILOT_PORT_9093_TCP=tcp://10.111.94.9:9093
ISTIO_PILOT_SERVICE_PORT_GRPC_XDS=15010
ISTIO_PILOT_PORT_8080_TCP_PORT=8080
ISTIO_PILOT_PORT_9093_TCP_ADDR=10.111.94.9
ISTIO_PILOT_SERVICE_HOST=10.111.94.9
ISTIO_PILOT_PORT_15010_TCP=tcp://10.111.94.9:15010
ISTIO_PILOT_PORT_15010_TCP_ADDR=10.111.94.9
ISTIO_PILOT_PORT_15011_TCP_ADDR=10.111.94.9
ISTIO_PILOT_PORT_9093_TCP_PORT=9093
```



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

-  调试istio-discovery

```
kubectl get deployments  -n istio-system -o json > istio.k8s.deployment.json
```

discovery调试信息**--log_output_level**

```
                       "args": [
                            "discovery", "--log_output_level", "default:debug"
                        ]
                        
```


proxy调试信息(/usr/local/bin/proxy -l debug)

proxy被pilot-agent启动，所以调试日志还是和discovery一样

```
                        "args": [
                             "proxy",
                                    "--serviceCluster",
                                    "istio-pilot",
                                    "--templateFile",
                                    "/etc/istio/proxy/envoy_pilot.yaml.tmpl",
                                    "--controlPlaneAuthPolicy",
                                    "NONE",
                                    "--log_output_level", "default:debug"       
                        ]
```



```
kubectl apply -f istio.k8s.deployment.json
```


```
kubectl exec -it -n istio-system istio-pilot-84678c759f-qjbf4 -c discovery -- bash
root@istio-pilot-84678c759f-qjbf4:/# ps -fax
  PID TTY      STAT   TIME COMMAND
   28 pts/0    Ss     0:00 bash
   39 pts/0    R+     0:00  \_ ps -fax
    1 ?        Ssl    0:28 /usr/local/bin/pilot-discovery discovery --log_output_level default:debug
```

- 下载配置

```
kubectl cp istio-system/istio-pilot-b8d58697f-5nthh:etc/istio/proxy/envoy.yaml ./ -c istio-proxy
```

```
PodUID=${kubectl get pod -n istio-system istio-pilot-786dc4c88d-vnsr9 -o=jsonpath='{.metadata.uid}'
kubectl cp istio-system/istio-pilot-b8d58697f-5nthh:/etc/istio/proxy/envoy.yaml ./ -c istio-proxy
```




```
Adding Kubernetes registry adapter

2019-04-03T06:43:56.839512Z	info	Primary Cluster name: Kubernetes
2019-04-03T06:43:56.839600Z	info	Service controller watching namespace "" for service, endpoint, nodes and pods, refresh 60000000000
gc 4 @4.096s 4%: 0.043+22+4.4 ms clock, 0.087+1.2/6.0/13+8.9 ms cpu, 5->5->3 MB, 6 MB goal, 2 P
2019-04-03T06:43:56.852472Z	debug	empty Webhook API endpoint.
2019-04-03T06:43:56.875696Z	info	ads	Starting ADS server with throttle=25 burst=100
2019-04-03T06:43:56.879233Z	info	Setting up event handlers
2019-04-03T06:43:56.879495Z	info	Discovery service started at http=[::]:8080 grpc=[::]:15010
```