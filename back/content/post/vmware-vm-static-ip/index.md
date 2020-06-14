+++
title = "分配Vmware虚机静态IP"
date = 2020-06-14T08:14:18+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["VM", "NETWORK"]
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


## 虚机网卡地址

![](/img/post/vmare-static-ip.png)


## 配置静态IP

`C:\Documents and Settings\All Users\Application Data\VMware\vmnetdhcp.conf`

```
host VMnet8 {
    hardware ethernet 00:0C:29:23:AV:67;
    fixed-address 192.168.137.170;
}
```

## 重启VMWARE DHCP服务

```
net stop vmnetdhcp
net start vmnetdhcp
```