+++
title = "K8s External Services"
date = 2018-05-10T18:32:22+08:00
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


# Headless services Without POD selectors

This creates a service, but it doesn’t know where to send the traffic. This allows you to manually create an Endpoints object that will receive traffic from this service.


```
kind: Endpoints
apiVersion: v1
metadata:
 name: mongo
subsets:
 - addresses:
     - ip: 10.240.0.4
   ports:
     - port: 2701
```

# CNAME records for ExternalName

This service does a simple CNAME redirection
at the kernel level, so there is very minimal
impact on performance.

```
kind: Service
apiVersion: v1
metadata:
 name: mongo
spec:
 type: ExternalName
 externalName: ds149763.mlab.com
```