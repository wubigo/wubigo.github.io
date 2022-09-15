+++
title = "IOT Notes"
date = 2018-01-29T18:20:21+08:00
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




The dispersed nature of the Internet of Things (IoT) presents a major operational challenge that is uncommon in the traditional Internet or enterprise networks[5]. Devices that are managed together --- say a fleet of railcars --- are not physically colocated. Instead, they are widely geographically distributed. The operational approaches for management and security used in enterprise networks, where most hosts are densely contained in buildings or campuses, do not translate to the IoT. IoT devices operate outside of the enterprise network security and operational perimeter and the corporate LAN firewall can’t protect them. Dispatching technicians is expensive, so manual provisioning and configuration doesn’t scale. Devices connect to the Internet via a variety of last-mile ISPs, so many devices won’t share share a common IP prefix and addresses will change at arbitrary times. Any configuration based on these IPs will require continued upkeep and will often be out-of-date, exposing hosts and devices to external threats.




物联网的协议分为两种，即接入协议与通讯协议。接入协议大多不属于TCP/IP协议族，只能用于设备子网（设备与网关组成的局域网）内的通讯；而通讯协议属于TCP/IP协议族，能够在互联网中进行数据传输
![](/img/post/iot-access.jpeg)





第一句话

物联网的协议分为两种，即接入协议与通讯协议。接入协议大多不属于TCP/IP协议族，只能用于设备子网（设备与网关组成的局域网）内的通讯；而通讯协议属于TCP/IP协议族，能够在互联网中进行数据传输。

第二句话

采用接入协议的物联网设备，需要通过网关进行协议转换，转换成通讯协议才能接入互联网。而采用通讯协议的物联网设备，则可以直接接入互联网。

第三句话

常用的接入协议包括蓝牙、ZigBee、LoRa、NB-IoT、Wifi、RS485、RS232、NFC、RFID等；常用的通讯协议包括HTTP、CoAP、MQTT、XMPP、AMQP、JMS等。


