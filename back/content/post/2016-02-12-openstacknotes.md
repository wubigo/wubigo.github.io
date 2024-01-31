---
layout: post
title: openstack notes
date: 2016-02-12
tag: architecture
---


# 控制器

身份认证服务，镜像服务，计算服务的管理部分，网络服务的管理部分，多种网络代理以及仪表板。也需要包含一些支持服务，例如：SQL数据库，消息队列,和NTP服务

# Neutron

Neutron为整个openstack环境提供软件定义网络支持，主要功能包括二层交换、三层路由、防火墙、VPN，以及负载均衡等。Neutron在由其他openstack服务（如nova）管理的网络接口设备（如虚拟网卡）之间提供网络连接即服务

# cost effective network solutions
In general , commercial product is better. Nuage is software-based ,while
华为，华三 are hardware-based. Nuage support container, bare metal and VM
