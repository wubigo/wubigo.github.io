+++
title = "K8S CORE DEVELOPMENT"
date = 2019-03-04T11:13:20+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["K8S"]
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


```
git clone git@github.com:wubigo/kubernetes.git
git remote add upstream https://github.com/kubernetes/kubernetes.git
git fetch --all
git checkout tags/v1.13.3 -b v1.13.3 
git branch -av|grep 1.13
* fix-1.13                            4807084f79 Add/Update CHANGELOG-1.13.md for v1.13.2.
  remotes/origin/release-1.13         4807084f79 Add/Update CHANGELOG-1.13.md for v1.13.2.

```


# 管理POD

```
func (kl *Kubelet) syncPod(o syncPodOptions) error {
```