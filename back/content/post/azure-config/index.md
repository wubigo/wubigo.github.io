+++
title = "Azure Config"
date = 2021-11-07T20:00:24+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["IAAS"]
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

# 配置

'.azure/config`

```
[defaults]
location = westus

[cloud]
name = AzureCloud

[core]
output = table
```

```
az config set defaults.location=westus2 defaults.group=MyResourceGroup
```

az v2不支持config，直接修改配置文件