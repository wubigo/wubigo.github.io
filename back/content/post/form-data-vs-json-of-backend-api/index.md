+++
title = "Form Data vs Json of Backend Api"
date = 2021-06-07T11:05:22+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["HTTP"]
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


# 通过浏览器提交表单

# 通过curl提交表单


# spring-boot

map HTTP request header Content-Type, handle request body.

```
@RequestParam ← application/x-www-form-urlencoded,

@RequestBody ← application/json,

@RequestPart ← multipart/form-data,
```



[form-data](https://www.baeldung.com/spring-url-encoded-form-data)