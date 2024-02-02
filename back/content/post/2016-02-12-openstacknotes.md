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

## 组网方式

典型的组网方式包括nova-network的dhcpflat、vlan，neutron的bridge + vlan、bridge + vxlan、ovs + vlan、ovs + vxlan，其选择上可以从3个维度来看，nova-network和neutron的选择、网络拓扑flat、vlan、gre、vxlan的选择、插件Linux bridge和ovs的选择。

### nova-network和neutron的选择：
nova-network：稳定，结构简单，但目前仅支持linux bridge一种插件；
neutron：可以支持bridge、ovs等众多插件，并且通过ml2技术可以实现众多插件混合使用，引入openflow等sdn技术，是控制逻辑和物理网络相隔离。但neutron目前最大的问题是稳定性（例如创建过多的vm，host会无故重启，neutron服务会无故down掉，floating ip无法正常释放等，这些问题目前都在查找原因，尚未解决），而且iec house版本不支持network muti-host部署（据说juno版本支持）

### 网络拓扑flat、vlan、gre、vxlan的选择

- flat： 模式简单，但有广播风暴的风险，不适于大规模部署（一千台vm？）；
- vlan：可以隔离广播风暴，但需要配置物理交换机chunk口；
- gre：可以隔离广播风暴，不需要交换机配置chunk口， 解决了vlan id个数限制，3层隧道技术可以实现跨机房部署。但gre是点对点技术，每两个点之间都需要有一个隧道，对于4层的端口资源是一种浪费；
- vxlan：可以隔离广播风暴，不需要交换机配置chunk口， 解决了vlan id个数限制，解决了gre点对点隧道个数过多问题，实现了大2层网络，可用于vm在机房之间的的无缝迁移，便于跨机房部署。唯一的缺点就是- vxlan增加了ip头部大小，需要降低vm的mtu值，传输效率上会略有下降。

结论：如果不需要通过大二层网络实现跨机房部署，可以选择vlan，如果涉及到跨机房部署，需要大二层的通信方式，选择vxlan

### Linux bridge和ovs的选择：

这两种插件是目前业界使用最多的，非官方统计（摘自http://wenku.it168.com/d_001350820.shtml） 二者在众多插件使用份额是，Linux bridge31%、ovs 39%

- Linux bridge：历史悠久，稳定性值得信赖，但是当vm个数过多，二层交换出现问题时，目前没有特别好的定位手段。
- ovs：可以针对每个vm做流量限制、流量监控、数据包分析，同时可以引入openflow，引入sdn controller，使控制逻辑和物理交换相分离，并且sdn controller可以实现vxlan的跨机房大二层通信，但是业界普遍认为其性能是个大问题。


### 网络性能评估

OpenStack is an open source cloud solution which aims at removing vendor locking by providing a virtualized environment in a production environment. OpenStack's networking module i.e. Neutron provides a centralized routing service, where L3 packets are redirected to a central network node. A single network node is incapable of handling overlapping IP addresses for multiple networks, which in turn, greatly decreases network bandwidth and throughput of production environments. This paper introduces two technologies that can alleviate the network performance issues as faced by Neutron. Furthermore, these two technologies namely OpenDaylight (ODL) and Distributed Virtual Routing (DVR) are then presented together with a set of benchmarks which showcase their performance in a production environment. The performance results show ODL and DVR out perform Neutron in every layer 3 case, making them as an upgrade for any traditional OpenStack based environment.


# cost effective network solutions
In general , commercial product is better. Nuage is software-based ,while
华为，华三 are hardware-based. Nuage support container, bare metal and VM
