+++
title = "Envoy NOTES"
date = 2018-03-31T11:16:50+08:00
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

# 术语

- 端点 Envoy discovers the cluster members via EDS
- Management server: A logical server implementing the v2 Envoy APIs
- Upstream: An upstream host receives connections and requests from Envoy and returns responses
- xDS: CDS/EDS/HDS/LDS/RLS/RDS/SDS APIs.
- Configuration Cache: cache Envoy configurations in memory in an attempt to provide fast response to consumer Envoys

The simplest way to use Envoy without providing the control plane in the form of a dynamic API is to add the hardcoded configuration to a static yaml file.


# 参数化定制Envoy镜像

```
clusters:
  - name: myapp_cluster
    connect_timeout: 0.25s
    type: STRICT_DNS
    dns_lookup_family: V4_ONLY
    lb_policy: ${ENVOY_LB_ALG}
    hosts: [{ socket_address: { address: ${SERVICE_NAME}, port_value: 80 }}]
```

`docker-entrypoint.shin` 做环境变量替换

```
#!/bin/sh
set -e

echo "Generating envoy.yaml config file..."
cat /tmpl/envoy.yaml.tmpl | envsubst \$ENVOY_LB_ALG,\$SERVICE_NAME > /etc/envoy.yaml

echo "Starting Envoy..."
/usr/local/bin/envoy -c /etc/envoy.yaml
```

`Dockerfile`

```
FROM envoyproxy/envoy:latest

COPY envoy.yaml /tmpl/envoy.yaml.tmpl
COPY docker-entrypoint.sh /

RUN chmod 500 /docker-entrypoint.sh

RUN apt-get update && \
    apt-get install gettext -y

ENTRYPOINT ["/docker-entrypoint.sh"]
```

# 设置时间

```
docker history  --no-trunc envoyproxy/envoy-dev:48082bcd22fe9165eb73bed6d27857f578df63b5
```

`Dockerfile`

```
FROM envoyproxy/envoy-dev:48082bcd22fe9165eb73bed6d27857f578df63b5
COPY envoy.yaml /etc/envoy/envoy.yaml
RUN  apt-get update && apt-get install -y curl ethtool tzdata && rm -rf /var/cache/apk/*
ENV TZ Asia/Shanghai
# CMD  ["envoy", "-c", "/etc/envoy/envoy.yaml", "-l", "debug"]
```


```
docker build -t envoy:v1 .
```


```
docker run -d --rm --name envoy -p 9901:9901 -p 10000:10000 envoy:v1 envoy -c /etc/envoy/envoy.yaml -l debug

docker exec -it envoy bash
#ps fax
1 ?        Ssl    0:00 envoy -c /etc/envoy/envoy.yaml -l debug
```

# ENVOY配置

Envoy supports multiple configurations:

- static configuration
- API-based configuration
- service-discovery-based configuration


资源类别 ||
:---|:---
listeners | 暴露给外部客户的端点
cluster   | 后台服务集群


- 集群

Clusters are composed of endpoints – a set of network locations that can serve requests for the cluster.  Endpoints can also be defined directly as socket addresses, or read dynamically via the Endpoint Discovery Service


# 监听器

- 监听过滤器（内置）  
  + envoy.client_ssl_auth
  + envoy.echo
  + envoy.http_connection_manager(代理HTTP请求)
       + http_connection_manager.v2.HttpFilter
            + envoy.buffer
            + envoy.cors
            + envoy.fault
            + envoy.gzip
            + envoy.http_dynamo_filter
            + envoy.grpc_http1_bridge
            + envoy.grpc_json_transcoder
            + envoy.grpc_web
            + envoy.health_check
            + envoy.header_to_metadata
            + envoy.ip_tagging
            + envoy.lua
            + envoy.rate_limit
            + envoy.router
            + envoy.squash
  + envoy.mongo_proxy
  + envoy.ratelimit
  + envoy.redis_proxy
  + envoy.tcp_proxy



