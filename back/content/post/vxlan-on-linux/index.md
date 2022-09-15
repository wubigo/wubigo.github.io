+++
title = "Vxlan on Linux"
date = 2019-01-03T11:31:17+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["NETWORK", "VXLAN", "NFV", "LINUX"]
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


## 端到端VXLAN(unicast)



```
ip a

ip link add vxlan0 type vxlan \
    id 42 \
    dstport 4789 \
    remote 10.12.0.172 \
    local 10.12.2.95 \
    dev eth0


ip -d link show dev vxlan0



ip addr add 192.168.8.101/24 dev vxlan0
ip link set vxlan0 up


ip r
default via 10.12.0.1 dev eth0
10.12.0.0/21 dev eth0  proto kernel  scope link  src 10.12.2.95
192.168.8.0/24 dev vxlan0  proto kernel  scope link  src 192.168.8.101


bridge fdb | grep vxlan0

ip neigh
```

## 多播vxlan(multicast)



