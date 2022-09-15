+++
title = "windows notes"
date = 2010-04-10T19:42:44+08:00
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

## 常用工具

- cport

https://www.nirsoft.net/utils/cports.html




## turn on IE proxy
```
@ECHO OFF
ECHO Turn on proxy! please wait...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
```
## turn off IE proxy
```
@ECHO OFF
ECHO Turn off IE Proxy! please wait...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
```



## 禁止用户修改密码

```
net users
net user /add cmp cmp
net user cmp /PasswordChg:No
WMIC USERACCOUNT WHERE Name='cmp' SET PasswordExpires=FALSE
```