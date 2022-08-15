+++
title = "搭建Edgex设备服务开发环境"
date = 2022-03-11T15:39:42+08:00
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

搭建EDGEX设备服务开发环境

# EDGEX简介

EdgeX Foundry 项目成立于2017年，由Linux 基金会主持，目前已经拥有75个会员， 包括重量级的SAMSUNG，Dell，AMD，ANALOG DEVICES ... 但其中最重要的角色其实是戴尔。它为EdgeX Foundry提供该公司采用Apache 2.0许可证的FUSE源代码。FUSE包括10多种微服务和12500多万行代码，它们在连接标准、边缘分析、安全、系统管理和服务之间提供了互操作性。FUSE 是Dell 为了拓展边缘计算物联网服务而发展出来的，基于Java SPRING CLOUD 的微服务框架软件。这套软件最大的特征是中立于任何硬件平台和操作系统，高度模块化，可自由扩展。Dell 从私有化完成的那天开始，我们见到它一系列的并购，其中并购VMware，EMC 等动作，都直接剑指云计算和物联网技术。FUSE 的发布，更昭示了Dell谋求转型的决心。物联网的繁荣非常地依赖于物联网生态企业，全球大型IT 公司谋求物联网布局，都会提供框架软件，再培养生态伙伴来形成落地应用。而在生态伙伴的培养过程中，开源的基础框架软件是非常容易被理解和吸收的。 这也是Dell 选择跟Linux 基金会合作，并捐赠和完善代码的重要原因：Dell 需要庞大的生态伙伴，而Linux 具有开源软件界强大的号召力和影响力。

EdgeX Foundry原来是用Java写的，导致平台体积庞大，占用资源，后来Linux基金会用Go语言对其进行了重构.


EdgeX Foundry是一系列松耦合、开源的微服务集合。该微服务集合构成了四个微服务层及两个增强的基础系统服务，这四个微服务层包含了从物理域数据采集到信息域数据处理等一系列的服务，另外两个基础系统服务为该四个服务层提供支撑服务。

四个微服务层分别是：

- 设备服务负责采集数据及控制设备功能。
- 核心服务负责本地存储分析和转发数据，以及控制命令下发。
- 支持服务负责日志记录、任务调度、数据清理、规则引擎和告警通知。
- 应用服务/导出服务负责上传数据到云端或第三方信息系统，以及接收控制命令转发给核心服务。

两个增强基础系统服务：

安全服务、管理服务这两个软件模块虽然不直接处理边缘计算的功能性业务，但是对于边缘计算的安全性和易用性来说很重要



![](/img/post/edgex-svr.png)





# 启动EDGEX核心服务

```
wget https://raw.githubusercontent.com/edgexfoundry/edgex-compose/jakarta/docker-compose-no-secty.yml


 docker-compose -f docker-compose-no-secty.yml up -d
```

# 打开数据和控制服务调试开关

在consul里面配置应用：

http://localhost:8500/ui/dc1/kv/edgex/appservices/2.0/app-rules-engine/Writable/LogLevel/edit

修改INFO为DEBUG



# 在IDE里面启动设备服务

以IP摄像头设备服务为例

## 打开WEBCAM

