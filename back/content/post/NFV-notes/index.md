+++
title = "NFV Notes"
date = 2017-12-29T12:31:08+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["NFV","SDN"]
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

## VLAN

VLAN（802.1Q）是一个局域网技术，能够将一个局域网的广播域隔离为多个广播域，常被用来实现一个站点内不同的部门间的隔离


## 数据中心网络虚拟化——NVo3技术端到端隧道

NVo3（Network Virtualization over Layer 3），是IETF 2014年十月份提出的数据中心虚拟化技术框架。

NVo3基于IP/MPLS作为传输网，在其上通过隧道连接的方式，构建大规模的二层租户网络。NVo3的技术模型如下所示，

PE设备称为NVE（Network Virtualization Element），VN Context作为Tag标识租户网络，P设备即为普通的IP/MPLS路由器。

NVo3在设计之初，VxLAN与SDN的联合部署已经成为了数据中心的大趋势，因此NVo3的模型中专门画出了

NVA(Network Virtualization Authority）作为NVE设备的控制器负责隧道建立、地址学习等控制逻辑

### VxLAN（Virtual eXtensible LAN，RFC 7348）

Vmware和Cisco联合提出的一种二层技术，突破了VLAN ID只有4k的限制，允许通过现有的IP网络进行隧道的传输。

别看VxLAN名字听起来和VLAN挺像，但是两者技术上可没什么必然联系。VxLAN是一种MACinUDP的隧道.


### NvGRE

NvGRE（Network virtualization GRE，RFC draft）是微软搞出来的数据中心虚拟化技术，是一种MACinGRE隧道。它对传统的GRE报头进行了改造，增加了24位的VSID字段标识租户，而FlowID可用来做ECMP。由于去掉了GRE报头中的Checksum字段，因此NvGRE不支持校验和检验。NvGRE封装以太网帧，外层的报头可以为IPv4也可以为IPv6


https://www.sdnlab.com/nv-subject/

