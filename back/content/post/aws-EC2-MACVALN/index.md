+++
title = "Aws EC2 MACVLAN"
date = 2018-02-28T16:56:16+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["AWS", "SDN"]
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



Amazon EC2 networking doesn't allow to use private ips in the containers 

through bridges or macvlan. Dedicating a network interface to a 

container makes it directly unreachable from the host.


```
docker network create -d macvlan --subnet 172.30.80.0/20 --gateway 172.30.80.1 -o parent=eth0 pub_net


docker run -d --network pub_net --ip 172.30.80.10 busybox
```


