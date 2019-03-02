+++
title = "Docker网络macvlan"
date = 2017-03-01T10:49:32+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["CRI", "DOCKER", "NETWORK"]
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

# 介绍
Macvlan支持从一个上层物理接口创建子接口，每个子接口有自己独立的MAC和IP地址。
应用程序，容器或虚机可以绑定到子接口，用子接口的IP和物理网络直接通信。

- 好处
  + 现有的很多网络监控设备还不支持虚拟网络设备的监控，Macvlan支持
  + 不需要新建iptable，nat，route单独管理容器网络

- 不足
  + 交换机的每个端口上能连接的不同MAC有策略上限
  + 网卡上过多的MAC会影响性能
  + Macvlan只支持LINUX

# 准备

- 需要4.0以上的内核

```
uname -r
4.15.0-45-generic
```

- 加载macvlan模块

```
sudo modprobe macvlan
lsmod | grep macvlan
...
macvlan    24576  0
...
```
- 配置网卡为混杂模式

  主机      |     IP     
:---|:---|
PC     |`192.168.1.5/24`
VM1    |`192.168.1.10/24`
Container1|`192.168.1.128/25`




# MACVLAN四种工作模式

- Macvlan VEPA
- Macvlan Bridge
- Macvlan Passthru

# 创建macvlan
```
ip addr show enp0s3
enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UNKNOWN group default qlen 1000
    link/ether 08:00:27:c0:91:4c brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.10/24   

ip route
default via 192.168.1.1 dev enp0s3 onlink
```


```
docker network create -d macvlan  \
  --subnet=192.168.1.0/24  \
  --ip-range=192.168.1.128/25 \
  --gateway=192.168.1.1  \
  -o parent=enp0s3 macLan
```

```
docker run --rm -itd   --network macLan   --name web nginx:1.14-alpine
```

# macvlan限制

>despite having the ability to communicate with other guests and 
 other external hosts on the network, the guest cannot communicate 
 with its own host.

>This situation is actually not an error — it is the defined behavior of macvtap. Due to the way in which the host's physical Ethernet is attached to the macvtap bridge, traffic into that bridge from the guests that is forwarded to the physical interface cannot be bounced back up to the host's IP stack. Additionally, traffic from the host's IP stack that is sent to the physical interface cannot be bounced back up to the macvtap bridge for forwarding to the guests.

变通方法：

- 预留ip --aux-address="macvlan_bridge=192.168.1.199"

```
docker network create -d macvlan  \
  --subnet=192.168.1.0/24  \
  --ip-range=192.168.1.128/25 \
  --gateway=192.168.1.1  \
  -o parent=enp0s3 macLan \
  --aux-address="macvlan_bridge=192.168.1.199"
```  

- 创建一个新的macvlan

```
sudo ip link add macvlan_bridge link enp0s3 type macvlan  mode bridge
sudo ip addr add 192.168.1.199/32 dev macvlan_bridge
sudo ip link set macvlan_bridge up
```

- 指示宿主通过macvlan_bridge访问部署在宿主上的容器网络

```
ip route add 192.168.1.128/27 dev macvlan_bridge
```

