+++
title = "Docker日志"
date = 2017-02-17T08:24:25+08:00
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

>Everything a containerized application writes to stdout and stderr is handled and redirected somewhere by a container engine. For example, the Docker container engine redirects those two streams to a logging driver

**The `docker logs` command is not available for drivers other than json-file and journald.**


# docker-compose日志

```
docker-compose -f docker-compose-0.7.1.yml logs -f
```


# logging driver

To configure the Docker daemon to default to a specific logging driver, set the value of log-driver to the name of the logging driver in the daemon.json file

The default logging driver is json-file. Thus, the default output for commands such as docker inspect <CONTAINER> is JSON

```
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3",
    "labels": "bigo.logg",
    "env": "os"
  }
}
```

- check the current driver

```
docker info --format '{{.LoggingDriver}}'
```

# json-file

the default location

`/var/lib/docker/containers/<INSTANCE_ID>/<INSTANCE_ID>-json.log`

or  check log location via

```
docker inspect --format='{{.LogPath}}' $INSTANCE_ID
```

# Supported logging drivers

Driver |	Description
:---|:---
none |	No logs are available for the container and docker logs does not return any output.
json-file| 	The logs are formatted as JSON. The default logging driver for Docker.
local| 	Writes logs messages to local filesystem in binary files using Protobuf.
syslog| 	Writes logging messages to the syslog facility. The syslog daemon must be running on the host machine.
journald| 	Writes log messages to journald. The journald daemon must be running on the host machine.
gelf |	Writes log messages to a Graylog Extended Log Format (GELF) endpoint such as Graylog or Logstash.
fluentd| 	Writes log messages to fluentd (forward input). The fluentd daemon must be running on the host machine.
awslogs |	Writes log messages to Amazon CloudWatch Logs.


# 覆盖ENTRYPOINT

- 方法1
  
  ```
  docker run -it --rm --entrypoint /bin/sh curl:v1
  ```

- 方法2
  通过Dockerfile从镜像再建一个镜像，并重定义ENTRYPOINT


## view real time logging of Docker containers

```
docker logs -f 
```