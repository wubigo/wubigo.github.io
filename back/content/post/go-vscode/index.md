+++
title = "Go Vscode环境配置"
date = 2017-12-22T15:29:31+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["GO"]
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


## go version


```
go version
go version go1.13.5 windows/amd64
```

## vs proxy

![](/img/post/vscode-proxy.png)



## 手工安装插件


### go和git 代理配置

```
set http_proxy=http://127.0.0.1:4910
git config --global http.proxy https://127.0.0.1:4910
git config --global http.sslverify "false"

```

### 安装插件

```
go get -v github.com/go-delve/delve/cmd/dlv
go get -v github.com/ramya-rao-a/go-outline

```


## FAQ


- vscode go build __debug_bin: Access is denied

    add *__debug_bin to `.gitignore`
    
     