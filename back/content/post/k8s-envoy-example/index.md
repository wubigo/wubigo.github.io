+++
title = "K8s Envoy Example"
date = 2018-04-02T11:16:05+08:00
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


`envoy.yaml.tmpl`

```
admin:
  access_log_path: /tmp/admin_access.log
  address:
    socket_address: { address: 0.0.0.0, port_value: 9901 }

static_resources:
  listeners:
  - name: listener_0
    address:
      socket_address: { address: 0.0.0.0, port_value: 80 }
    filter_chains:
    - filters:
      - name: envoy.http_connection_manager
        config:
          stat_prefix: ingress_http
          route_config:
            name: local_route
            virtual_hosts:
            - name: local_service
              domains: ["*"]
              routes:
              - match: { prefix: "/" }
                route: { host_rewrite: nginx, cluster: nginx_cluster, timeout: 60s }
          http_filters:
          - name: envoy.router
  clusters:
  - name: nginx_cluster
    connect_timeout: 0.25s
    type: STRICT_DNS
    dns_lookup_family: V4_ONLY
    lb_policy: ${ENVOY_LB_ALG}
    hosts: [{ socket_address: { address: ${SERVICE_NAME}, port_value: 80 }}]

```


`docker-entrypoint.sh`

```
#!/bin/sh
set -e

echo "Generating envoy.yaml config file..."
cat /tmpl/envoy.yaml.tmpl | envsubst \$ENVOY_LB_ALG,\$SERVICE_NAME > /etc/envoy/envoy.yaml

echo "Starting Envoy..."
/usr/local/bin/envoy -c /etc/envoy/envoy.yaml -l debug
```


`Dockerfile`

```
FROM envoyproxy/envoy:latest

COPY /tmpl/envoy.yaml.tmpl /tmpl/envoy.yaml.tmpl
COPY docker-entrypoint.sh /

RUN chmod 500 /docker-entrypoint.sh

RUN apt-get update && \
    apt-get install gettext -y

ENTRYPOINT ["/docker-entrypoint.sh"]
```


```
docker build -t bigo-envoy:v1 .
docker tag bigo-envoy:v1 egistry.cn-beijing.aliyuncs.com/k4s/bigo-envoy:v1
docker push registry.cn-beijing.aliyuncs.com/k4s/bigo-envoy:v1


docker network create test
docker run -dit --name nginx --network test nginx:alpine

docker run -it --rm --name envoy --network test -e ENVOY_LB_ALG=LEAST_REQUEST -e SERVICE_NAME=nginx  bigo-envoy:v1

ENVOY_IP=$(docker inspect envoy --format='{{.NetworkSettings.Networks.test.IPAddress}}')

curl $ENVOY_IP

docker logs nginx | grep $ENVOY_IP

172.18.0.3 - [02/Apr/2019:05:59:12 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.47.0" "-"
```