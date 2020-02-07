+++
title = "Aws Billing Notes"
date = 2016-02-06T22:24:48+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["AWS"]
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

## NAT GATEWAY

![](/img/post/aws-billing.png)


## 数据备份S3


**Infrequent Access Tier, All Storage / Month	$0.0125 per GB**

- Archive 50 TB into Amazon S3

If you perform a one-time migration of 50 TB of 16 MB files into Amazon S3 in US East (Ohio), it costs you the following to use DataSync:
(50 TB copied into S3 * 1024 GB * $0.0125/GB) + (1 S3 LIST request * $0.005 / 1000) + (50 TB / 16 MB S3 PUT requests * $0.005 / 1000)
= $640 + $0 + $16.38
= $656.38


Total data copied by AWS DataSync per month: 20000 TB x 1024 GB in a TB = 20480000 GB
Pricing calculations

20,480,000 GB x 0.0125 USD = 256,000.00 USD

AWS DataSync Pricing (monthly): 256,000.00 USD
AWS DataSync Pricing (yearly): 256,000.00 * 12 = 3,072,000 USD

## 数据存储S3

**Frequent Access Tier, Over 500 TB / Month	$0.021 per GB**

20,480,000 GB x 0.021 USD = 512,000.00 USD  +  READ REQUEST * $0.005 / 1000

