+++
title = "WIN用户使用Docker卷"
date = 2018-09-26T17:14:12+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["DOCKER", "WINDOWS"]
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

在windows，启动卷必须线启用共享驱动

# 启用共享驱动

```
1: Open "Settings" in Docker Desktop -> 
   "Shared Drives" -> 
   "Reset Credentials" -> 
   select drive "D" -> "Apply"
```

# 检查测试卷 



```
docker run --rm -v d:/tmp:/data alpine ls /data
```

