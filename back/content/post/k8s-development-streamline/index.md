+++
title = "K8s Development Streamline with draft"
date = 2018-02-24T07:30:53+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["K8S", "APP"]
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

# 准备

- 初始化

```shell
draft init

...
Installing default plugins...
Preparing to install into /home/bigo/.draft/plugins/draft-pack-repo
draft-pack-repo installed into /home/bigo/.draft/plugins/draft-pack-repo/draft-pack-repo
Installed plugin: pack-repo
Installation of default plugins complete
Installing default pack repositories...
Installing pack repo from https://github.com/Azure/draft
Installed pack repository github.com/Azure/draft
Installation of default pack repositories complete
$DRAFT_HOME has been configured at /home/bigo/.draft.
...
```

- 设置docker镜像寄存器

```
draft config set registry 
```


# 应用设置

```
cd code/go/
ls
app.go
draft create
ls
app.go charts  Dockerfile  draft.toml 

```