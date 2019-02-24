---
layout: post
title: Dgraph note
date: 2018-04-07
tags: ["NOSQL", "GRAPH"]
---

# Start Dgraph cluster
```
dgraph zero
```

# start Dgraph server
```
 dgraph server --memory_mb 2048 --zero localhost:5080 --port_offset 2000

 Note:port_offsetValue added to all listening port numbers. [Internal=7080, HTTP=8080, Grpc=9080]

```

# How do I configure Go to use a proxy
[https://stackoverflow.com/questions/10383299/how-do-i-configure-go-to-use-a-proxy](https://stackoverflow.com/questions/10383299/how-do-i-configure-go-to-use-a-proxy)

# Web based graph visualization with D3 and KeyLines
[https://cambridge-intelligence.com/web-graph-visualization-d3-keylines/](https://cambridge-intelligence.com/web-graph-visualization-d3-keylines/)

# SETUP CLIENT

```
set http_proxy=192.168.0.119:3128
git config --global http.proxy http://192.168.0.119:3128
go get -u github.com/derekparker/delve/cmd/dlv
go get -u -v github.com/dgraph-io/dgo
```
