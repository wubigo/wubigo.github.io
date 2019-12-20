+++
title = "羊毛党秘籍之公有云(新手篇)"
date = 2016-12-20T06:31:28+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["AWS"]
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

**本文所说的新手是指还在12个月免费期内的用户**

只要有一张信用卡，就可以注册一个AWS账号。

对于AWS新注册账号，有12个月的免费使用额度

具体额度如下：

服务


| 服务        | 额度           | 当月使用统计  |
|:------------- |:-------------| :-----|
| 服务器      | 750小时 t2.micro |  |
|硬盘| 30GB||
|硬盘快照|1GB||
|网盘|5G||
|数据库|25G||
|函数计算|1百万次调用||

下图我这个月的使用额度

![](/img/post/aws-free-usage.png)


从上面的图可以看出，AWS免费额度里面比较鸡肋的是

网盘快照的额度太少，走常规的操作系统镜像备份是要

花钱的，因为一个最小的ubuntu实例镜像就是8G，

如何做到保存自己的最新工作成果，而又不用掏钱买快照

的存储费用呢？

解决办法如下：

- 创建EC2

- 创建一块硬盘，小于20G即可，并把该硬盘外挂到EC2

- 在外挂的硬盘里面保存自己的操作数据

- 使用user_data初始化包括安装常用软件包，自动外挂硬盘等

- 使用完EC2销毁即可(卸载外挂硬盘**千万不要销毁外挂的硬盘**)

上面的操作可以使用基础设施配置工具(ansible, terraform, pupport等)

进行自动化管理。

下面以terraform为例介绍操作步骤：

## 前提

- [安装AWS SDK](/post/use-public-cloud-for-free/#install_aws_sdk)

- [配置AWS访问权限](/post/use-public-cloud-for-free/#install_aws_sdk)