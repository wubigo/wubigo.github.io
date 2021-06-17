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


## TCP性能优化检查清单

• Upgrade server kernel to latest version (Linux: 3.2+).
• Ensure that cwnd size is set to 10.
• Disable slow-start after idle.
• Ensure that window scaling is enabled.
• Eliminate redundant data transfers.
• Compress transferred data.
• Position servers closer to the user to reduce roundtrip times.
• Reuse established TCP connections whenever possible.

## UDP性能优化检查清单

• Application must tolerate a wide range of Internet path conditions.
• Application should control rate of transmission.
• Application should perform congestion control over all traffic.
• Application should use bandwidth similar to TCP.
• Application should back off retransmission counters following loss.
• Application should not send datagrams that exceed path MTU.
• Application should handle datagram loss, duplication, and reordering.
• Application should be robust to delivery delays up to 2 minutes.
• Application should enable IPv4 UDP checksum, and must enable IPv6 checksum.
• Application may use keepalives when needed (minimum interval 15 seconds).

## TLS性能优化检查清单

 • Get best performance from TCP.
 • Upgrade TLS libraries to latest release, and (re)build servers against them.
 • Enable and configure session caching and stateless resumption.
 • Monitor your session caching hit rates and adjust configuration accordingly.
 • Terminate TLS sessions closer to the user to minimize roundtrip latencies.
 • Configure your TLS record size to fit into a single TCP segment.
 • Ensure that your certificate chain does not overflow the initial congestion window.
 • Remove unnecessary certificates from your chain; minimize the depth.
 • Disable TLS compression on your server.
 • Configure SNI support on your server.
 • Configure OCSP stapling on your server.
 • Append HTTP Strict Transport Security header.