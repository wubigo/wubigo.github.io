+++
title = "Minio源代码安装"
date = 2018-12-11T15:46:02+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["MINIO", "STORAGE", "SDS", "GO"]
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

## 安装两种方式

### 从最新源代码发布版安装

- git设置代理


```
[user]
	email = hi@wubigo.com
	name = bigo
[http]
	proxy = http://127.0.0.1:49210
	sslverify = false

```

- 系统代理

```
set HTTP_PROXY=http://127.0.0.1:49210/
set HTTPS_PROXY=http://127.0.0.1:49210/
```

- 安装

```
go get github.com/minio/minio
```

### MAKE

```
mkdir -p $GOPATH/src/github.com/minio
cd $GOPATH/src/github.com/minio
git clone https://github.com/minio/minio.git
cd minio/
git checkout RELEASE.2020-01-03T19-12-21Z
make -n test
go install -v


mkdir -p /home/bigo/go/bin
which golint 1>/dev/null || (echo "Installing golint" && GO111MODULE=off go get -u golang.org/x/lint/golint)
which staticcheck 1>/dev/null || (echo "Installing staticcheck" && wget --quiet https://github.com/dominikh/go-tools/releases/download/2019.2.3/staticcheck_linux_amd64.tar.gz && tar xf staticcheck_linux_amd64.tar.gz && mv staticcheck/staticcheck /home/bigo/go/bin/staticcheck && chmod +x /home/bigo/go/bin/staticcheck && rm -f staticcheck_linux_amd64.tar.gz && rm -rf staticcheck)
which misspell 1>/dev/null || (echo "Installing misspell" && GO111MODULE=off go get -u github.com/client9/misspell/cmd/misspell)
echo "Running vet check"
GO111MODULE=on go vet github.com/minio/minio/...
echo "Running fmt check"
GO111MODULE=on gofmt -d cmd/
GO111MODULE=on gofmt -d pkg/
echo "Running lint check"
GO111MODULE=on /home/bigo/go/bin/golint -set_exit_status github.com/minio/minio/cmd/...
GO111MODULE=on /home/bigo/go/bin/golint -set_exit_status github.com/minio/minio/pkg/...
echo "Running staticcheck check"
GO111MODULE=on /home/bigo/go/bin/staticcheck github.com/minio/minio/cmd/...
GO111MODULE=on /home/bigo/go/bin/staticcheck github.com/minio/minio/pkg/...
echo "Running spelling check"
GO111MODULE=on /home/bigo/go/bin/misspell -locale US -error `find cmd/`
GO111MODULE=on /home/bigo/go/bin/misspell -locale US -error `find pkg/`
GO111MODULE=on /home/bigo/go/bin/misspell -locale US -error `find docs/`
GO111MODULE=on /home/bigo/go/bin/misspell -locale US -error `find buildscripts/`
GO111MODULE=on /home/bigo/go/bin/misspell -locale US -error `find dockerscripts/`
echo "Checking dependencies"
(env bash /home/bigo/go/src/github.com/minio/minio/buildscripts/checkdeps.sh)
echo "Building minio binary to './minio'"
GO111MODULE=on CGO_ENABLED=0 go build -tags kqueue --ldflags '-s -w -X github.com/minio/minio/cmd.Version=2020-01-11T22:29:24Z -X github.com/minio/minio/cmd.ReleaseTag=DEVELOPMENT.2020-01-11T22-29-24Z -X github.com/minio/minio/cmd.CommitID=b00cda8ad49ed0defa9df5e7230f8b536b8ccb17 -X github.com/minio/minio/cmd.ShortCommitID=b00cda8ad49e -X github.com/minio/minio/cmd.GOPATH=/home/bigo/go -X github.com/minio/minio/cmd.GOROOT=' -o /home/bigo/go/src/github.com/minio/minio/minio 1>/dev/null
echo "Running unit tests"
GO111MODULE=on CGO_ENABLED=0 go test -tags kqueue ./... 1>/dev/null
```