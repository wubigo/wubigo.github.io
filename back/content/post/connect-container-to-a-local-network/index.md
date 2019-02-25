+++
title = "容器多种方式链接本地网络"
date = 2018-04-25T07:10:55+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["DOCKER", "NETWORK"]
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


# docker host network

assign a second ip to host interface

```
$IP_2=192.168.1.117
ip addr add $IP_2/24 dev enp0s3

```

bind container to IP_2 host network

```
docker run -it --name web -p ${IP_2}80:80 nginx:1.14-alpine
sudo iptables -L DOCKER -v -n

Chain DOCKER (1 references)
 pkts bytes target     prot opt in        out      source           destination         
    7   528 ACCEPT     tcp  --  !docker0  docker0  0.0.0.0/0       172.17.0.2           tcp dpt:80

```
>
