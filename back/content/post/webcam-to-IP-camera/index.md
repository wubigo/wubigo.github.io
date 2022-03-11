+++
title = "Webcam to IP Camera"
date = 2021-03-11T09:34:40+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["RTSP", "ONVIF"]
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


# 摄像头的区别 USB  vs  RTSP  vs  ONVIF

If we use USB cameras we do not need the camera url and some functions like moving, zooming etc. will not be available. In the case of RTSP cameras and ONVIF cameras there are more functions available. The difference between the RTSP camera and the ONVIF camera is the following: the RTSP camera has only one stream in comparsion with the ONVIF camera having multiple streams at a time


# 安装cam2ip

https://github.com/gen2brain/cam2ip


下载OPENCV版
https://github.com/gen2brain/cam2ip/releases/download/1.6/cam2ip-1.6-64bit-cv2.zip

运行

```
cmd:\>cam2ip-1.6-64bit-cv\cam2ip
Listening on :56000
```

# 使用anycam管理IP摄像头

通过RTSP方式管理webcam，

输入：localhost:56000      
连接方式：RTSP

