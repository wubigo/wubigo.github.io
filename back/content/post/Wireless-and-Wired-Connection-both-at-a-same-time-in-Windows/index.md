+++
title = "Wireless and Wired Connection Both at a Same Time in Windows"
date = 2019-05-10T16:57:56+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["NETWORK", "WINDOWS"]
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

# give the wireless network higher priority than the wired


```
WIRELESS CONNECTION > "Internet Protocol Version 4 (TCP/IPv4) Properties"
>  advanced TCP/IP setting > Automatic metric
```

Uncheck it. That will enable a text box named "Interface metric". Fill in a number. It needs to be larger than 1 (reserved for loopback) and the number(30) you choose for the wired network.



```
WIRED CONNECTION > "Internet Protocol Version 4 (TCP/IPv4) Properties"
>  advanced TCP/IP setting > Automatic metric
```


Again Uncheck "Automatic metric", and fill in a number in the "Interface metric" box. It needs to be larger than 1 but smaller than the number  above (15).

