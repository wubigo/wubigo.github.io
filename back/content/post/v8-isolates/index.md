+++
title = "V8 Isolates"
date = 2020-07-29T15:28:40+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["SLS", "NODEJS"]
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


Isolate represents an isolated instance of the V8 engine. V8 isolates have completely separate states. Objects from one isolate must not be used in other isolates. When V8 is initialized a default isolate is implicitly created and entered. The embedder can create additional isolates and use them in parallel in multiple threads. An isolate can be entered by at most one thread at any given time. The Locker/Unlocker API must be used to synchronize.

https://v8docs.nodesource.com/node-0.8/d5/dda/classv8_1_1_isolate.html

