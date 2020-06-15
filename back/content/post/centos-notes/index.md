+++
title = "Centos Notes"
date = 2020-06-13T17:03:30+08:00
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


## DHCP

`/etc/sysconfig/network-scripts/ifcfg-enp0s3`

```
DEVICE=enp0s3
BOOTPROTO=dhcp
ONBOOT=yes
```

```
systemctl restart network
```


## 删除MariaDB

```
rpm -qa | grep mariadb
sudo yum remove -y mariadb mariadb-server
rpm -qa | grep mariadb
yum remove -y mariadb-libs-5.5.65-1.el7.x86_64

rm -rf /var/log/mariadb
rm -f /var/log/mariadb/mariadb.log.rpmsave
rm -rf /var/lib/mysql
rm -rf /usr/lib64/mysql
rm -rf /usr/share/mysql
```

- install

```
sudo yum install MariaDB-server
sudo systemctl start mariadb.service
```


## 安装polipo


```
git clone https://github.com/jech/polipo.git
cd polipo
git checkout polipo-1.1.1
yum groupinstall 'Development Tools'
yum install texinfo
make all
su -c 'make install'
```

