+++
title = "UAA Shiro Notes"
date = 2016-03-19T16:28:19+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["UAA", "SHIRO"]
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


## RequiresUser annotation

>Requires the current Subject to be an application user for the annotated class/instance/method to be 
>accessed or invoked. This is less restrictive than the RequiresAuthentication annotation.


Shiro defines a "user" as a Subject that is either "remembered" or authenticated:

- An authenticated user is a Subject that has successfully logged in (proven their identity) during their current session.
- A remembered user is any Subject that has proven their identity at least once, although not necessarily during their current session, and asked the system to remember them.

Note however that when a new session is created for the corresponding user, that user's identity would be remembered, but they are NOT considered authenticated

