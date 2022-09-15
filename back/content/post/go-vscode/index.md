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

根据code提示自动安装插件


## 手工安装插件


### go代理配置

```
set http_proxy=http://127.0.0.1:4910
```

### git代理配置

```
git config --global http.proxy https://127.0.0.1:4910
git config --global http.sslverify "false"

```

### 手工安装插件

```
go get -u -v github.com/go-delve/delve/cmd/dlv
go get -u -v github.com/ramya-rao-a/go-outline
go get -u -v github.com/ramya-rao-a/go-outline
go get -u -v github.com/acroca/go-symbols
go get -u -v github.com/mdempsky/gocode
go get -u -v github.com/rogpeppe/godef
go get -u -v golang.org/x/tools/cmd/godoc
go get -u -v github.com/zmb3/gogetdoc
go get -u -v golang.org/x/lint/golint
go get -u -v github.com/fatih/gomodifytags
go get -u -v golang.org/x/tools/cmd/gorename
go get -u -v sourcegraph.com/sqs/goreturns
go get -u -v golang.org/x/tools/cmd/goimports
go get -u -v github.com/cweill/gotests/...
go get -u -v golang.org/x/tools/cmd/guru
go get -u -v github.com/josharian/impl
go get -u -v github.com/haya14busa/goplay/cmd/goplay
go get -u -v github.com/uudashr/gopkgs/cmd/gopkgs
go get -u -v github.com/davidrjenni/reftools/cmd/fillstruct

```


## FAQ


- vscode go build __debug_bin: Access is denied

    create `go\.vscode\launch.json`

    ```
    {
      // Use IntelliSense to learn about possible attributes.
      // Hover to view descriptions of existing attributes.
      // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
      "version": "0.2.0",
      "configurations": [
          {
              "name": "Launch",
              "type": "go",
              "request": "launch",
              "mode": "auto",
              "program": "${fileDirname}",
              "env": {},
              "args": []
          }
      ]
    }
    ```


- fork/exec d:\cache\go-build618440214\b001\exe\sitemap.exe: Access is denied.

    简单的程序运行没有问题

    ```
    D:\code\>set go
    GOBIN=D:\code\go\bin
    GOPATH=d:\code\go
    GOTMPDIR=d:\cache
    ```
    VSCODE没有权限访问GOTMPDIR

    ```
    go run sitemap.go
    ```
     