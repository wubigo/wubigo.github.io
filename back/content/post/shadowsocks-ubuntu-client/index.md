+++
title = "Shadowsocks Ubuntu Client"
date = 2018-04-28T17:08:07+08:00
tags = ["SHELL", "VPN"]
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.

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




# install client

```
pip install shadowsocks
```

`client.json`

```
{
"server":"server-ip",
"server_port":8000,
"local_port":3050,
"password":"your-password",
"timeout":600,
"method":"aes-256-cfb"
}                   
```

```
{
    "server":"your_server_ip",      #ss服务器IP
    "server_port":your_server_port, #端口
    "local_address": "127.0.0.1",   #本地ip
    "local_port":1080,              #本地端口
    "password":"your_server_passwd",#连接ss密码
    "timeout":300,                  #等待超时
    "method":"rc4-md5",             #加密方式
    "fast_open": false,             # true 或 false。如果你的服务器 Linux 内核在3.7+，可以开启 fast_open 以降低延迟。开启方法： echo 3 > /proc/sys/net/ipv4/tcp_fastopen 开启之后，将 fast_open 的配置设置为 true 即可
    "workers": 1                    # 工作线程数
}

```


```
sudo apt-get install privoxy
```

`/etc/privoxy/config`


```
listen-address  127.0.0.1:8118

forward-socks5   /               127.0.0.1:1080 .
```

```
systemctl restart privoxy.service
```


```
curl -x 127.0.0.1:1080  www.google.com
```