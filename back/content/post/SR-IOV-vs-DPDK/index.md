+++
title = "SR-IOV vs DPDK/VPP for NFV"
date = 2018-01-30T09:32:11+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["NFV", "SDN"]
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


Linux Bridge supported GRE Tunnels, but not the newer and more scalable VXLAN model
https://vincent.bernat.ch/en/blog/2017-vxlan-linux




![](/img/post/sr-iov.png)

This post will talk

about the various building blocks available to speed up packet processing

both hardware based e.g.SR-IOV, RDT, QAT, VMDq, VTD 

and software based e.g. DPDK, Fd.io/VPP, OVS etc and give

hands on lab experience


https://www.telcocloudbridge.com/blog/dpdk-vs-sr-iov-for-nfv-why-a-wrong-decision-can-impact-performance/