+++
title = "BIM和CAD的对比"
date = 2017-09-09T07:52:46+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["3D", "AR"]
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

最近在做智慧工地的项目，“智慧工地”的建设很大一部分信息主要是来自于工程BIM模型。
大部分情况下，BIM模型的精确度决定了“智慧工地”的开展程度。
“智慧工地”建设中，BIM模型的应用主要集中在以下几个方面：

- 工程量的统计：分析各施工流水段各材料的工程量，如混凝土的工程量。

- 施工模拟：施工进度计划与BIM模型相关联，对施工过程进行模拟。将实际工程进度与模拟进度进行对比，可以直观的看出工程是否滞后。

- 可视化交底：通过BIM的可视化特点，对施工方案进行模拟，对施工人员进行3D动画交底，提高了交底的可行性。

- 节点分析： 对复杂节点进行BIM建模，通过模型对复杂节点进行分析。

- 综合管线碰撞检测： 检测预留孔洞、机电、设备管线安装碰撞。


从具体实现的角度对BIM和CAD做个比较


||    CAD  |      BIM
:---|:---|:---
工具集| 2D(3D通过划线) | 3D
连接过程|直接(2D对象直接连接)|间接(3D对象通过参数装配)
视图|高度具体的可视化视图|动态流线型视图，可随意放大，缩小
知识复用||MODEL(部件从MODEL抽取，而且部件的修改同时同步到MODEL)


# 基于WEB的3D建模工具

- https://www.onshape.com/
- Lagoa(基于云端的3D建模APP，被Autodesk6千万美元收购)
- https://www.vectary.com/
- https://clara.io/
