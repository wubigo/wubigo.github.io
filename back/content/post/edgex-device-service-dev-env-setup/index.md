+++
title = "Edgex Device Service Dev Env Setup"
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

搭建EDGX设备服务开发环境



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

