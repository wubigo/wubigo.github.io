+++
title = "Wireguad Vpn Client for Ubuntu"
date = 2020-08-31T12:41:39+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["VPN"]
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


## 安装

```
$lsb_release -a

Distributor ID: Ubuntu
Description:    Ubuntu 20.04.1 LTS
Release:        20.04
Codename:       focal
```


```

sudo apt install wireguard  wireguard-dkms -y
wget algo/configs/localhost/wireguard/desktop.conf  /etc/wireguard/wg0.conf
sudo modprobe wireguard
sudo ln -s /usr/bin/resolvectl /usr/local/bin/resolvconf
sudo wg-quick up wg0
```

