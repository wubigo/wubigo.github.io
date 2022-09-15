+++
title = "Kernel Bypass Networking"
date = 2016-12-29T10:15:59+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["SDN", "NFV"]
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


RDMA (Remote Direct Memory Access), TOE (TCP Offload Engine), and OpenOnload. More recently, DPDK (Data Plane Development Kit) has been used in some applications to bypass the kernel, and then there are new emerging initiatives such as FD.io (Fast Data Input Output) based on VPP (Vector Packet Processing). More will likely emerge in the future.

Technologies like RDMA and TOE create a parallel stack in the kernel and solve the first problem (namely, the "kernel is too slow") while OpenOnload, DPDK and FD.io (based on VPP) move networking into Linux user space to address both speed and technology plug-in requirements. When technologies are built in the Linux user space, the need for changes to the kernel is avoided, eliminating the extra effort required to convince the Linux kernel community about the usefulness of the bypass technologies and their adoption via upstreaming into the Linux kernel.


![](/img/post/Kernel-Bypass-Networking.png)
