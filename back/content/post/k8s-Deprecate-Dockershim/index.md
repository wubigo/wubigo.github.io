+++
title = "Deprecate Dockershim"
date = 2020-12-03T10:11:12+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["k8S", "DOCKER"]
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



Kubernetes is removing the "dockershim", which is special in-process support the kubelet has for docker.

However, the kubelet still has the CRI (container runtime interface) to support arbitrary runtimes. containerd is currently supported via the CRI, as is every runtime except docker. Docker is being moved from having special-case support to being the same in terms of support as other runtimes.

Does that mean using docker as your runtime is deprecated? I don't think so. You just have to use docker via a CRI layer instead of via the in-process dockershim layer. Since there hasn't been a need until now for an out-of-process cri->docker-api translation layer, there isn't a well supported one I don't think, but now that they've announced the intent to remove dockershim, I have no doubt that there will be a supported cri -> docker layer before long.

Maybe the docker project will add built-in support for exposing a CRI interface and save us an extra daemon (as containerd did).

In short, the title's misleading from my understanding. The Kubelet is removing the special-cased dockershim, but k8s distributions that ship with docker as the runtime should be able to run a cri->docker layer to retain docker support.

For more info on this, see the discussion on this pr: https://github.com/kubernetes/kubernetes/pull/94624