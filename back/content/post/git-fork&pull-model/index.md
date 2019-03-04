+++
title = "分叉拉取模式(fork and pull model)"
date = 2017-03-04T08:06:21+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["GIT", "SCM"]
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

GITHUB两种主要的pull request的开发模式

- 分叉拉取模式

任何开发人员可以在项目源仓库(upstream)分叉，然后复制该分叉(origin)到本地文件系统进行开发
测试，测试完毕提交到分叉origin，并发送pull request到源仓库upstream, 源仓库维护人员评审
更改，并最终决定是否合并该更改到源仓库

在发送pull request之前，好几个开发人员共同为一个特性协作开发， 互相从对方的仓库拉取代码。
这时，从对方的仓库拉取代码简化重新定义一个remote，该remote把本地的分叉指向对方仓库地址。






