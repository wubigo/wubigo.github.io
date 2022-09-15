+++
title = "Linux Chrome"
date = 2018-03-31T06:20:37+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["WEB", "LINUX"]
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


# 禁止启动时候恢复页面提示

**Version 73.0.3683.86 (Official Build) (64-bit)**

- 方法1（可靠）

  首先关闭chrome，然后修改下面的设置，修改完后重启
  
  `.config/google-chrome/Default/Preferences`

```
sed  -i '/exit_type:Crashed/exit_type:Normal/`
```  

windows用户请参考下面的视频

[Chrome Didn't Shut Down Correctly Error Solved Windows 7](https://www.youtube.com/watch?v=d75rLCGldOc)


- 方法2（不可靠）

Type in address bar (Crtl+L).

```
chrome://flags/#infinite-session-restore 
```

Click on the right drop-down menu and change the 'Default' value to 'Disable'. Then restart Chrome to apply that setting


# enter password to unlock your keyring

- 方法1（可靠）

- set password-store to basic

```
dpkg -L google-chrome-stable |grep desktop | xargs cp {1} ~/.local/share/applications
```

修改`.local/share/applications/google-chrome.desktop`

```
Exec=/usr/bin/google-chrome-stable --password-store=basic %U
```

- 方法2（不可靠）

- seahorse

```
seahorse
```
选择login，右键删除


# How to allow unsafe ports in Chrome

[http://douglastarr.com/how-to-allow-unsafe-ports-in-chrome](http://douglastarr.com/how-to-allow-unsafe-ports-in-chrome)

