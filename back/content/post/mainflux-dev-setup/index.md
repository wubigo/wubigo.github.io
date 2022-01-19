+++
title = "Mainflux Dev Setup"
date = 2021-12-20T17:04:37+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["IIOT", "IOT"]
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


# BUILD

```
mkdir -p $GOPATH/src/github.com/mailflux
git clone https://github.com/wubigo/mainflux.git
cd github.com/mailflux/mailflux/
make
make dockers_dev
make run
```

# Provision the System

```
mainflux-cli provision test
```

# GET TOKEN

```
curl -k https://172.21.53.253/tokens

{
  "email": "bold_gould@email.com",
  "password": "12345678"
}

```
