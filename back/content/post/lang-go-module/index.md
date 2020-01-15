+++
title = "Go Module"
date = 2017-03-22T15:09:20+08:00
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


## 模块

A module is a collection of related Go packages that are versioned together as a single unit.

Modules record precise dependency requirements and create reproducible builds.

- go.mod

A module is defined by a tree of Go source files with a go.mod file in the tree's root directory. Module source code may be located outside of GOPATH. There are four directives: module, require, replace, exclude.

## 显示当前的模块和依赖


```
go list -m all
```

### 显示特定模块的所有版本标签 

```
go list -m -versions github.com/minio/cli
```

### 模块API说明书

```
go doc github.com/minio/cli
```

## How to Use Modules

- How to Install and Activate Module Support
  + Install the latest Go 1.11 release.

  Once installed, you can then activate module support in one of two ways:

    Invoke the go command in a directory outside of the $GOPATH/src tree, with a valid go.mod file in the current directory or any parent of it and the environment variable GO111MODULE unset (or explicitly set to auto).
    Invoke the go command with GO111MODULE=on environment variable set.



https://blog.golang.org/using-go-modules

https://semver.org/