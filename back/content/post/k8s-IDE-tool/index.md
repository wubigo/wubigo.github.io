+++
title = "K8s IDE Tool: code extension"
date = 2018-03-24T07:02:36+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["K8S", "IDE", "APP"]
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

for developers building applications to run in Kubernetes clusters, and for DevOps staff troubleshooting Kubernetes applications. Features include:

- View your clusters in an explorer tree view, and drill into workloads, services, pods and nodes.
- Browse Helm repos and install charts into your Kubernetes cluster.
- Intellisense for Kubernetes resources and Helm charts and templates.
- Edit Kubernetes resource manifests and apply them to your cluster.
- Build and run containers in your cluster from Dockerfiles in your project.
- View diffs of a resource's current state against the resource manifest in your Git repo
- Easily check out the Git commit corresponding to a deployed application.
- Run commands or start a shell within your application's pods.
- Get or follow logs and events from your clusters.
- Forward local ports to your application's pods.
- Create Helm charts using scaffolding and snippets.
- Bootstrap applications using Draft, and rapidly deploy and debug them to speed up the development loop.

# Dependencies

**docker if you plan to use the extension to build applications rather than only browse.**

- kubectl
- docker
- helm
- draft

