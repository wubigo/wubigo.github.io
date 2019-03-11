---
layout: post
title: Linux performance
date: 2018-11-07
tags: ["LINUX"]
---


# putting /tmp on tmpfs

https://blog.ubuntu.com/2016/01/20/data-driven-analysis-tmp-on-tmpfs

# Interrupt Coalescence
ubuntu 16 default

Interrupt Coalescence (IC)

```
$ethtool -c enp0s25
Coalesce parameters for enp0s25:
Adaptive RX: off  TX: off
```

Pause frames

```
$ethtool -a enp0s25
Pause parameters for enp0s25:
Autonegotiate:	on
RX:		on
TX:		on

```




# network

Tuning the network adapter (NIC)

use Jumbo frames

```
ifconfig eth0 mtu 9000
```

ip result for a healthy system with no packet drops
```
ip -s link show eth0

```


stop irqbalance for home user

```
sudo systemctl disable/stop irqbalance
```





# network-performance-monitoring
[https://opensourceforu.com/2016/10/network-performance-monitoring/](https://opensourceforu.com/2016/10/network-performance-monitoring/)

# Linux Network (TCP) Performance Tuning with Sysctl
[https://www.slashroot.in/linux-network-tcp-performance-tuning-sysctl](https://www.slashroot.in/linux-network-tcp-performance-tuning-sysctl)


