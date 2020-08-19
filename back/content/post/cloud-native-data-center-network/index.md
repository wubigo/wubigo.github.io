+++
title = "Cloud Native Data Center Network"
date = 2020-08-18T15:57:57+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["SDN"]
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

## Inline Versus Overlay Virtual Networks


In the inline model, every hop between the source and destination is aware of the virtual network the packet belongs to and uses this information to do lookups in the forwarding table. In the overlay network model, only the edges of the network keep track of the virtual networks; the core of the network is unaware of virtual networks. VLAN and VRF are examples of the inline model of virtual networks, whereas MPLS, VXLAN, and other IP-based VPNs are examples of the overlay model. I’ve encountered customer deployments where 32 to 64 VRFs were used


The primary benefits of the inline model are transparency and reduced packet header overhead. However, requiring every node along the path be aware of virtual networks makes the model very unscalable and inefficient. It scales poorly because, as we get to the core of the network, the core devices must keep track of every single virtual network to forward packets properly. It is inefficient because any change to the virtual network affects every node in the network. The more moving parts there are, the more possibility there is of introducing an error and causing unexpected problems. Anybody who has deployed VLANs is well aware of these two problems. The same holds for VRFs, as well