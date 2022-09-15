+++
title = "Mysql Master"
date = 2013-01-22T17:08:07+08:00
tags = ["SHELL", "MYSQL"]
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



```
[mysqld]

log-bin = master-bin
log-bin-index = master-bin.index
server-id = 1
```


Grant the user to retrieve the binary log from the master

```
mysql>CREATE USER repl_user;
GRANT REPLICATION SLAVE ON *.* TO repl_user IDENTIFIED BY 'xyzzy';
```