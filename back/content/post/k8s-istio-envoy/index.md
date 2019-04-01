+++
title = "K8s Istio Envoy"
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