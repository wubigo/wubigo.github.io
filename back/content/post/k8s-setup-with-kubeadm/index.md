+++
title = "Setup K8s With Kubeadm"
date = 2020-10-29T16:38:33+08:00
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


```
kubeadm config images pull --image-repository registry.aliyuncs.com/google_containers
sudo kubeadm init --image-repository registry.aliyuncs.com/google_containers

kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml




kubeadm join 10.8.3.222:6443 --token awon9z.by860tstxwytcw8z \
    --discovery-token-ca-cert-hash sha256:7b90bca7225915f07179fd2ad31820533c847ad032c5e77c6121eea6ae679ebd
```