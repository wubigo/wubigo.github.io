+++
title = "面部生物识别学习笔记"
date = 2021-01-23T19:58:46+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["AI", "CV"]
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


Once the face is detected, the AI then provides the information on

its size, pose, and location


The state-of-the-art face detection software uses pattern detection technology. 

No personal data is collected, and no images are stored.

# 人脸检测基本方法

![](/img/post/face-detection-methods.jpg)


#Import Libraries
#Import Classifier for Face and Eye Detection
#Convert Image to Grayscale
#Give coordinates to detect face and eyes location from ROI
#Webcam setup for Face Detection
#When everything is done, release the capture