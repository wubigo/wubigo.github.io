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


Dockerfile ENTRYPOINT有两种形式

- exec
- shell


||exec(preferred)| shell
:---|:---|:---
ENTRYPOINT| ["executable", "param1", "param2"] | command param1 param2
Command line arguments to docker run <image>|  appended | not being used
|||ENTRYPOINT will be started as a subcommand of /bin/sh -c
default | N/A |  /bin/sh -c (start it with exec to sned stop signal)
CMD [“exec_cmd”, “p1_cmd”] | exec_entry p1_entry exec_cmd p1_cmd | /bin/sh -c exec_entry p1_entry


# ENTRYPOINT exec
  
```
FROM alpine:3.8
ENTRYPOINT ["top", "-b"]
```
因为没有sh进程，所以命令行没有环境变量替换。

可以增加sh

```
FROM alpine:3.8
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["exec top -b -u $UID"]
```



# ENTRYPOINT shell

CMD无效

```
FROM alpine:3.8
ENTRYPOINT exec top -b
```

ENTRYPOINT作为sh的子命令执行即

实际执行`/bin/sh -c "exec top -b"`

验证

```
docker build -t cmd .
docker run -it --rm cmd cmd1 cmd2 cmd3


Mem: 4750556K used, 4318692K free, 555320K shrd, 176952K buff, 1907592K cached
CPU:   0% usr   0% sys   0% nic  99% idle   0% io   0% irq   0% sirq
Load average: 0.40 0.28 0.22 4/973 5
  PID  PPID USER     STAT   VSZ %VSZ CPU %CPU COMMAND
    1     0 root     R     1524   0%   1   0% top -b
```



```
ENTRYPOINT ["sh", "-c"]
CMD ["exec java -jar $APP_FILE"]
```

类似执行如下指令

```
/bin/sh -c "exec java -jar $APP_FILE"
```


