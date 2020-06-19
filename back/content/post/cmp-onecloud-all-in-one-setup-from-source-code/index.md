+++
title = "从源代码构建Onecloud"
date = 2020-06-19T21:42:01+08:00
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

## 安装ansible

```
pip install ansible
```

## OCBOOT

```
git clone https://github.com/yunionio/ocboot.git
cd ocboot
./run.py ./config-allinone.yml
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

ocboot -> ocadm -> 部署k8s 和 onecloud-operator


## FAQ

- ocadm需要kubelet预先安装好
