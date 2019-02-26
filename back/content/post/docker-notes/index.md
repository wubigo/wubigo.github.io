+++
title = "Docker Notes"
date = 2016-01-25T17:11:05+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["DOCKER"]
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

# ubuntu docker Post-installation steps

- check to docker log for warning

```
journalctl -xu docker
journalctl -xu docker.service
```
- check-config

>curl https://raw.githubusercontent.com/docker/docker/master/contrib/check-config.sh > check-config.sh



APACHE=$(docker run -d httpd:2.4.38-alpine)
MYSQL=$(docker run --name mysql -e MYSQL_ROOT_PASSWORD=mysql -d mysql:5.5)

pipework br1 $APACHE 192.168.1.117/24


# 文件

```
CONTAINDER_ID = $(docker run -d image)
NS_PID = $(head -n 1 /sys/fs/cgroup/devices/docker/$CONTAINDER_ID/tasks)
LOCAL_PAIR_VETH=veth<NO>pl<NS_PID>
GUEST_PAIR_VETH=veth<NO>pg<NS_PID>
ip link set veth1pl1452 master br1
ip link set veth1pl1452 up
ip link set veth1pg1452 netns 1452
ip netns exec 1452 ip link set veth1pg1452 name eth1
ip netns exec 1452 ip -4 addr add 192.168.1.118/24 dev eth1
ip netns exec 1452 ip -4 link set eth1 up
```