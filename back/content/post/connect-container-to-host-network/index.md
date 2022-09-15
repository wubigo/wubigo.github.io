+++
title = "容器多种方式链接宿主网络"
date = 2017-04-25T07:10:55+08:00
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

**提示**：
以下操作是在VirtualBox虚机环境，并做如下配置

- 网络

下拉高级设置，在"Adapter Type"选择PCnet-FAST III", 而不是默认的e1000 (Intel PRO/1000). 
另外"Promiscuous Mode"必须设置为"Allow All". 否则通过网桥连接的容器无法工作, 因为虚拟网卡
会过滤掉掉所有带有不同MAC的数据包。

- 多网卡

每块网卡都要做上述调整

# 准备

- 安装util-linux

```
sudo apt install util-linux
```

`/etc/network/interface`

```
cat interfaces
# interfaces(5) file used by ifup(8) and ifdown(8)
auto lo
iface lo inet loopback

auto enp0s3
iface enp0s3 inet static
address 192.168.1.10
netmask 255.255.255.0
gateway 192.168.1.1
dns-nameservers 192.168.1.1

auto enp0s8
iface enp0s8 inet static
address 192.168.1.16
netmask 255.255.255.0
dns-nameservers 192.168.1.1
```

```shell
ip route
default via 192.168.1.1 dev enp0s3  onlink 
169.254.0.0/16 dev enp0s3  scope link  metric 1000 
172.17.0.0/16 dev docker0  proto kernel  scope link  src 172.17.0.1 linkdown 
192.168.1.0/24 dev enp0s3  proto kernel  scope link  src 192.168.1.10 
192.168.1.0/24 dev enp0s8  proto kernel  scope link  src 192.168.1.16 
```


# 使用NAT

- docker host network

assign a second ip to host interface

```
export SIP=192.168.1.117
sudo ip addr add $SIP/24 dev enp0s3

```

bind container to SIP host network

```
docker run -it --name web -p ${SIP}:80:80 nginx:1.14-alpine
sudo iptables -L DOCKER -v -n

Chain DOCKER (1 references)
 pkts bytes target     prot opt in        out      source           destination         
    7   528 ACCEPT     tcp  --  !docker0  docker0  0.0.0.0/0       172.17.0.2           tcp dpt:80

```
>

```
sudo iptables -t nat -I POSTROUTING -s 172.17.0.2 \
    -j SNAT --to-source 192.168.1.119


sudo iptables -t nat -L -n -v
```

# 使用LINUX网桥

- 查看网卡的ip

```
ifconfig enp0s8
enp0s3    Link encap:Ethernet  HWaddr 08:00:27:4e:18:68  
          inet addr:192.168.1.16
```

- 创建网桥br-enp0s8并把enp0s8的IP分配给网桥，把enp0s8连接到网桥 

```
sudo brctl addbr br-enp0s8
sudo ip link set br-enp0s8 up
sudo ip addr add 192.168.1.111/24 dev br-enp0s8; \
    ip addr del 192.168.1.111/24 dev enp0s8; \
    brctl addif br-enp0s8 enp0s8; \
    ip route del default; \
    ip route add default via 192.168.1.1 dev br-enp0s8


ifconfig br-enp0s8
br-enp0s8 Link encap:Ethernet  HWaddr 08:00:27:4e:18:68  
          inet addr:192.168.1.16

ifconfig enp0s8
enp0s8    Link encap:Ethernet  HWaddr 08:00:27:4e:18:68

```
br-enp0s8和enp0s8拥有相同的HWaddr(Mac地址)

- 确认网络是否对外连接正常


```
ip route
default via 192.168.1.1 dev br-enp0s8 
169.254.0.0/16 dev enp0s3  scope link  metric 1000 
172.17.0.0/16 dev docker0  proto kernel  scope link  src 172.17.0.1 linkdown 
192.168.1.0/24 dev enp0s3  proto kernel  scope link  src 192.168.1.10 
192.168.1.0/24 dev br-enp0s8  proto kernel  scope link  src 192.168.1.16 
```

```
curl -IL https://wubigo.com
HTTP/1.1 200 OK
```



- 启动容器

```
docker run -it --rm --name web -p 80 nginx:1.14-alpine
```
- 创建veth接口对web-int/web-ext:

```
sudo ip link add web-int type veth peer name web-ext
```
- 连接veth一端web-ext到网桥

```
sudo brctl addif br-enp0s8 web-ext
```

- 连接veth的另一端web-int连接到容器的网络名字空间

```
sudo ip link set netns $(docker-pid web) dev web-int
sudo nsenter -t $(docker-pid web) -n ip link set web-int up
sudo nsenter -t $(docker-pid web) -n ip addr add 192.168.1.117/24 dev web-int
```

- 检查容器已经连接到web-int并且ip地址正确分配

```
docker exec -it web ifconfig
eth0      Link encap:Ethernet  HWaddr 02:42:AC:11:00:02  
          inet addr:172.17.0.2  Bcast:0.0.0.0  Mask:255.255.0.0
          inet6 addr: fe80::42:acff:fe11:2/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:84 errors:0 dropped:0 overruns:0 frame:0
          TX packets:21 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:9396 (9.1 KiB)  TX bytes:2348 (2.2 KiB)

web-int   Link encap:Ethernet  HWaddr 5A:1D:90:CF:6B:2C  
          inet addr:192.168.1.117  Bcast:0.0.0.0  Mask:255.255.255.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

```

```
docker exec -it web ip route
default via 172.17.0.1 dev eth0 
172.17.0.0/16 dev eth0 scope link  src 172.17.0.2 
192.168.1.0/24 dev web-int scope link  src 192.168.1.117 
```

- 设置web-int为容器路由默认接口

```
sudo nsenter -t $(docker-pid web) -n ip route del default
sudo nsenter -t $(docker-pid web) -n ip route add default via 192.168.1.1 dev web-int
```




- 测试清理

```
docker rm web
sudo ip link set br-enp0s8 down
sudo brctl delbr br-enp0s8
```