+++
title = "Go穿越Firewall"
date = 2018-03-22T14:34:01+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["LANG", "GO"]
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


# go doc

https://golang.google.cn

# proxy

- 从 Github 的代码库 clone

```
go get -u github.com/golang/text
mv $GOPATH/src/github.com/golang/text $GOPATH/src/golang.org/x/text

go get -u github.com/golang/crypto
mv $GOPATH/src/github.com/golang/crypto $GOPATH/src/golang.org/x/crypto
```

- 设置 GOPROXY 环境变量配置代理

例如：GOPROXY=https://goproxy.io



https://github.com/northbright/Notes/blob/master/Golang/china/get-golang-packages-on-golang-org-in-china.md

https://gocn.vip/article/1678