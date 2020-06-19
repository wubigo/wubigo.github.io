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

## climc

```
export KUBECONFIG=/etc/kubernetes/admin.conf
source <(kubectl completion bash)
source <(ocadm cluster rcadmin)


ocadm cluster rcadmin
export OS_AUTH_URL=https://10.8.3.231:30500/v3
export OS_USERNAME=sysadmin
export OS_PASSWORD=kHJ8RUv9ZnXM8dB3
export OS_PROJECT_NAME=system
export YUNION_INSECURE=true
export OS_REGION_NAME=region0
export OS_ENDPOINT_TYPE=publicURL


 climc service-list --limit 30
+----------------------------------+------------------+------------------+
|                ID                |       Name       |       Type       |
+----------------------------------+------------------+------------------+
| e3542d1d411342128a27d768f0ee2355 | monitor          | monitor          |
| 78d193ba157c4f5e894c6ba562a4bf46 | notify           | notify           |
| 6d0f8ba57a2b4f95834aabf35b2b60ee | log              | log              |
| 7b81c471a8174a7181e966e9c240031a | cloudevent       | cloudevent       |
| 45a984fa8cde426a8aff471a5235c6fa | devtool          | devtool          |
| 3b8a28d49abb43238d5d70743cc82073 | k8s              | k8s              |
| aa92817f666b468f858e12e24543a50a | autoupdate       | autoupdate       |
| 69c977c7a1d348738ebb4afa4004c1a0 | yunionconf       | yunionconf       |
| 5aa6bef960c84fcd8b0befd9433eac13 | cloudnet         | cloudnet         |
| 44540d5bee304eca8df2afa6db245c07 | baremetal        | baremetal        |
| 757fc06c274d4898882c8454d21e9f38 | webconsole       | webconsole       |
| 6a489082b899415a8ebb7ff36549372a | s3gateway        | s3gateway        |
| 0433e9da686940428e270da2726d1999 | influxdb         | influxdb         |
| 2ba92f93d97c423c898181ee01553bbf | host             | host             |
| d1ac196db62c4dfb8ae89386fa9adbe4 | meter            | meter            |
| 5f032e88f8c143178396de326e132880 | websocket        | websocket        |
| 18f7844be9f343d48dccf09c0ccf2d22 | yunionapi        | yunionapi        |
| 8286d967b6a543368a003af964ea7d8f | ansible          | ansible          |
| 2598d51c504241cf87816946471918e5 | yunionagent      | yunionagent      |
| a8bdb942b5d94ec7820908fca06024ed | glance           | image            |
| 80f40414f0bb43d88f4d7d3c7c0c0102 | scheduler        | scheduler        |
| e5ec699df47046cc8cfc886f6f1d43ef | region2          | compute_v2       |
| c889bded7d1240088d4a6319a0ffc59d | keystone         | identity         |
| 62be59b2ff3f433e8eef225558759dd9 | offlinecloudmeta | offlinecloudmeta |
| 5e6c21fe140045538b6defbc51c4ac76 | torrent-tracker  | torrent-tracker  |
| 59c52837183d4e6488baa87a17136c64 | cloudmeta        | cloudmeta        |
| 57238806433146da81540364d4699e78 | common           | common           |
| 0107fd19803c41c58eadfb5920908ab3 | external-service | external-service |
+----------------------------------+------------------+------------------+
***  Total: 28 Pages: 1 Limit: 30 Offset: 0 Page: 1  ***

```


## keystone


```
git clone https://github.com/yunionio/onecloud.git --branch=v3.1.8
```

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