```
route_config:
   virtual_hosts:
       domains: -> matched against the http requests Host header
```

config envoy by following its api
**api document is automatically generated from protocol buffers**

https://www.envoyproxy.io/docs/envoy/v1.8.0/api-v2/api


以上都是静态资源配置，但是在K8S环境，容器是动态分配的，手动配置无法
保证配置信息同步。于是就需要服务发现功能。ENVOY所需的发现服务包括:

- routes (“what cluster should requests with this HTTP header go to”)[RDS]
- clusters (“what backends does this service have?”)[CDS]
- listener (the filters for a port)[LDS]
- endpoints[EDS]

- v1
  
```
XDS = [ RDS, CDS, LDS, and EDS] 
```
- v2

Health Discovery Service (HDS)

Aggregated Discovery Service (ADS)

Secret Discovery Service (SDS)


- CDS type
  
      Cluster.DiscoveryType

       - STATIC
       - STRICT_DNS
       - LOGICAL_DNS   
       - EDS    ⁣
       - ORIGINAL_DST

```
  clusters:
  - name: service_backend
    type: []
```

istio-pilot是ENVOY发现服务提供者之一，istio-pilot根据K8S API为envoy提供配置routes和clusters服务





```
/envoy/examples/front-proxy$ git diff --word-diff


diff --git a/examples/front-proxy/Dockerfile-frontenvoy b/examples/front-proxy/Dockerfile-frontenvoy
index 83b5ba806..2e203a204 100644
--- a/examples/front-proxy/Dockerfile-frontenvoy
+++ b/examples/front-proxy/Dockerfile-frontenvoy
@@ -1,5 +1,5 @@
FROM envoyproxy/envoy-dev:latest

RUN apt-get update && apt-get -q install -y \
    curl {+tzdata+}
CMD /usr/local/bin/envoy -c /etc/front-envoy.yaml {+-l debug+} --service-cluster front-proxy




diff --git a/examples/front-proxy/Dockerfile-service b/examples/front-proxy/Dockerfile-service
index c3f5bafef..987b21814 100644
--- a/examples/front-proxy/Dockerfile-service
+++ b/examples/front-proxy/Dockerfile-service
@@ -1,6 +1,6 @@
FROM envoyproxy/envoy-alpine-dev:latest

RUN apk update && apk add python3 bash curl {+tzdata+}
RUN pip3 install -q Flask==0.11.1 requests==2.18.4
RUN mkdir /code
ADD ./service.py /code




diff --git a/examples/front-proxy/docker-compose.yml b/examples/front-proxy/docker-compose.yml
index 2c121d598..05d7eb844 100644
--- a/examples/front-proxy/docker-compose.yml
+++ b/examples/front-proxy/docker-compose.yml
@@ -15,6 +15,8 @@ services:
    ports:
      - "8000:80"
      - "8001:8001"
    {+environment:+}
{+      - TZ=Asia/Shanghai+}

  service1:
    build:
@@ -28,8 +30,10 @@ services:
          - service1
    environment:
      - SERVICE_NAME=1
      {+- TZ=Asia/Shanghai+}
    expose:
      - "80"
      

  service2:
    build:
@@ -43,6 +47,7 @@ services:
          - service2
    environment:
      - SERVICE_NAME=2
      {+- TZ=Asia/Shanghai+}
    expose:
      - "80"






diff --git a/examples/front-proxy/start_service.sh b/examples/front-proxy/start_service.sh
index cc529bcf2..57176eff3 100644
--- a/examples/front-proxy/start_service.sh
+++ b/examples/front-proxy/start_service.sh
@@ -1,3 +1,3 @@
#!/bin/sh
python3 /code/service.py &
envoy -c /etc/service-envoy.yaml {+-l debug+} --service-cluster service${SERVICE_NAME}
```


https://jvns.ca/blog/2018/10/27/envoy-basics/

https://blog.envoyproxy.io/the-universal-data-plane-api-d15cec7a
