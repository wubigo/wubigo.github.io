+++
title = "Docker Image Timezone"
date = 2017-12-30T15:38:16+08:00
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

```
FROM centos:7
RUN echo "ip_resolve=4" >> /etc/yum.conf
RUN yum update -y && yum install -y java-1.8.0-openjdk
# 设置时区(日志、调用链)
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone
ENV workdir /app/
ADD VERSION .

WORKDIR ${workdir}
# JAVA_OPTS环境变量JVM 启动参数，在运行时 bash 替换
# 使用 exec 以使 Java 程序可以接收 SIGTERM 信号。
CMD ["sh", "-ec", "exec java ${JAVA_OPTS} -jar ${jar}"]
```