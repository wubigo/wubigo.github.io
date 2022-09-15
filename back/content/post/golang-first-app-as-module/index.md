+++
title = "Go语言第一个基于模块应用"
date = 2018-01-12T07:42:41+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["GO", "GOMOD"]
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


## 模块初始化

```
mkdir -p $GOPATH/src/github.com
cd $GOPATH/src/github.com
mkdir -p wubigo/API/go/hello
cd wubigo/API/go/hello
go mod init github.com/wubigo/API/go/hello
```

- 检查`go.mod`

```
ll
go.mod

cat go.mod


module github.com/wubigo/API/go/hello

go 1.13

```

## 创建程序

`hello.go`

```
package main  

import (
        "fmt"

        "github.com/google/go-cmp/cmp"
)
func main() {
    fmt.Println(cmp.Diff("Hello World", "Hello Go"))
}

```



**package main声明该模块是一个可执行程序而不是共享库**

## 编译测试


```
go install github.com/wubigo/API/go/hello
```

或者

```
go install  .
```

或者

```
go install -n
```

- 检查go.mod

`go.mod`

```
module github.com/wubigo/API/go/hello

go 1.13

require github.com/google/go-cmp v0.4.0

```

- 检查程序

```
ll $$GOPATH/bin
hello
```

- 测试



## 清理

```
go clean -i -n
```



## 提交代码

提交代码应包含go.mod


```
git add .
git commit -m "application managed by module"
```


