+++
title = "Minio配置为B2存储网关"
date = 2019-06-17T11:26:14+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["STORAGE", "SDS", "MINIO"]
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


## 配置


![](/img/post/minio-gateway-b2.png)


- 下载B2 TLS安全证书

```
openssl s_client -showcerts -connect api.backblazeb2.com:443 > b2.crt

mv b2.crt .minio/certs/CAs/

set MINIO_ACCESS_KEY=B2_keyID
set MINIO_SECRET_KEY=B2_applicationKey
minio gateway b2
```



