+++
title = "Penpot Dev Setup"
date = 2023-04-08T18:39:31+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["PM"]
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


# 启动开发环境

```
git clone git@github.com:penpot/penpot.git
pushd penpot
./manage.sh run-devenv
```

## 检查进程运行状态

```
docker exec -ti penpot-devenv-main bash
root@87691e4f990c:/home# sudo -EH -u penpot tmux ls
penpot: 4 windows (created Sat Apr  8 10:27:39 2023) (attached)
```