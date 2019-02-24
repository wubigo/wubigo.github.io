+++
title = "K8S CNI"
date = 2017-02-24T16:18:43+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["K8S", "CNI", "NETWORK"]
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

 CNI as the Kubernetes plugin model, There will be some unfortunate side-effects
 
 Most of them are relatively minor (for example, docker inspect will not show an IP address), but some are significant. In particular, containers started by docker run might not be able to communicate with containers started by Kubernetes, and network integrators will have to provide CNI drivers if they want to fully integrate with Kubernetes


 CNI was created as a minimal specification, built alongside a number of network vendor engineers to be a simple contract between the container runtime and network plugins. A JSON schema defines the expected input and output from CNI network plugins.

Multiple plugins may be run at one time with a container joining networks driven by different plugins. Networks are described in configuration files, in JSON format, and instantiated as new namespaces when CNI plugins are invoked. CNI plugins support two commands to add and remove container network interfaces to and from networks. Add gets invoked by the container runtime when it creates a container. Delete gets invoked by the container runtime when it tears down a container instance


- CNI Flow

The container runtime needs to first allocate a network namespace to the container and assign it a container ID, then pass along a number of parameters (CNI config) to the network driver. The network driver then attaches the container to a network and reports the assigned IP address back to the container runtime via JSON.

Currently, CNI primitives handle concerns with IPAM, L2 and L3, and expect the container runtime to handle port-mapping (L4)


- Service

A service functions as a proxy to replicated pods and service requests can be load balanced across pods.