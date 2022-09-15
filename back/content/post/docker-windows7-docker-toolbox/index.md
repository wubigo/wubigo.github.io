+++
title = "Docker Windows7 Docker Toolbox"
date = 2018-04-28T17:08:07+08:00
tags = ["WINDOWS", "DOCKER"]
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.

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


# docker proxy

```
run cmd as administrator
cmd>cd $GIT_HOME
cmd>echo > .bash_profile
export HTTP_PROXY=http://127.0.0.1:1080
export HTTPS_PROXY=http://127.0.0.1:1080
export no_proxy=localhost,127.0.0.1,192.168.99.100
```