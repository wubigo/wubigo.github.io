+++
title = "Openstack Neutron Notes"
date = 2018-06-11T17:38:12+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["OPENSTACK"]
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


## ML2插件

ML2插件允许openstack网络中同时使用多种二层的网络技术;不同的节点可以使用不同的网络机制

ML2能够与现在所有的代理无缝集成;以前使用的代理无需变更，只要将传统的core plugin替换ML2

ML2使得对新的网络技术支持更为简单;无需重新开发新的core plugin插件;只需开发相应的机制驱动

ML2对二层的网络进行抽象;解锁了neutron所支持的网络类型(type)与访问这些网络类型的虚拟网络实现机制(mechansim);并通过驱动的形式进行扩展</p> 
<p>不同的网络类型对应不同的类型驱动(type driver);由类型管理器(type manager)进行管理</p> 
<p>不同的网络实现机制对应不同的机制驱动(mechansim);由机制管理器(mechansim manager)进行管理</p> 
<p>neutron 支持的每一种网络类型都有一个对应的ML2类型驱动</p> 
<p>类型驱动负责维护网络类型的状态;执行验证、创建网络等工作</p> 
<p>目前neutron已经实现的网络类型包括：flat、local、vlan、vxlan、gre</p> 


目前neutron已经实现的网络机制有三种类型:

- 基于代理(agent-based): 包括linux bridge、open vswitch
- 基于控制器(controller-based): 包括open daylight、vmwavre NSX等
- 基于物理交换: 包括cisco nexus、arista、mellanox等

## Mechanism drivers and L2 agents

| Mechanism Driver      | L2 agent |
| ----------- | ----------- |
| Open vSwitch      | Open vSwitch agent       |
| Linux bridge   | 	Linux bridge agent        |
|SRIOV|SRIOV nic switch agent|
|MacVTap|MacVTap agent|


## linux bridge 代理

linux bridge 是成熟可靠的neutron二层网络虚拟化技术,支持local、flat、vlan、vxlan这四种网络类型,目前不支持gre

## open vswitch代理

open vswitch可简称OVS,具有几种管控功能,而且性能更加优化,支持更多的功能,目前在openstack领域被称为主流。</p> 
<p>它支持local、flat、vlan、vxlan、gre、geneve等所有网络类型</p> 


## the key differences between neutron  ML2/ovs and ML2/ovn

| Detail      | ml2/ovs |  ml2/ovn  |
| ----------- | ----------- |----------- |
|agent/server communication| rabbit mq messaging + RPC.|ovsdb protocol on the NorthBound and SouthBound databases.|
|E/W traffic|goes through network nodes when the router is not distributed (DVR).|completely distributed in all cases.|
|Trunk Ports|Trunk ports are built by creating br-trunk-xxx bridges and patch ports.|Trunk ports live in br-int as OpenFlow rules, while subports are directly attached to br-int.|





[https://docs.openstack.org/neutron/latest/ovn/faq/index.html](https://docs.openstack.org/neutron/latest/ovn/faq/index.html)


[openstack——Neutron基本架构详解](https://blog.csdn.net/Lfwthotpt/article/details/104698764)