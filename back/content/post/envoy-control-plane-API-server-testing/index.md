+++
title = "Envoy Control Plane API Server Testing"
date = 2018-04-04T06:50:43+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["SERVICEMESH", "MICROSERVICE"]
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

# SNAPSHOT

```
// Snapshot is an internally consistent snapshot of xDS resources.
// Consistentcy is important for the convergence as different resource types
// from the snapshot may be delivered to the proxy in arbitrary order.
type Snapshot struct {
	// Endpoints are items in the EDS response payload.
	Endpoints Resources

	// Clusters are items in the CDS response payload.
	Clusters Resources

	// Routes are items in the RDS response payload.
	Routes Resources

	// Listeners are items in the LDS response payload.
	Listeners Resources

	// Secrets are items in the SDS response payload.
	Secrets Resources
}

```


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



在主机上运行

```
docker run -it --name envoy  --entrypoint sh bigo/envoy-test:v1
docker cp envoy:/usr/local/bin/envoy  ~/go/bin/

envoy -c /sample/bootstrap-ads.yaml --drain-time-s 1 -l debug

[source/server/server.cc:270] admin address: 127.0.0.1:19000

```

在容器内运行

```
docker run -it --rm --name envoy  --entrypoint sh bigo/envoy-test:v1
```

修改配置
`/sample/bootstrap-ads.yaml`

允许远程访问代理服务器管理端口

```
admin:
  address:
    socket_address:
      address: 0.0.0.0
```

```
docker cp sample/bootstrap-ads.yaml envoy:/sample/bootstrap-ads.yaml
#envoy -c /sample/bootstrap-ads.yaml --drain-time-s 1
```

```
查询容器IP

http://172.17.0.2:19000/clusters

xds_cluster::192.168.1.5:28000::cx_connect_fail::6
```

如果管理服务器没有启动，会出现连接失败计数。




通过manager server下发配置

```
docker run -it --rm -e "XDS=ads" bigo/envoy-test:v1  -debug
```

再次检查ENVOY的配置

`http://localhost:19000/config_dump`


# Bootstrap configuration

To use the v2 API, it’s necessary to supply a bootstrap configuration file. 
This provides static server configuration and configures Envoy to access 
dynamic configuration if needed. This is supplied on the command-line
via the -c flag

```
./envoy -c <path to config>.{json,yaml,pb,pb_text}
```

The Bootstrap message is the root of the configuration.
Resources such as a Listener or Cluster may be supplied either 
statically in static_resources or have an xDS service such as
LDS or CDS configured in dynamic_resources.

# Envoy Initialization

- During startup, the cluster manager goes through a multi-phase initialization where it first initializes static/DNS clusters, then predefined EDS clusters. Then it initializes CDS if applicable, waits for one response (or failure), and does the same primary/secondary initialization of CDS provided clusters.

- If clusters use active health checking, Envoy also does a single active health check round.
- Once cluster manager initialization is done, RDS and LDS initialize (if applicable). The server doesn’t start accepting connections until there has been at least one response (or failure) for LDS/RDS requests.
- If LDS itself returns a listener that needs an RDS response, Envoy further waits until an RDS response (or failure) is received. Note that this process takes place on every future listener addition via LDS and is known as listener warming.
- After all of the previous steps have taken place, the listeners start accepting new connections. This flow ensures that during hot restart the new process is fully capable of accepting and processing new connections before the draining of the old process begins.