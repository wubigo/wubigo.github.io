+++
title = "公有云羊毛党使用秘籍(新手篇)"
date = 2016-12-20T06:31:28+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["AWS"]
categories = []
images = ["http://brendan-quinn.xyz/css/images/banners/responsive-images-landscape-seo.jpg"]
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


## 计算和存储



从上面的图可以看出，AWS免费额度里面比较鸡肋的是

网盘快照的额度太少，走常规的操作系统镜像备份是要

花钱的，因为一个最小的ubuntu实例镜像就是8G，

如何做到保存自己的最新工作成果，而又额外使用快照从而

节省存储费用呢？

解决办法如下：

### 硬盘外挂 


- 创建EC2

- 创建一块硬盘，小于20G即可，并把该硬盘外挂到EC2

- 在外挂的硬盘里面保存自己的操作数据

- 使用user_data初始化包括安装常用软件包，自动外挂硬盘等

- 使用完EC2销毁即可(卸载外挂硬盘**千万不要销毁外挂的硬盘**)

上面的操作可以使用基础设施配置工具(ansible, terraform, pupport等)

进行自动化管理。

下面以terraform为例介绍操作步骤：

#### 前提

- [安装AWS SDK](/post/use-public-cloud-for-free/#install_aws_sdk)

- [配置AWS访问权限](/post/use-public-cloud-for-free/#install_aws_sdk)


#### EC2

- [启动并外挂硬盘](https://github.com/wubigo/iaas/tree/master/aws)


### 使用容器镜像

AWS提供500M的镜像存储空间，可以把自己的数据保存到容器镜像


### EC2带宽费用

EIP双向收费，策略是使用S3+VPC中转

```
IPv4: Data transferred “in” to and “out” from public or Elastic IPv4 address is charged at $0.01/GB in each direction.
IPv6: Data transferred “in” to and “out” from an IPv6 address in a different VPC is charged at $0.01/GB in each direction.
```

## 搭建S3 web站点

[web hosting](/post/aws-s3-web-hosting/)



## SQS vs SNS vs kinesis

https://medium.com/better-programming/moving-messages-in-aws-comparing-kinesis-sqs-and-sns-32cb5d2f89d5