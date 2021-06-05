+++
title = "Web性能优化指南"
date = 2021-06-06T06:56:24+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = []
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


##  应用优化


Eliminating unnecessary data transfers is, of course, the single best optimization—e.g.,
eliminating unnecessary resources or ensuring that the minimum number of bits is
transferred by applying the appropriate compression algorithm. Following that, locating
the bits closer to the client, by geo-distributing servers around the world—e.g., using a
CDN—will help reduce latency of network roundtrips and significantly improve TCP
performance. Finally, where possible, existing TCP connections should be reused to
minimize overhead imposed by slow-start and other congestion mechanisms

- No bit is faster than one that is not sent; send fewer bits.
- We can’t make the bits travel faster, but we can move the bits closer.
- TCP connection reuse is critical to improve performance.

