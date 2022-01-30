+++
title = "Mysql Relocate the Data Directory"
date = 2022-01-30T19:44:00+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = []
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


# cp data file

```
cp /var/lib/mysql /data -Rf
chown -R mysql:mysql /data/mysql
```

# AppArmor 


`/etc/apparmor.d/local/usr.sbin.mysqld`

```
/data/mysql r,
/data/mysql/** rwk, 
```

```
sudo systemctl reload apparmor 
```

# sudo as myql

```
sudo -s -u mysql
```

# mysql 时间类型支持微秒


MySQL permits fractional seconds for TIME, DATETIME,
and TIMESTAMP values, with up to microseconds (6 digits)
Mysql DATETIME(6)  DATETIME[(fsp)]
The fsp value, if given, must be in the range 0 to 6. A value of 0
signifies that there is no fractional part. If omitted, the default
precision is 0. (This differs from the standard SQL default of 6,
for compatibility with previous MySQL versions.)