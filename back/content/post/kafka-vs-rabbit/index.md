+++
title = "Kafka vs Rabbit"
date = 2013-04-28T17:08:07+08:00
tags = ["SHELL", "MQ"]
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.

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



|   |rabbit|kafka |
:---|:---|:---
创建时间  |2007| 2011
开发语言  | erlang| scala
AMQP  | SUPPORT|    NO
AGENT |  SMART(broker-centric) keeps track of consumer state| dumb(producer-centric)
存储空间 |  in-memory  | disk  |
INGRESS VOLUME| 20K messages/sec |  100k/sec messages/sec
CONSUMERS | mostly online(balancing load to many consumer) | online and batch consumer
ROUTING   |  exchange, binding  | simple | 
history     | N/A|         replay(删除by size 或时间)      
数据压缩  | N|  Y
SPRING SUPPORT   |  weak  |   strong
安全  |  RBAC backed by a built-in data store, LDAP |  JAAS role based access  
管理   | Web 和 CLI| JMX 和 CLI

