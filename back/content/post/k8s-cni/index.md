+++
title = "K8S CNI操作指引"
date = 2019-02-24T16:18:43+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["K8S", "CNI", "NETWORK"]
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

# 简介

  CNI是K8S的网络插件实现规范，与docker的CNM并不兼容，在K8S和docker的博弈过程中，
  K8S把docker作为默认的runtime并没有换来docker对K8S的支持。K8S决定支持CNI规范。
  许多网络厂商的产品都提供同时都支持CNM和CNI的产品。

  在容器网络环境，经常看到docker看不到K8S POD的IP网络配置，
  DOCKER容器有时候和POD无法通信。

  CNI相对CNM是一个轻量级的规范。网络配置是基于JSON格式，
  网络插件支持创建和删除指令。POD启动的时候发送创建指令。

  POD运行时首先为分配一个网络命名空间，并把该网络命名空间制定给容器ID，
  然后把CNI配置文件传送给CNI网络驱动。网络驱动连接容器到自己的网络，
  并把分配的IP地址通过JSON文件报告给POD运行时POD终止的时候发送删除指令。

  当前CNI指令负责处理IPAM, L2和L3, POD运行时处理端口映射(L4)

# K8S网络基础

[K8S网络基础](/post/k8s-network-basic/)

# CNI插件



# CNI实现方式

CNI有很多实现，在这里之列举熟悉的几个实现。并提供详细的说明文档。

- Flannel

- Kube-router

    [Kube-router](/post/k8s_cni_kube-router/)

- OpenVSwitch

- Calico

    Calico可以以非封装或非覆盖方式部署以支持高性能，高扩展扩展性数据中心网络需求

    [CNI-Calico](/post/k8s_cni_calico)



- Weave Net

- 网桥

    [CNI 网桥](/post/cni_l2_network_on_bare_metal/)


