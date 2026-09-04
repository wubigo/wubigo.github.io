+++
title = "LLM代理访问入门方案"
date = 2026-09-04T11:15:34+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["vpn"]
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

本文介绍通过代理的方式，即使身在目标服务区域之外，提供访问LLM的入门方案。

# 在LLM服务区申请vps搭建代理服务器

在美西申请一台龟壳云服务器(Ubuntu 24.04.4 LTS)

## 安装代理服务

```
$sudo apt update && sudo apt upgrade -y
$bash <(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh) install
$xray --version
Xray 26.3.27 (Xray, Penetrates Everything.) d2758a0 (go1.26.1 linux/amd64)
```

## 配置

```
$xray uuid
f1a2b3c4-5d6e-7f8a-9b0c-1d2e3f4a5b6c
$xray x25519
Private key: yLTMMfcsJJ3Fh4t_Pjf777iDhCYx0-PSmksmKBrpRAI
Public key: IGoeCjQm24_wA9M0N3WMVV3ze8NKXb_Yv7CEU_HKMwQ
$openssl rand -hex 8
0123456789abcdef
```

`/usr/local/etc/xray/config.json`

```
{
  "log": {
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "port": 443,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "你的UUID", 
            "flow": "xtls-rprx-vision"
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "tcp",
        "security": "reality",
        "realitySettings": {
          "show": false,
          "dest": "www.microsoft.com:443", // 伪装的目标网站
          "xver": 0,
          "serverNames": [
            "www.microsoft.com",
            "www.apple.com"
          ],
          "privateKey": "你的PrivateKey", 
          "shortIds": [
            "0123456789abcdef" // ← 替换为生成的Short ID
          ]
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "tag": "direct"
    }
  ]
}
```

## 重启服务

```
sudo systemctl restart xray
```

## 安全组允许TCP/UDP:443外部访问(Inbound)


# 配置访问客户端

## 验证代理服务443端口可以访问

```warp
Test-NetConnection 54.168.29.16 -Port 443
```

## 安装v2rayN-windows-64-desktop

V7.24.9


## 创建/增加VLESS订阅

```
Configuration: Xray
Alias (remarks)：oracle
Address：代理服务器IP
Port: 443
UUID(id):[与服务器配置一致]
Flow：xtls-rprx-vision
Encryption：none
Transport protocol(network)：raw
raw camouflage type：none
TLS：reality
SNI：www.microsfot.com
Public Key: rmC 4kfCTYfp2vV-TlgOs17mdWxcvAWnr6Asu2g
Short ld: 38a7c6258acb127a
```

## 切换代理模式并做检查

- 关掉TUN，只开"PAC mode"

检查是否可以访问[GPT](http://chatgpt.com)

- 打开TUN

检查是否可以访问[GPT](http://chatgpt.com)






