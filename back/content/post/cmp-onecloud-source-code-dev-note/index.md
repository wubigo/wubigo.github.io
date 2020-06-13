+++
title = "Onecloud Source Code Dev Note"
date = 2018-06-10T11:13:09+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["CMP"]
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

## keystone

`\etc\yunion\keystone.conf`

- 初始化

```
auto_sync_table: true
```

自动创建表，创建完后关闭


```
 kubectl describe cm -n onecloud default-keystone
```
