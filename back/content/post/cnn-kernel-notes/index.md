+++
title = "图像处理中的卷积核kernel"
date = 2020-05-10T17:59:50+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["CNN","AI"]
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


图像处理中的卷积核kernel


# 简介

卷积核（kernel），也叫卷积矩阵（convolution matrix）或者掩膜（mask），本质上是一个非常小的矩阵，最常用的是 3×3 矩阵。主要是利用核与图像之间进行卷积运算来实现图像处理，能做出模糊、锐化、凹凸、边缘检测等效果。


# 卷积运算

第一个矩阵是卷积核（其中的每个元素都是权重），第二个矩阵是被处理的矩阵，这里的并不是真正矩阵运算中，而是将卷积核中的行和列都反转再*，将计算得到的加权结果赋值给[2, 2]位置处.
将一个比较大的原始矩阵的每一个位置处都根据核进行上述的运算，就得到整个原始矩阵的加权平均结果，也就是原始矩阵卷积运算后的结果

![](/img/post/cnn-kernel.png)



[1][https://blog.csdn.net/i_silence/article/details/116483732](https://blog.csdn.net/i_silence/article/details/116483732)

