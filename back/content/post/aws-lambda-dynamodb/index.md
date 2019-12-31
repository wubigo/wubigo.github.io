+++
title = "Lambda订阅SNS通知(下)"
date = 2018-12-31T14:44:32+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["AWS", "LAMBDA", "SNS", "SLS", "SERVERLESS", "NOSQL"]
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

## 创建函数


- 分配角色


```
zip function.zip index.js

aws lambda create-function --function-name sns-db-function \
--zip-file fileb://function.zip --handler index.handler --runtime nodejs12.x \
--role arn:aws:iam::465691908928:role/fn-case-role
```

