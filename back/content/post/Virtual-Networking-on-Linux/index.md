+++
title = "Linux中的虚拟网络设施"
date = 2017-11-11T09:42:42+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["NFV", "LINUX", "NETWORK"]
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


## 标准设备

- Bridge: A Linux bridge behaves like a network switch. It forwards packets between interfaces that are connected to it. It's usually used for forwarding packets on routers, on gateways, or between VMs and network namespaces on a host. It also supports STP, VLAN filter, and multicast snooping.
- TUN: TUN (network Tunnel) devices work at the IP level or layer three level of the network stack and are usually point-to-point connections. A typical use for a TUN device is establishing VPN connections since it gives the VPN software a chance to encrypt the data before it gets put on the wire. Since a TUN device works at layer three it can only accept IP packets and in some cases only IPv4. If you need to run any other protocol over a TUN device you’re out of luck. Additionally because TUN devices work at layer three they can’t be used in bridges and don't typically support broadcasting.
- TAP: TAP (terminal access point) devices, in contrast, work at the Ethernet level or layer two and therefore behave very much like a real network adaptor. Since they are running at layer two they can transport any layer three protocol and aren’t limited to point-to-point connections. TAP devices can be part of a bridge and are commonly used in virtualization systems to provide virtual network adaptors to multiple guest machines. Since TAP devices work at layer two they will forward broadcast traffic which normally makes them a poor choice for VPN connections as the VPN link is typically much narrower than a LAN network (and usually more expensive).
- VETH: Virtual Ethernet interfaces are essentially a virtual equivalent of a patch cable, what goes in one end comes out the other. When either device is down, the link state of the pair is down.

## 网络名字空间

Network namespaces allows different processes to have different views of the network and different aspects of networking can be isolated between processes



https://gist.github.com/mtds/4c4925c2aa022130e4b7c538fdd5a89f

