+++
title = "Ubuntu Vpn Client"
date = 2016-05-23T08:31:58+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["VPN"]
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


##  安装客户端 

```
sudo apt-get install m2crypto
pip install shadowsocks
```

`/etc/shadowsocks.json`

```
{
"server":"4.1.33.104",
"server_port":8388,
"local_address": "127.0.0.1",
"local_port":1080,
"password":"",
"timeout":600,
"method":"aes-256-cfb"
}
```


```
sslocal -c /etc/shadowsocks.json
# To run in the background
sudo sslocal -c /etc/shadowsocks.json -d start
```

## 配置代理

```
sudo apt-get install polipo
```

`/etc/polipo/config`

```
logSyslog = true
logFile = /var/log/polipo/polipo.log

logSyslog = true
logFile = /var/log/polipo/polipo.log
proxyAddress = "0.0.0.0"
socksParentProxy = "127.0.0.1:1080"
socksProxyType = socks5
chunkHighMark = 50331648
objectHighMark = 16384
serverMaxSlots = 64
serverSlots = 16
serverSlots1 = 32

```


```
sudo service polipo stop
sudo service polipo start

export http_proxy=http://127.0.0.1:8123
export https_proxy=https://127.0.0.1:8123
git config --global http.proxy socks5://localhost:1080
git config --global https.proxy socks5://localhost:1080

git config --global http.https://github.com.proxy socks5://127.0.0.1:1080
git config --global https.https://github.com.proxy socks5://127.0.0.1:1080
git config --global --unset http.proxy
git config --global --unset https.proxy
```

`/etc/apt/apt.conf`

```
Acquire::http::Proxy "http://127.0.0.1:8123";
Acquire::https::Proxy "https://127.0.0.1:8123";
```

[config docker daemon](/post/docker-proxy/)

## 测试

```
curl www.google.com
git clone golang.org/x/lint/golint
docker pull k8s.gcr.io/kube-apiserver:v1.15.10
apt update
```