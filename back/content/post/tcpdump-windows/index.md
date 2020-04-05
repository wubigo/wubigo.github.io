+++
title = "Tcpdump Windows"
date = 2018-04-24T19:24:49+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["TCP", "NETWORK", "WINDOWS"]
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




# list all interfaces

```
windump -D
```

# dump on interface

```
windump -i 1 -n dst host 172.17.17.6
```


# See entire packet payload using tcpdump

```
windump -nnvvXSs 1514 -i 1 -n dst host 172.17.17.6
```

