+++
title = "Tcpdump Windows"
date = 2018-04-24T19:24:49+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["TCP", "NETWORK", "WEB"]
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


# install winpcap and windump

https://www.winpcap.org

```
mv windump tcpdump
```






# list all interfaces

```
tcpdump -D
```

# dump on interface

```
tcpdump -i 1 -n dst host 172.17.17.6
```

```
tcpdump -i 3 tcp port 8100

tcpdump: listening on \Device\NPF_{BE2B782C-98A1-49A3-8F59-25C5A41A4B41}
10:08:11.958366 IP loaclhost.49692 > wu-pc.8100: S 2181860964:2181860964(0) win 64240 <mss 1460,nop,wscale 8,nop,nop,sackOK>
10:08:11.958513 IP wu-pc.8100 > loaclhost.49692: S 2062460989:2062460989(0) ack 2181860965 win 65535 <mss 1460,nop,wscale 8,nop,nop,sackOK>
10:08:11.979568 IP loaclhost.49692 > wu-pc.8100: . ack 1 win 513
10:08:11.982906 IP loaclhost.49692 > wu-pc.8100: P 1:217(216) ack 1 win 513
10:08:11.985277 IP wu-pc.8100 > loaclhost.49692: P 1:478(477) ack 217 win 1025
10:08:11.985537 IP wu-pc.8100 > loaclhost.49692: F 478:478(0) ack 217 win 1025
10:08:12.006760 IP loaclhost.49692 > wu-pc.8100: . ack 479 win 511
10:08:12.007554 IP loaclhost.49692 > wu-pc.8100: F 217:217(0) ack 479 win 511
10:08:12.007621 IP wu-pc.8100 > loaclhost.49692: . ack 218 win 1025
```

# See entire packet payload using tcpdump

```
tcpdump -nnvvXSs 1514 -i 1 -n dst host 172.17.17.6
```






[1] [The Secret To 10 Million Concurrent Connections]http://highscalability.com/blog/2013/5/13/the-secret-to-10-million-concurrent-connections-the-kernel-i.html


[2] [A User-Level TCP Stack for Processing 40 Million Concurrent TCP Connections]https://ieeexplore.ieee.org/abstract/document/8422993


