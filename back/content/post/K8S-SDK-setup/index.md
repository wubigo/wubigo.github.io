+++
title = "K8S SDK Setup"
date = 2018-03-03T20:45:50+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["K8S", "SDK"]
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


# 安装Golang Dep

```
go get -v github.com/tools/godep
```

# 安装client-go

```
go get k8s.io/client-go/kubernetes
cd $GOPATH/src/k8s.io/client-go
git checkout v10.0.0
godep restore ./...
```

# 集群外开发

# 集群内开发