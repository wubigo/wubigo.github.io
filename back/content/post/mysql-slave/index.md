+++
title = "Mysql Slave"
date = 2013-04-27T17:08:07+08:00
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
server-id = 2
relay-log-index = slave-relay-bin.index
relay-log = slave-relay-bin
```




```
mysql>CHANGE MASTER TO MASTER_HOST = 'db2',MASTER_PORT = 3306, MASTER_USER = 'repl_user', MASTER_PASSWORD = 'xyzzy';
```

# Connecting the Master

```
mysql> START SLAVE;
```