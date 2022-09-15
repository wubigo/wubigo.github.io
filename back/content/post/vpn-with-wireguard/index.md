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

## 安装

```
sudo add-apt-repository ppa:wireguard/wireguard
sudo apt-get update
sudo apt-get install wireguard -y

```

- 打开安全组

![](/img/post/wireguard-sg.png)

## 配置

- 创建key

```
wg genkey | tee privatekey | wg pubkey > publickey

private_key=$(wg genkey)
public_key=$(echo $private_key | wg pubkey)

```

- 配置 

```

ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 0a:81:39:72:97:90 brd ff:ff:ff:ff:ff:ff
    inet 10.12.0.154/24 brd 10.12.0.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::881:39ff:fe72:9790/64 scope link
       valid_lft forever preferred_lft forever

```



`/etc/wireguard/wg0.conf`

```
[Interface]
PrivateKey = AKUINjvxFqVLMiJc7qX95bEyiRlqnAWFHpy3hLeCI1s=
Address = 10.12.4.1/24
ListenPort = 51820



PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE



[Peer]
# My laptop (this is just a comment, change it to identify the device)
PublicKey = k2XMyPcLbPcNhJ5ThKrwbzNPMw6h1JKkDOcw1rqstF4=
AllowedIPs = 10.12.4.0/24

```

- 启动

```
sudo wg-quick up wg0

sudo wg show wg0 help

sudo netstat -anp|grep 51820
udp        0      0 0.0.0.0:51820           0.0.0.0:*                           -
udp6       0      0 :::51820                :::* 
```

查看正在使用的密钥对

```
wg show wg0 dump

```

- 显示公钥和vpn服务运行状态

```
sudo wg
```


- 启动主机路由

```
sudo sysctl -p
net.ipv4.ip_forward = 1
```

## stop

```
sudo wg-quick down wg0
```

## 客户端

[Vpn客户端设置参考](/post/vpn-win-setup/)


PS: [Wireguard在前几天被合并到LINUX的内核代码](https://www.linux.com/news/wireguard-to-be-merged-with-linux-net-next-tree-and-will-be-available-by-default-in-linux/)


https://www.linuxbabe.com/ubuntu/wireguard-vpn-server-ubuntu