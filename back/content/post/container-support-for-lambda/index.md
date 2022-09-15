+++
title = "函数服务容器化"
date = 2020-12-31T18:59:41+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["LAMBDA"]
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

函数计算最大的卖点是只用交付业务代码，业务代码在预定义的被托管的可执行环境执行。

由可执行环境管理基础架构，网络，操作系统。

但问题是可执行环境包含一个特定的运行时。有可能业务需要的类库在该运行时并不存在。

而函数服务容器支持任意容器镜像作为函数服务的可执行环境能很好的解决这一问题。

