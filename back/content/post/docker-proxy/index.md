+++
title = "Docker Proxy for daemon and client"
date = 2019-09-13T07:07:56+08:00
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

# DOCKER DEAMON PROXY

- systemd level

`/etc/systemd/system/docker.service.d/https-proxy.conf`

```
[Service]
Environment="http_proxy=http://127.0.0.1:8123" "https_proxy=https://127.0.0.1:8123" "NO_PROXY=registry-1.docker.io"
```


```
sudo systemctl daemon-reload
sudo systemctl restart docker
```

- service level

`/etc/default/docker`

```
export http_proxy="http://127.0.0.1:3128/"
```

- daemon level

`/etc/docker/daemon`


# DOCKER CLIENT PROXY

`~/.docker/config.json`

```
       "proxies":{
                "default":{}
        }

```