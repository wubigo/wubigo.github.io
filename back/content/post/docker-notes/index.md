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

![](/img/post/container-docker.png)

# 端口绑定

By default, when you create or run a container using docker create or docker run, it does not publish any of its ports to the outside world. To make a port available to services outside of Docker, or to Docker containers which are not connected to the container’s network, use the --publish or -p flag. This creates a firewall rule which maps a container port to a port on the Docker host to the outside world


```
docker  port <container-name>
```



# 容器组件

```
$ ps fxa | grep docker
 1046 ?        Ssl   86:30 /usr/bin/dockerd -H fd://
 1129 ?        Ssl   61:37  \_ docker-containerd --config /var/run/docker/containerd/containerd.toml
 4370 ?        Sl     0:01  |   \_ docker-containerd-shim -namespace moby -workdir /var/lib/docker/containerd/daemon/io.containerd.runtime.v1.linux/moby/187543746f3caaac62254b8aee40a7c5c8060d54722fa631a7cdfadd0722c71a -address /var/run/docker/containerd/docker-containerd.sock -containerd-binary /usr/bin/docker-containerd -runtime-root /var/run/docker/runtime-runc
 4352 ?        Sl     0:00  \_ /usr/bin/docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 443 -container-ip 172.17.0.3 -container-port 443
 4364 ?        Sl     0:00  \_ /usr/bin/docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 80 -container-ip 172.17.0.3 -container-port 80
 3897 pts/1    S+     0:00              \_ grep --color=auto docker

```

# Multi-stage builds in Docker

**only support for Doceker version > 17.05**

https://blog.alexellis.io/mutli-stage-docker-builds/


```
FROM golang:1.10 as builder
# build env and make target
FROM alpine:latest
WORKDIR /root/
COPY --from=builder ./
```

# busybox nslookup

**busybox:latest has bug on nslookup**

```
docker network create test
32024cd09daca748f8254468f4f00893afc2e1173c378919b1f378ed719f1618
docker run -dit --name nginx --network test nginx:alpine
7feaf1f0b4f3d421603bbb984854b753c7cbc6b581dd0a304d3b8fccf8c6604b
$ docker run -it --rm --network test busybox:1.28 nslookup nginx
Server:    127.0.0.11
Address 1: 127.0.0.11
Name:      nginx
Address 1: 172.22.0.2 nginx.test
docker stop nginx
docker network rm test
```


# docker proxy

`/etc/systemd/system/docker.service.d/https-proxy.conf`

```
[Service]
Environment="HTTP_PROXY=http://127.0.0.1:33351/"
Environment="HTTPS_PROXY=http://127.0.0.1:33351/"
```

```
sudo systemctl daemon-reload
sudo systemctl restart docker
systemctl show --property=Environment docker
```

# docker clean up disk space

- delete volumes
- 
```
$ docker volume rm $(docker volume ls -qf dangling=true)
$ docker volume ls -qf dangling=true | xargs -r docker volume rm
```

```
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
docker rmi $(docker images | grep "none" | awk '/ / { print $3 }')
docker rm $(docker ps -qa --no-trunc --filter "status=exited")
```

**Caution**
```
docker system prune -a
```

# ubuntu docker Post-installation steps

- check to docker log for warning

```
journalctl -xu docker
journalctl -xu docker.service
```
- check-config

>curl https://raw.githubusercontent.com/docker/docker/master/contrib/check-config.sh > check-config.sh



```
docker run -d --name web httpd:2.4.38-alpine
docker run --name mysql -e MYSQL_ROOT_PASSWORD=mysql -d mysql:5.5
docker run -it --name curl bigo/curl:v1
sudo pipework br1 web 192.168.1.117/24
sudo pipework br1 mysql 192.168.1.118/24
sudo pipework br1 curl 192.168.1.119/24
docker exec -it curl curl 192.168.117
docker logs web
192.168.1.119 - - [28/Feb/2019:10:09:15 +0000] "GET / HTTP/1.1" 200 45
192.168.1.119 - - [28/Feb/2019:10:15:43 +0000] "GET / HTTP/1.1" 200 45

```


pipework eth2 web

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


为容器配置路由

```
sudo nsenter -t $(docker-pid web) -n ip route del default
sudo nsenter -t $(docker-pid web) -n ip route add default via 192.168.1.1 dev eth0
```

# 容器间通信

- icc 
inter-container communication

```
docker network create --driver bridge --subnet 192.168.200.0/24 --ip-range 192.168.200.0/24 -o "com.docker.network.bridge.enable_icc"="false" no-icc-network
```

- enable_ip_masquerade

是否允许NAT使用宿主的IP掩蔽来自容器访问宿主外的网络包的SOURCE IP  
```
com.docker.network.bridge.enable_ip_masquerade
```

# 改变默认的数据存储位置和驱动

- 配置

`daemon.json`

```
{
    "data-root": "/mnt/docker",
    "storage-driver": "overlay2"
}
```

- 移动数据

```
systemctl stop docker
mv /var/lib/docker/* /mnt/docker/
systemctl start docker
```

# 定位容器的VETH接口

```
docker exec CID sudo ethtool -S eth0
NIC statistics:
     peer_ifindex: 7
sudo ip link | grep 7
```


>capture all incoming IP traffic destined to the node 
except local traffic

```
sudo tcpdump -i enp0s25 tcp -n
sudo tcpdump -i enp0s25 dst host 192.168.1.5 and not src net 192.168.1.0/24
```


[1] https://www.securitynik.com/2016/12/docker-networking-internals-how-docker_16.html