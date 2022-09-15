+++
title = "K8S Monitor"
date = 2017-02-23T20:28:40+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["K8S", "MONITOR"]
categories = ["IT"]

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++

# setup prometheus

* prepare pv for prometheus

[https://wubigo.com/post/2018-01-11-kubectlcheatsheet/#pvc--using-local-pv](https://wubigo.com/post/2018-01-11-kubectlcheatsheet/#pvc--using-local-pv)

* install

```
helm install --name prometheus1  stable/prometheus --set server.persistentVolume.storageClass=local-hdd,alertmanager.enabled=false
```



