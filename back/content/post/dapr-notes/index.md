+++
title = "Dapr Notes"
date = 2020-08-25T14:46:47+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["CLOUD", "DOCKER"]
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


# 重新安装


**Ensure that Docker Desktop is set to Linux containers mode when you run Dapr in self hosted mode**


```
d:\code>dapr uninstall
Removing Dapr from your machine...
Removing directory: C:\Users\wubigo\.dapr\bin
Removing container: dapr_placement
Dapr has been removed successfully


d:\code>dapr init
Making the jump to hyperspace...
Installing runtime version 1.6.0
Downloading binaries and setting up components...
Downloaded binaries and completed components set up.
daprd binary has been installed to C:\Users\wubigo\.dapr\bin.
dapr_placement container is running.
dapr_redis container is running.
dapr_zipkin container is running.
Use `docker ps` to check running containers.


d:\code>dapr -v
CLI version: 1.6.0
Runtime version: 1.6.0



d:\code>docker ps
CONTAINER ID   IMAGE               COMMAND                  CREATED          STATUS                    PORTS                              NAMES
6dc4fde182b2   daprio/dapr:1.6.0   "./placement"             dapr_placement
303f02455ea0   openzipkin/zipkin   "start-zipkin"            dapr_zipkin
6b1ccff548ba   redis               "docker-entrypoint.s…"    dapr_redis
```

# 源代码

## 默认的日志级别

`github.com/dapr/kit@logger\options.go`

```
const (
	defaultJSONOutput  = false
	defaultOutputLevel = "debug"
	undefinedAppID     = ""
)
```








