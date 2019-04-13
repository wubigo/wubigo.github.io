+++
title = "Docker Dockerfile ENTRYPOINT"
date = 2016-04-13T09:23:00+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["DOCKER"]
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

# 两种形式


||exec(preferred)| shell
:---|:---|:---
ENTRYPOINT| ["executable", "param1", "param2"] | command param1 param2
Command line arguments to docker run <image>|  appended | not being used
|||ENTRYPOINT will be started as a subcommand of /bin/sh -c
default | N/A |  /bin/sh -c (start it with exec to sned stop signal)
CMD [“exec_cmd”, “p1_cmd”] | exec_entry p1_entry exec_cmd p1_cmd | /bin/sh -c exec_entry p1_entry


- exec
  
```
FROM alpine:3.8
ENTRYPOINT ["top", "-b"]
```
因为没有sh进程，所以命令行没有环境变量替换。

可以增加sh

```
ENTRYPOINT ["/bin/sh", "-c", "top", "-b", "-u", "$UID"]
```



- shell

CMD无效

```
FROM alpine:3.8
ENTRYPOINT exec top -b
```

ENTRYPOINT作为sh的子命令执行即

实际执行`/bin/sh -c exec top -b`