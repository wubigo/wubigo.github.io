+++
title = "K8s Istio Envoy"
date = 2019-03-31T11:16:50+08:00
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


```
docker history  --no-trunc envoyproxy/envoy-dev:48082bcd22fe9165eb73bed6d27857f578df63b5
```

`Dockerfile`

```
FROM envoyproxy/envoy-dev:48082bcd22fe9165eb73bed6d27857f578df63b5
COPY envoy.yaml /etc/envoy/envoy.yaml
RUN  apt-get update && apt-get install -y curl ethtool && rm -rf /var/cache/apk/*
# CMD  ["envoy", "-c", "/etc/envoy/envoy.yaml", "-l", "debug"]
```


```
docker build -t envoy:v1 .
```


```
docker run -d --rm -v /etc/timezone:/etc/timezone:ro --name envoy -p 9901:9901 -p 10000:10000 envoy:v1 envoy -c /etc/envoy/envoy.yaml -l debug

docker exec -it envoy bash
#ps fax
1 ?        Ssl    0:00 envoy -c /etc/envoy/envoy.yaml -l debug
```

