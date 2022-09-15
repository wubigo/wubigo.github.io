+++
title = "Nginx Root vs Alias"
date = 2020-08-20T15:25:18+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["WEB"]
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



There is a very important difference between the root and the alias directives. This difference exists in the way the path specified in the root or the alias is processed.

In case of the root directive, full path is appended to the root including the location part, whereas in case of the alias directive, only the portion of the path NOT including the location part is appended to the alias.


```
location /beta {
  root /var/www/html
  
}

location /beta {
  alias /var/www/html/beta
}
```


https://stackoverflow.com/questions/10631933/nginx-static-file-serving-confusion-with-root-alias