[webcam-to-ip-camera](https://wubigo.com/post/webcam-to-ip-camera/)

## 配置开发环境

```
git clone git@github.com:edgexfoundry/device-camera-go.git
git checkout jakarta
cd device-camera-go
go mod tidy
set EDGEX_SECURITY_SECRET_STORE=false
```

调整IDE的当前工作目录为：device-camera-go\cmd
否则，设备服务启动会找不到设备配置文件。

或者移动资源文件到IDE当前工作目录

```
mv -rf cmd/res  .
```

## 打开设备服务调试日志并启动设备服务

```
res/configuration.toml
@@ -1,5 +1,5 @@
 [Writable]
-LogLevel = "INFO"
+LogLevel = "DEBUG"



level=INFO ts=2022-03-11T08:13:54.8106393Z app=device-camera source=devices.go:87 msg="Device Camera001 not found in Metadata, adding it ..."        
level=INFO ts=2022-03-11T08:13:54.8133486Z app=device-camera source=autodiscovery.go:33 msg="AutoDiscovery stopped: disabled by configuration"       
level=INFO ts=2022-03-11T08:13:54.813521Z app=device-camera source=autodiscovery.go:42 msg="AutoDiscovery stopped: ProtocolDiscovery not implemented"
level=INFO ts=2022-03-11T08:13:54.8137182Z app=device-camera source=message.go:50 msg="Service dependencies resolved..."
level=INFO ts=2022-03-11T08:13:54.8137182Z app=device-camera source=message.go:51 msg="Starting device-camera to be replaced by makefile "
level=INFO ts=2022-03-11T08:13:54.8137182Z app=device-camera source=message.go:55 msg="Camera device service started"
level=INFO ts=2022-03-11T08:13:54.8137182Z app=device-camera source=message.go:58 msg="Service started in: 649.0037ms"

```

## 在edgex-device-rest日志查看启动的设备服务

```
docker logs -f edgex-device-rest
```



## 配置设备文件

```
[[DeviceList]]
Name = "Camera001"
ProfileName = "camera-bosch"
Location = "edgex lab"
  [DeviceList.Protocols]
    [DeviceList.Protocols.HTTP]
    Address = "localhost:56000"
```

## 设备数据采集和控制

### 查看设备所有的资源

通过EDGEX元数据服务查看设备资源

```
curl -X GET http://localhost:59882/api/v2/device/name/Camera001
{
    "apiVersion": "v2",
    "statusCode": 200,
    "deviceCoreCommand": {
        "deviceName": "Camera001",
        "profileName": "camera-bosch",
        "coreCommands": [
            {
                "name": "OnvifProfileInformation",
                "get": true,
                "set": true,
                "path": "/api/v2/device/name/Camera001/OnvifProfileInformation",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "OnvifProfileInformation",
                        "valueType": "String"
                    }
                ]
            },
            {
                "name": "TamperDetected",
                "get": true,
                "path": "/api/v2/device/name/Camera001/TamperDetected",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "TamperDetected",
                        "valueType": "Bool"
                    }
                ]
            },
            {
                "name": "occupancy",
                "get": true,
                "path": "/api/v2/device/name/Camera001/occupancy",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "occupancy",
                        "valueType": "Uint32"
                    }
                ]
            },
            {
                "name": "OnvifReboot",
                "get": true,
                "set": true,
                "path": "/api/v2/device/name/Camera001/OnvifReboot",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "OnvifReboot",
                        "valueType": "Bool"
                    }
                ]
            },
            {
                "name": "counter",
                "get": true,
                "path": "/api/v2/device/name/Camera001/counter",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "counter",
                        "valueType": "Uint32"
                    }
                ]
            },
            {
                "name": "OnvifDeviceInformation",
                "get": true,
                "set": true,
                "path": "/api/v2/device/name/Camera001/OnvifDeviceInformation",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "OnvifDeviceInformation",
                        "valueType": "String"
                    }
                ]
            },
            {
                "name": "OnvifDateTime",
                "get": true,
                "set": true,
                "path": "/api/v2/device/name/Camera001/OnvifDateTime",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "OnvifDateTime",
                        "valueType": "String"
                    }
                ]
            },
            {
                "name": "OnvifDns",
                "get": true,
                "set": true,
                "path": "/api/v2/device/name/Camera001/OnvifDns",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "OnvifDns",
                        "valueType": "String"
                    }
                ]
            },
            {
                "name": "OnvifNetworkProtocols",
                "get": true,
                "set": true,
                "path": "/api/v2/device/name/Camera001/OnvifNetworkProtocols",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "OnvifNetworkProtocols",
                        "valueType": "String"
                    }
                ]
            },
            {
                "name": "OnvifNetworkDefaultGateway",
                "get": true,
                "set": true,
                "path": "/api/v2/device/name/Camera001/OnvifNetworkDefaultGateway",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "OnvifNetworkDefaultGateway",
                        "valueType": "String"
                    }
                ]
            },
            {
                "name": "OnvifNetworkInterfaces",
                "get": true,
                "set": true,
                "path": "/api/v2/device/name/Camera001/OnvifNetworkInterfaces",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "OnvifNetworkInterfaces",
                        "valueType": "String"
                    }
                ]
            },
            {
                "name": "OnvifNtp",
                "get": true,
                "set": true,
                "path": "/api/v2/device/name/Camera001/OnvifNtp",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "OnvifNtp",
                        "valueType": "String"
                    }
                ]
            },
            {
                "name": "OnvifUsers",
                "get": true,
                "set": true,
                "path": "/api/v2/device/name/Camera001/OnvifUsers",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "OnvifUsers",
                        "valueType": "String"
                    }
                ]
            },
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
                "name": "OnvifUser",
                "get": true,
                "set": true,
                "path": "/api/v2/device/name/Camera001/OnvifUser",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "OnvifUser",
                        "valueType": "String"
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
            },
            {
                "name": "MotionDetected",
                "get": true,
                "path": "/api/v2/device/name/Camera001/MotionDetected",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "MotionDetected",
                        "valueType": "Bool"
                    }
                ]
            },
            {
                "name": "OnvifStreamURI",
                "get": true,
                "path": "/api/v2/device/name/Camera001/OnvifStreamURI",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "OnvifStreamURI",
                        "valueType": "String"
                    }
                ]
            },
            {
                "name": "OnvifHostnameFromDHCP",
                "get": true,
                "set": true,
                "path": "/api/v2/device/name/Camera001/OnvifHostnameFromDHCP",
                "url": "http://edgex-core-command:59882",
                "parameters": [
                    {
                        "resourceName": "OnvifHostnameFromDHCP",
                        "valueType": "Bool"
                    }
                ]
            }
        ]
    }
}
```

### 访问设备资源

设备的资源地址为上面接口返回的信息：url+path  (设备控制服务)

例如: [OnvifHostnameFromDHCP](http://edgex-core-command:59882/api/v2/device/name/Camera001/OnvifHostnameFromDHCP)

设备控制服务会调用实际的设备服务的API:

```
docker logs -f edgex-core-command 

edgex-core-command           | level=ERROR ts=2022-03-11T08:23:01.759949942Z app=core-command source=http.go:47 X-Correlation-ID=8a4c186d-6f40-464f-be03-b5e67c866d3b msg="failed to send a http request -> Get \"http://localhost:59985/api/v2/device/name/Camera001/OnvifHostname\": dial tcp 127.0.0.1:59985: connect: connection refused"
```

因为设备服务启动的时候，配置的ip为LOCALHOST, 容器内现在无法访问到设备服务实例API, 所以连接拒绝

在设备服务所在网络浏览器直接上面的地址即可


# 清理测试环境

```
docker-compose -f docker-compose-no-secty.yml down
docker volume rm $(docker volume ls -q)
```

