+++
title = "Onecloud Source Code Dev Note"
date = 2018-06-10T11:13:09+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["CMP"]
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

## keystone

`\etc\yunion\keystone.conf`

- 初始化

```
auto_sync_table: true
```

自动创建表，创建完后关闭


```
 kubectl describe cm -n onecloud default-keystone
```


## 搭建

```
git clone https://github.com/yunionio/ocboot.git
cd ocboot
```

`allinone.yml`

```
mariadb_node:
  use_local: true
  hostname: 192.168.137.190
  user: root
  db_user: root
  db_password: qwe123
primary_master_node:
#master_node:
  use_local: true
  hostname: 192.168.137.190
  user: root
  db_host: 192.168.137.190
  db_user: root
  db_password: qwe123
  onecloud_user: demo
  onecloud_user_password: demo@123
  controlplane_host: 192.168.137.190
  controlplane_port: "6443"
  as_host: true
  registry_mirrors:
  - https://lje6zxpk.mirror.aliyuncs.com
```

```
ansible-playbook -e ANSIBLE_HOST_KEY_CHECKING=False -i /root/ocboot/onecloud/zz_generated.hosts /root/ocboot/onecloud/zz_generated.site.yml -vv

```