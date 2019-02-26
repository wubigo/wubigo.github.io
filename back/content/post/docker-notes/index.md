+++
title = "Docker Notes"
date = 2016-01-25T17:11:05+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["DOCKER"]
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

# ubuntu docker Post-installation steps

- check to docker log for warning

```
journalctl -xu docker
journalctl -xu docker.service
```
- check-config

>curl https://raw.githubusercontent.com/docker/docker/master/contrib/check-config.sh > check-config.sh



