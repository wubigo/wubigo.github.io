+++
title = "Istio Notes"
date = 2017-03-04T16:38:38+08:00
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

git clone https://github.com/istio/istio.git
cd istio
git checkout 1.0.6 -b 1.0.6
helm install install/kubernetes/helm/istio --name istio --namespace istio-system