+++
title = "Matrix Web Client Dev Setup"
date = 2021-08-19T14:53:17+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["IM"]
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


# 准备环境 

```
node -v
v14.17.5
npm install -g yarn@1.22.11
```

# 链接SDK

```
git clone https://github.com/matrix-org/matrix-js-sdk.git
pushd matrix-js-sdk
yarn link
yarn install
popd


git clone https://github.com/matrix-org/matrix-react-sdk.git
pushd matrix-react-sdk
yarn link
yarn link matrix-js-sdk
yarn install
popd



git clone https://github.com/vector-im/element-web.git
cd element-web
yarn link matrix-js-sdk
yarn link matrix-react-sdk
yarn install
yarn reskindex
yarn start

```


# 启动

```
cp config.sample.json config.json

curl http://127.0.0.1:8080/
```


# 登录

homeserver：http://192.168.43.16:8008/
