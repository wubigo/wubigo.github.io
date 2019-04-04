+++
title = "Envoy Control Plane API Server Testing"
date = 2018-04-04T06:50:43+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["SERVICEMESH"]
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


# graceful shutdown mechanism

```
Get shutdown notice
/healthcheck/fail
Wait X time
Shutdown
```

# BUILD

```
go get -d github.com/envoyproxy/go-control-plane
cd $GOPATH/src/github.com/envoyproxy/go-control-plane
docker build -t bigo/envoy-test:v1 .
```

# TEST XDS in docker


```
docker run -it --rm -e "XDS=ads" bigo/envoy-test:v1  -debug
docker run -it --rm -e "XDS=xds" bigo/envoy-test:v1 -debug
docker run -it --rm -e "XDS=rest" bigo/envoy-test:v1 -debug	
```

# TEST XDS with tls in docker 
```
docker run -it --rm -e "XDS=ads" bigo/envoy-test:v1 -debug -tls
docker run -it --rm -e "XDS=xds" bigo/envoy-test:v1 -debug -tls
docker run -it --rm -e "XDS=rest" bigo/envoy-test:v1 -debug -tls
```  

# Test it in code

在code里面启动ADS API服务器

`pkg/test/main`

`launch.json`

```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Launch",
            "type": "go",
            "request": "launch",
            "mode": "auto",
            "program": "${fileDirname}",
            "env": {},
            "args": ["-debug", "--xds=ads"]
        }
    ]
}
```




```
docker run -it --name envoy  --entrypoint sh bigo/envoy-test:v1
docker cp envoy:/usr/local/bin/envoy  ~/go/bin/

envoy -c sample/bootstrap-ads.yaml --drain-time-s 1 -l debug
```