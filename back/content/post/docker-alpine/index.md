+++
title = "Docker Alpine"
date = 2017-03-31T15:07:18+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["DOCKER"]
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


# set date

```
FROM alpine:3.8
RUN apk add --no-cache tzdata && rm -rf /var/cache/apk/*
ENV TZ Asia/Shanghai
RUN ln -s /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
```

```
docker run -it --rm -e TZ=Asia/Shanghai alpine:3.8 ash
```

创建`/etc/localtime`

```
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```