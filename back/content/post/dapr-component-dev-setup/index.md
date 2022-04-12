+++
title = "Dapr组件开发环境搭建"
date = 2020-09-28T10:26:04+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["PaaS", "EDA", "DDD"]
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


# 开发环境准备

```
git version 2.34.1.windows.1



cmd>docker version
Client:
 Cloud integration: v1.0.22
 Version:           20.10.12
 API version:       1.41
 Go version:        go1.16.12
 Git commit:        e91ed57
 Built:             Mon Dec 13 11:44:07 2021
 OS/Arch:           windows/amd64
 Context:           default
 Experimental:      true


go version go1.17.5 windows/amd64
```

## golangci-lint


在windows上启动git Bash执行如下sh命令安装golangci-lint

```
# binary will be $(go env GOPATH)/bin/golangci-lint
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.44.2
golangci-lint --version
```

## 安装make

```
choco install mingw --version 8.1.0

cmd>make -v
GNU Make 4.3
Built for Windows32
```

## 安装coreutils(可选)

Git Bash有部分coreutils工具，如果从Git Bash构建，可以不用安装coreutils

```
choco install gnuwin32-coreutils.install
```

https://github.com/dapr/dapr/blob/master/docs/development/setup-dapr-development-env.md


# 代码

```
cd %GOPATH%/src

# Clone dapr
mkdir -p github.com\dapr\dapr
git clone https://github.com/dapr/dapr.git github.com\dapr\dapr

# Clone component-contrib
mkdir -p github.com\dapr\components-contrib
git clone https://github.com/dapr/components-contrib.git github.com\dapr\components-contrib
```

## 用Git Bash构建

```
MINGW64 /d/code/go/src/github.com/dapr/dapr
$which head
$make
```

## Proto客户端生成

1. 安装protoc

https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/protoc-3.14.0-win64.zip

2. 安装Go PB插件protoc-gen-go, protoc-gen-go-grpc

```
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```

或者用make工具安装PB插件

```
make init-proto
```

# dapr初始化

![](/img/post/dapr-init.jpeg)