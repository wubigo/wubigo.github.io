+++
title = "Windows Application Information Service"
date = 2019-05-06T11:51:54+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["WINDOWS"]
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



AppInfo	启动类型必须是自动或手动，

否则，msinstaller， services.msc， regedit

等都会报错：

```
The Service command cannot be started,
either because it is disabled or because
it has no enabled devices associated with it
```

```
AppInfo	

svchost.exe	

Facilitates the running of interactive applications
 with additional administrative privileges.	

Users will be unable to launch applications with the
 additional administrative privileges they may require
 to perform desired user tasks.  These tools include regedit.

Although safe to disable, this is not recommended since
 you need to boot into safe mode to enable again.
```