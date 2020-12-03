+++
title = "在Ubuntu上禁用DNS本地缓存 "
date = 2020-10-29T21:59:14+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = []
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


Linux systems which use a GUI often have a network manager running, which uses a dnsmasq instance running on a loopback address such as 127.0.0.1 or 127.0.1.1 to cache DNS requests, and adds this entry to /etc/resolv.conf. The dnsmasq service speeds up DNS look-ups and also provides DHCP services

```
sudo cat /run/resolvconf/resolv.conf
sudo cat /run/dnsmasq/resolv.conf
sudo cat /etc/systemd/resolved.conf
```


## Disable the local DNS cache

`/etc/NetworkManager/NetworkManager.conf`

```
#dns=dnsmasq
```

```
systemctl restart network-manager
```



```
sudo systemctl disable dnsmasq
```

## ubuntu 20.04


双网卡或局域网加无线网主机，路由指向通一个路由器

```
ls -l /etc/resolv.conf
/etc/resolv.conf -> /run/systemd/resolve/stub-resolv.conf

unlink /etc/resolv.conf
ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf


sudo ip route del default  dev wlp2s0
```



https://www.tecmint.com/set-permanent-dns-nameservers-in-ubuntu-debian/


## 更新IP地址


To renew or release an IP address for the eth0 interface, enter:

```
sudo dhclient -r eth0
sudo dhclient eth0
```