+++
title = "Matrix Homeserver"
date = 2019-08-18T10:07:00+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["IM", "MATRIX"]
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

# 注册用户

`/etc/matrix-synapse/homeserver.yaml`

```
registration_shared_secret:  
```

```
sudo systemctl restart matrix-synapse
```

## 配置代理

```
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
```


```
server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;

    # For the federation port
    listen 8448 ssl http2 default_server;
    listen [::]:8448 ssl http2 default_server;

    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;

    location ~* ^(\/_matrix|\/_synapse\/client) {
        proxy_pass http://localhost:8008;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $host;

        # Nginx by default only allows file uploads up to 1M in size
        # Increase client_max_body_size to match max_upload_size defined in homeserver.yaml
        client_max_body_size 50M;
    }
}
```



# 创建用户


## 工具

```
register_new_matrix_user -c /etc/matrix-synapse/homeserver.yaml http://localhost:8008
```


## API


### nonce


```
curl http://192.168.10.103:8008/_synapse/admin/v1/register

{"nonce":"c6091d1c6fc96580b0fc25820e908ef4613fbec15233063e2aadc1d3a81c8a9170805f5d9f2fa63016dd7138bc8ad409a4da46bf75a2e429c541d0828abf0612"}
```


### MAC

```
import hashlib
import hmac


def generate_mac(nonce, user, password, admin=False, user_type=None):

    mac = hmac.new(
      key=b'registration_shared_secret',
      digestmod=hashlib.sha1,
    )

    mac.update(nonce.encode('utf8'))
    mac.update(b"\x00")
    mac.update(user.encode('utf8'))
    mac.update(b"\x00")
    mac.update(password.encode('utf8'))
    mac.update(b"\x00")
    mac.update(b"admin" if admin else b"notadmin")
    if user_type:
        mac.update(b"\x00")
        mac.update(user_type.encode('utf8'))

    return mac.hexdigest()


nonce = "6052ab555c5925adfb2441dffa7761c375d3b1c7dd83032eb2ae6ff4d1a3424ebab1fe6f0ccdae3eba2f655caff9de74e706019adee57da2f3b4b3199432dd5d"
shared_secret = "registration_shared_secret"

mac=generate_mac(nonce, "wuhg", "wuhg", True)
print(mac)
```

###  


```
POST /_synapse/admin/v1/register
  
  {
   "nonce": "thisisanonce",
   "username": "bigo",
   "displayname": "bigo",
   "password": "pizz",
   "admin": true,
   "mac": "mac_digest_here"
  }
```

# 收发消息

## 托管的WEB

https://app.element.io/#/login

homeserver：https://192.168.10.10


## 安装

```
wget https://github.com/vector-im/element-web/releases/download/v1.8.1/element-v1.8.1.tar.gz
tar element-v1.8.1.tar.gz
cp element-v1.8.1 /var/www/html/element
cd /var/www/html/element
cp config.sample.json config.json
```

https://192.168.10.10/element



