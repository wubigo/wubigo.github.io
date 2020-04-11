+++
title = "Windows Update Corruption"
date = 2020-04-10T19:42:44+08:00
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


4月8号的更新，出现了如下问题

https://answers.microsoft.com/en-us/windows/forum/all/input-indicator-doesnt-work-well-and-icon-missing


通过卸载更新把更新删除后，系统恢复正常

## 删除本地下载的更新文件

https://winaero.com/blog/delete-downloaded-windows-update-files-in-windows-10/

`C:\Windows\SoftwareDistribution\Download`

