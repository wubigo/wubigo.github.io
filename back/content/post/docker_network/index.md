+++
title = "Docker网络"
date = 2017-03-02T11:10:51+08:00
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


# 容器网络

容器网络方案 = 接入 + 流控 + 通道

![](/img/container-netowork.png)




# docker默认的网络

[桥接网络](/post/docker_network_bridge/)


# Docker网络macvlan

[网络macvlan](/post/docker_network_macvlan/)

# Docker宿主网络

[宿主网络](/post/docker-network-host/)

# Docker覆盖网络

# 宿主端口绑定

绑定方式： -p


绑定形式

>ip:hostPort:containerPort| ip::containerPort \
  | hostPort:containerPort | containerPort

containerPort必须指定

```
docker run --rm --name web -p 80:80 -v /home/bigo/site:/usr/share/nginx/html:ro -d nginx:1.14-alpine
```

docker 会为端口绑定的容器自动启动docker-proxy进程
```
docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 80 -container-ip 172.17.0.2 -container-port 80
```


