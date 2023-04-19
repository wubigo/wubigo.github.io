+++
title = "MQTT vs HTTP for IoT"
date = 2020-04-19T10:23:33+08:00
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

While HTTP is a good choice for displaying information only once, MQTT is the solution whenever you want to enable communication (exchanging messages (data) ) frequently.

MQTT points out its ability to hold connections open and its way of handling data formats. Both enable successful, reliable message transfer.

On the other hand, if you do not exchange messages frequently, HTTP should be your choice.



# 连接

keep-connection-open   vs request-response

MQTT is superior to HTTP if you have devices that communicate regularly. The MQTT protocol can keep a connection open for as long as possible, sending only a single data packet. Unlike HTTP communication, which requires you to open and close a connection (including TCP) for every data packet you want to send, you can significantly reduce CPU usage.

# 数据包大小和格式

HTTP relies on text. Base64 encodes and decodes any binary code，creating more workload for the CPU。
An MQTT payload can be any type of data – encoding is not necessary。

