+++
title = "Connect KEPServer to Ali IoT"
date = 2021-12-16T13:40:38+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["IOT", "BIGDATA"]
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

Configure an MQTT Client Agent within the IoT Gateway Plug-In for KEPServerEX 

to send data to Ali IoT. The connection can be made using MQTT over Transmission 

Control Protocol (TCP) and MQTT over Transport Layer Security (TLS).



set up Kepware KEPServerEX IoT Gateway on Windows to connect with the MQTT bridge

of IoT Core to push streaming data to Cloud and send control messages from IoT 

Core back to KEPServerEX


IoT Gateway is a module that provides integration with external IT systems 

and cloud platforms through a series of protocols such as MQTT and HTTP.



![](/img/post/kepserverex-iot.png)


1. A random value simulator sends values to IoT Gateway.
2. Values go through the IoT Gateway to IoT Core.
3. IoT Core bridges the values to Pub/Sub.
4. Users send command messages through IoT Core.
5. Command messages go through IoT Core to the IoT Gateway.
6. IoT Gateway delivers the messages to the simulated device.