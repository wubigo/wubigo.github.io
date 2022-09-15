+++
title = "K8s Pod Command Override"
date = 2019-03-18T14:49:10+08:00
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

K8S POD Command Override OCR


# docker Entrypoint vs k8s command

| |  docker | k8s
:---|:---|:---
entry |ENTRYPOINT| command
arguments |CMD| args

**k8s command and args override the default OCR Entrypoint and Cmd**

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