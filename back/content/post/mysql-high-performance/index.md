+++
title = "Mysql High Performance"
date = 2018-01-08T14:20:48+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["MYSQL", "SQL"]
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


## InnoDB

MySQL 5.1 shipping the older version of InnoDB, If you’re using MySQL 5.1, please ensure that you’re using the InnoDB
plugin. It’s much better than the older version of InnoDB.

It now scales well to 24 CPU cores, and arguably up to 32 or
even more cores depending on the scenario