+++
title = "Maven Mirror"
date = 2013-04-28T17:08:07+08:00
tags = ["JAVA", "MAVEN"]
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

阿里云Maven中央仓库为 阿里云云效 提供的公共代理仓库

打开 maven 的配置文件（ windows 机器一般在 maven 安装目录的 conf/settings.xml ），

在<mirrors></mirrors>标签中添加 mirror 子节点:

```
<mirror>
  <id>aliyunmaven</id>
  <mirrorOf>*</mirrorOf>
  <name>阿里云公共仓库</name>
  <url>https://maven.aliyun.com/repository/public</url>
</mirror>
```