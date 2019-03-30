+++
title = "K8s Logging"
date = 2019-03-17T10:25:07+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["K8S"]
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


# Node-level Logging

- System component logs

|| RUN IN CONTAINER(Y/N)| Systemd(W/WO) | LOGGER LOCATION
:---|:---|:---|:---
kubelet and container runtime | |   W/O|  /var/log
kubelet and container runtime | |   W | journald
scheduler | Y|   |  /var/log
kube-proxy | Y|    | /var/log



`/var/lib/kubelet/pods/<PodUID>/`

`/var/log/pods/<PodUID>/<container_name>`

```
ls -l /var/log/pods/<PodUID>/<container_name>/
lrwxrwxrwx 1 root root 165 3月  30 06:52 0.log -> /var/lib/docker/containers/e74eafc4b3f0cfe2e4e0462c93101244414eb3048732f409c29cc54527b4a021/e74eafc4b3f0cfe2e4e0462c93101244414eb3048732f409c29cc54527b4a021-json.log
```


# Cluster-level logging

- Use a node-level logging agent that runs on every node.
- Include a dedicated sidecar container for logging in an application pod.
- Push logs directly to a backend from within an application

具体实现

- [EFK](/post/k8s-logging-efk/)


