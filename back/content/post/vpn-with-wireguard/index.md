+++
title = "Vpn With Wireguard"
date = 2018-01-02T12:34:32+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["VPN", "SDN", "NFV"]
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


```
sudo add-apt-repository ppa:wireguard/wireguard
sudo apt-get update
sudo apt-get install wireguard
wg genkey
```


`/etc/wireguard/wg0.conf`

```
[Interface]
PrivateKey = SEd9KTOqekPvpxgfYB3e8f38Z8T4PX0J1DQlSRC3InQ=
Address = 10.12.4.0/21
ListenPort = 51820



PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE



[Peer]
# My laptop (this is just a comment, change it to identify the device)
PublicKey = YQ3MK8oGH62d5jb/mfPVVNP955SO3lcmMOnfQ71r4mo=
AllowedIPs = 10.12.4.10/32
```









Endpoint = 54.250.169.49:51820