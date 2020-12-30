+++
title = "SaaS Notes"
date = 2017-12-30T14:47:49+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["SAAS"]
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

## DDoS 基础防护

腾讯云 DDoS 基础防护本身免费，当用户购买了腾讯云 CVM、CLB 等服务时，会自动开启 DDoS 基础防护。

普通用户提供2Gbps的防护能力，最高可达10Gbps

## 高防IP

高防包不需要更改客户业务 IP，高防IP需要客户将腾讯的高防 IP 作为业务 IP 发布；

高防包只能防护一台云主机或一台负载均衡（ 1 个公网 IP），高防 IP 可防护多台云主机；

高防包只能防护腾讯云内设备，高防 IP 可防护非腾讯云设备