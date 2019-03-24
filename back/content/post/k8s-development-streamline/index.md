+++
title = "K8s Development Streamline with draft"
date = 2018-02-24T07:30:53+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["K8S", "APP"]
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

# 准备

- 初始化

```shell
draft init

...
Installing default plugins...
Preparing to install into /home/bigo/.draft/plugins/draft-pack-repo
draft-pack-repo installed into /home/bigo/.draft/plugins/draft-pack-repo/draft-pack-repo
Installed plugin: pack-repo
Installation of default plugins complete
Installing default pack repositories...
Installing pack repo from https://github.com/Azure/draft
Installed pack repository github.com/Azure/draft
Installation of default pack repositories complete
$DRAFT_HOME has been configured at /home/bigo/.draft.
...
```

- 设置docker镜像寄存器

```
draft config set registry registry.cn-beijing.aliyuncs.com/k4s
```

or

>skip the push process entirely using the --skip-image-push flag 


# 应用设置

```
cd code/go/
ls
app.go
draft create
ls
app.go charts  Dockerfile  draft.toml 

```

# 发布应用

```
draft up

Draft Up Started: 'go-web': 01D6QETAPPM7ZYAM7G733ZVMY7
go-web: Building Docker Image: SUCCESS ⚓  (0.9999s)
go-web: Pushing Docker Image: SUCCESS ⚓  (139.6931s)
go-web: Releasing Application: SUCCESS ⚓  (4.3545s)
Inspect the logs with `draft logs 01D6QETAPPM7ZYAM7G733ZVMY7`
```

# 检查

- 检查日志
```
draft logs 01D6QETAPPM7ZYAM7G733ZVMY7
```

- 检查软件列表

```
helm ls | grep go-web

...
NAME         REVISION	UPDATED          	STATUS  	CHART                	APP VERSION	NAMESPACE
go-web       Sun Mar 24 17:01:54 2018	  DEPLOYED	go-web-v0.1.0	           	        default 
...
```

- 检查PODS

```
kubectl get pods | grep go-web

NAME                     READY   STATUS    RESTARTS   AGE
go-web-f94bd78d5-qcmq9   1/1     Running   0          5m38s
```

# 访问应用

```
draft connect

...
Connect to go-web:8080 on **localhost:34261**
[go-web]:  * Environment: production
[go-web]:  * Debug mode: off
[go-web]:  * Running on http://0.0.0.0:8080/ (Press CTRL+C to quit)
...
```

```
curl localhost:34261

```

# 应用迭代

- 修改go-web/web.go

- 发布
- 
```
draft up
```

- 测试

```
draft connect
```

# 删除应用

```
draft delete
helm ls |grep go-web
```
