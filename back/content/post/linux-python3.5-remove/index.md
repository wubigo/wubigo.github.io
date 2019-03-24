+++
title = "Linux删除Python3.5"
date = 2019-03-24T14:04:09+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["LINUX", "PYTHON"]
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


之前一直用pycharm,今天把code升级到1.3.2的时候，
突然提示我安装python扩展，决定试试。
结果发现python的解释器设置有问题，
总是设置为系统的解释器，
而虚拟环境的解释器不起作用。 

```
apt remove --purge python3.5
reboot
```

结果ubuntu桌面启动不了。好多应用程序例如chrome，virtualbox都消失了，
造成了很大的麻烦。

Ctrl+Alt+F1进入虚拟控制台登录

```
apt install python3.5
apt install ubuntu-desktop
```

重新安装chrome和virtualbox

```
cd /etc/apt/sources.list.d
sudo mv google-chrome.list.save google-chrome.list
apt update
apt install google-chrome-stable
```