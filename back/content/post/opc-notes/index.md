+++
title = "Opc Notes"
date = 2019-08-25T15:10:44+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["IIOT"]
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


# 工业物联网OSI参考模型

```
软件接口	            OPC
应用层	              ModBus
数据链路层	          CAN，ProfiBus
物理层	              RS232，RS485
```


# OPC服务器

OPC SERVER = OPC驱动器


# OPC


简单来说，OPC是一套标准，其目的是把PLC特定的协议（如Modbus，Profibus等）抽象成为标准化的接口，作为“中间人”的角色把通用的OPC“读写”请求转换成具体的设备协议来与HMI/SCADA系统直接对接

When the standard was first released in 1996, its purpose was to abstract PLC specific protocols (such as Modbus, Profibus, etc.) into a standardized interface allowing HMI/SCADA systems to interface with a “middle-man” who would convert generic-OPC read/write requests into device-specific requests and vice-versa.