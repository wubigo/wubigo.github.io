+++
title = "K8S网络基础"
date = 2016-02-24T19:39:03+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["K8S", "NETWORK"]
categories = ["IT"]

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++


**K8S网络基础**

# K8S简介

K8S是自动化部署和监控容器的容器编排和管理工具。各大云厂商和应用开发平台都提供基于K8S的容器服务。
如果觉得K8S托管服务不容易上手或者和本公司的业务场景不很匹配，现在也有很多工具帮助在自己的数据
中心或私有云平台搭建K8S运行环境。

- Minikube
- kops
- kubeadm

如果你想搭建一个测试环境，请参考

- [从K8S源代码构建容器集群(支持最新稳定版V1.13.3)](https://wubigo.com/post/2016-02-03-k8s-local-development-setup/)
- [一个脚步部署K8S](https://wubigo.com/post/2011-01-01-shell-script#deploy-k8s-master)

Kubernetes主要构件:

- 主节点： 主要的功能包括管理工作节点集群，服务部署，服务发现，工作调度，负载均衡等。
- 工作节点： 应用负载执行单元。
- 服务规范： 无状态服务，有状态服务，守护进程服务，定时任务等。
    
# K8S网络基础

K8S网络模型

- 每一个POD拥有独立的IP地址
- 任何两个POD之间都可以互相通信且不通过NAT
- 集群每个节点上的代理(KUBELET)可以和该节点上的所有POD通信

K8S网络模型从网络端口分配的角度为容器建立一个干净的，向后兼容的规范，极大的方便和简化应用从虚拟机往容器迁移的流程。

K8S解决的网络问题：

 - 容器间通信问题： 由POD和localhost通信解决  
 - POD间通信问题： 由CNI解决
 - POD和服务的通信问题： 由SERVICE解决
 - 外部系统和SERVICE的通信问题： 由SERVICE解决