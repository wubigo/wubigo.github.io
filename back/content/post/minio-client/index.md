+++
title = "Minio Client"
date = 2019-01-18T13:55:14+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["MINIO", "SDS", "SDK"]
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

## 安装mc

https://dl.min.io/client/mc/release/windows-amd64/mc.exe

```
mc config host add b2 http://192.168.1.3:9000   B2_keyID B2_applicationKey

```

- 本地文件同步到b2

```
mc cp -r . b2/wubigo/
```

## 安装S3CMD

```
https://github.com/s3tools/s3cmd/releases/download/v2.0.2/s3cmd-2.0.2.tar.gz

sudo python setup.py install

```

`~/.s3cfg`


```
# Setup endpoint
host_base = http://192.168.1.3:9000
host_bucket = http://192.168.1.3:9000
bucket_location = us-east-1
use_https = True

# Setup access keys
access_key =  Q3AM3UQ867SPQQA43P2F
secret_key = zuf+tfteSlswRu7BJ86wekitnifILbZam1KYY3TG

# Enable S3 v4 signature APIs
signature_v2 = False
```

- 同步本地文件到B2

```
s3cmd sync . s3://wubigo/
```



## 总结

在不进行任何优化的情况下，s3cmd比mc传输速度快好几倍
