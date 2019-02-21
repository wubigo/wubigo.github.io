---
layout: post
title: Dockerfile
date: 2011-01-01
tag: Docker
---

# tiller (tag=$(tiller version))

```
FROM alpine:3.8

RUN apk update && apk add ca-certificates socat && rm -rf /var/cache/apk/*

ENV HOME /tmp

COPY tiller /tiller

EXPOSE 44134
USER 65534
ENTRYPOINT ["/tiller"]

```