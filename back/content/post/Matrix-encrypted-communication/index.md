+++
title = "Matrix Encrypted Communication"
date = 2021-08-18T17:46:17+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = []
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



 The matrix specification does not enforce how users register with a server. It just specifies the URL path and absolute minimum keys. The reference homeserver uses a username/password to authenticate user, but other homeservers may use different methods. This is why you need to specify the type of method