+++
title = "文件系统的持久化特性"
date = 2019-02-16T07:00:41+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["KVS", "OS"]
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

大多数重要的应用程序都是在文件系统的基础上构建，而不是在原始磁盘上
构建。例如LEVELDB.

文件系统在系统崩溃恢复所表现的行为，我们称之为持久化属性，大概分为
两类：原子操作和顺序操作


[1] [All File Systems Are Not Created Equal](https://www.usenix.org/system/files/conference/osdi14/osdi14-paper-pillai.pdf)