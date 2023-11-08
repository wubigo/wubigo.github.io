+++
title = "EMQX回话保持"
date = 2023-11-08T15:38:31+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = []
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

# 默认会化过期时间

开源的EMQ设置的会话过期时间为 5 分钟，最大消息数为 1000 条，且不保存 QoS 0 消息。


针对这两点，MQTT 5.0 提供了 Clean Start 和 Session Expiry Interval 这两个连接字段来控制会话的生命周期


## Session Expiry Interval

Session Expiry Interval 同样位于 CONNECT 报文的可变报头，不过它是一个可选的连接 属性。
它被用来指定会话在网络断开后能够在服务端保留的最长时间，如果到达过期时间但网络连接仍未恢复，
服务端就会丢弃对应的会话状态。它有三个典型的值：

1. 没有指定此属性或者设置为 0，表示会话将在网络连接断开时立即结束。
2. 设置为一个大于 0 的值，则表示会话将在网络连接断开的多少秒之后过期。
3. 设置为 0xFFFFFFFF，即 Session Expiry Interval 属性能够设置的最大值时，表示会话永不过期。


服务端使用 Client ID 来唯一地标识每个会话，如果客户端想要在连接时复用之前的会话，那么必须使用与此前一致的 Client ID




我们需要正确地评估持久会话对服务器资源的影响，会话过期时间越长，服务端需要花费的存储资源就可能越多。
虽然服务端通常并不会无限制地为客户端缓存消息，以 EMQX 为例，默认情况下每个客户端会话中能够缓存的最大消息数量为1000

