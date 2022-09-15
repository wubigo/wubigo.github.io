+++
title = "Aws S3 Web Hosting"
date = 2017-12-26T17:13:28+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["AWS","S3"]
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


## 创建BUCKET

使用两种方式之一创建BUCKET

- terraform

```
git clone https://github.com/wubigo/iaas

cd s3

terraform apply

```

- awscli

```
aws s3 website s3://s.wubigo.com/ --index-document index.html --error-document 404.html
aws s3api put-bucket-policy --bucket s.wubigo.com --policy file://policy.json
```


### 确认配置

```
aws s3api get-bucket-website --bucket s.wubigo.com
{
    "IndexDocument": {
        "Suffix": "index.html"
    },
    "ErrorDocument": {
        "Key": "404.html"
    }
}

```

##  配置DNS C记录

查看S3 Website Endpoints: s.wubigo.com.s3-website-ap-northeast-1.amazonaws.com

![](/img/post/s3-web.png)


```
CNAME Record	    s    s.wubigo.com.s3-website-ap-northeast-1.amazonaws.com
```


## 上传站点内容


```
aws s3 cp wubigo.github.io s3://s.wubigo.com/ --recursive
```
