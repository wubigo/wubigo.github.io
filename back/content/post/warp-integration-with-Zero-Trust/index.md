+++
title = "Warp Integration With Zero Trust"
date = 2025-12-05T21:26:35+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["VPN"]
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


# WARP诊断


运行warp-diag，warp把所有诊断信息及其日志信息打包，并默认发送到桌面，

解压分析诊断信息。

```
cmd\>warp-diag

cmd\>type warp-tunnel-stats.txt

Tunnel Protocol: MASQUE (HTTP/3)
Endpoints: 162.159.198.2, ::
Time since last handshake: 2002s
Sent: 17.7MB; Received: 59.2MB
Estimated latency: 212ms
Estimated loss: 0.47%
TLS Handshake:
	Version: TLSv1.3
	Post-Quantum enabled: true
	Elliptic curve: P256Kyber65erDraft00
	Cipher suite: TLS_AES_256_GCM_SHA384

```






