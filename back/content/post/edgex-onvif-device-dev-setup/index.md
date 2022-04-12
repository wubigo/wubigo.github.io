+++
title = "Edgex Onvif Device Dev Setup"
date = 2022-03-18T10:58:46+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["IOT"]
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


# 启动EDGEX核心服务

## 使用容器主机网络

```
wget https://raw.githubusercontent.com/edgexfoundry/edgex-compose/jakarta/docker-compose-no-secty.yml
```

在开发环境使用host网络，便于核心服务和各种设备能在同一个子网，替换

```
networks:
      edgex-network: {}
```

为
```
network_mode: host
```

### CONSUL

配置CONSUL绑定到指定以太网卡

```
environment:
      CONSUL_BIND_INTERFACE: ens3
```

## 配置DNS

`/etc/hosts`

```
10.166.44.182 edgex-core-consul
10.166.44.182 edgex-core-command
10.166.44.182 edgex-redis
10.166.44.182 edgex-core-metadata
10.166.44.182 edgex-core-data
10.166.44.182 edgex-support-notifications
10.166.44.182 edgex-support-scheduler
10.166.44.182 edgex-ui-go
10.166.44.182 edgex-kuiper
10.166.44.182 edgex-app-rules-engine
```

## 启动核心服务

```
docker-compose -f docker-compose-no-secty.yml up -d 
```

## 检查核心服务启动正常

```
docker logs -f edgex-core-command edgex-core-data edgex-core-metadata
```

# 在本地启动设备服务

```
git clone git@github.com:edgexfoundry/device-camera-go.git
```

修改`cmd\res\configuration.toml`

注册服务，消息队列，核心服务的所在的主机配置

```
[Registry]
Type = "consul"
Host = "10.166.44.182"
Port = 8500

[MessageQueue]
Protocol = "redis"
Host = "10.166.44.182"

[Clients.core-data]
  Protocol = "http"
  Host = "10.166.44.182"
  Port = 59880

  [Clients.core-metadata]
  Protocol = "http"
  Host = "10.166.44.182"
  Port = 59881
```

## 连接ONVIF摄像头

## 启动ONVIF摄像头服务

## 启动设备服务

```
cd device-camera-go/cmd
set EDGEX_SECURITY_SECRET_STORE=false
go run main.go
```

## 查看设备资源

curl -X GET http://10.166.44.182:59882/api/v2/device/name/Camera001

建议：请使用postman测试，

```
            {
                "name": "OnvifSnapshot",
                "get": true,
                "path": "/api/v2/device/name/Camera001/OnvifSnapshot",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "OnvifSnapshot",
                        "valueType": "Binary"
                    }
                ]
            },
            {
                "name": "OnvifHostname",
                "get": true,
                "set": true,
                "path": "/api/v2/device/name/Camera001/OnvifHostname",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "OnvifHostname",
                        "valueType": "String"
                    }
                ]
            }
````

postmana返回的路径可以直接点击，并直接调用相应的资源

```
http://10.166.44.182:59882/api/v2/device/name/Camera001/OnvifSnapshot
```