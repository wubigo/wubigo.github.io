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
sudo apt install wireguard
wget algo/configs/localhost/wireguard/desktop.conf  /etc/wireguard/wg0.conf
sudo wg-quick up wg0
```

