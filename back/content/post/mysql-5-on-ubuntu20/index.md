+++
title = "install Mysql 5 on Ubuntu20"
date = 2012-01-20T06:37:33+08:00
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


# select myql 5.7

```
wget wget https://dev.mysql.com/get/mysql-apt-config_0.8.12-1_all.deb
dpkg -i mysql-apt-config_0.8.12-1_all.deb


```


# turns off the GPG check 

`sources.list.d/mysql.list`




```
deb [trusted=yes] http://repo.mysql.com/apt/ubuntu/ bionic mysql-5.7
```

# install mysql and create admin user

```
sudo apt update
apt-cache policy mysql-server | grep 5.7
sudo apt install  mysql-client=5.7.37-1ubuntu18.04  mysql-community-server=5.7.37-1ubuntu18.04
mysql -u root -p
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY 'pass' WITH GRANT OPTION
```



