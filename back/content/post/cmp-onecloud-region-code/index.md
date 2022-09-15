+++
title = "Cmp Onecloud Region Code"
date = 2020-06-30T12:49:12+08:00
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

## config

```
climc service-config-edit region2
```

or 

```
kubectl describe cm default-region -n onecloud
```

`region.conf`

```
log_level: debug
log_verbose_level: 10
enable_host_health_check: false
enable_ssl: false
port: 30888
port_v2: 30888
```

## 依赖的模块 


- HTTP web framework

```
github.com/gin-gonic/gin
```

- ORM

```
https://github.com/go-gorm/gorm
```

## region endpoint


```
climc endpoint-show b0d33d8b370c42418cb3c6e51442c072
+--------------------+----------------------------------+
|       Field        |              Value               |
+--------------------+----------------------------------+
| can_delete         | false                            |
| can_update         | true                             |
| created_at         | 2020-06-23T03:03:20.000000Z      |
| deleted            | false                            |
| enabled            | true                             |
| id                 | b0d33d8b370c42418cb3c6e51442c072 |
| interface          | public                           |
| is_emulated        | false                            |
| name               | compute_v2-public                |
| public_key_bit_len | 0                                |
| region_id          | region0                          |
| service_id         | fb54a285aa3e4c848298148596011aa1 |
| service_name       | region2                          |
| service_type       | compute_v2                       |
| update_version     | 0                                |
| updated_at         | 2020-06-23T03:03:20.000000Z      |
| url                | https://10.8.3.247:30888         |
+--------------------+----------------------------------+
```

```
https://10.8.3.247:30888/stats
```

## WEB CONTROLLER


`pkg\appsrv\dispatcher\dispatcher.go`

```
AddModelDispatcher
```