+++
title = "Linux Bridge"
date = 2017-07-28T08:36:18+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["SDN","NFV"]
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



Some things worth noting in br_add_if:

- Only ethernet like devices can be added to bridge, as bridge is a layer 2 device.
- Bridges cannot be added to a bridge.
- New interface is set to promiscuous mode: dev_set_promiscuity(dev, 1)

https://goyalankit.com/blog/linux-bridge