+++
title = "购买笔记本电脑的正确打开姿势"
date = 2016-04-04T07:23:27+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["WINDOWS", "OS"]
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

## 关闭网络连接


## 个性化设置

- 性能模式

- 任务栏

- 通知

- 文件夹

## 关闭激活服务

---

### 禁用激活服务

https://www.wikihow.com/Turn-Off-Windows-Activation

### 关闭自动激活

https://www.intowindows.com/how-to-turn-off-automatic-activation-in-windows-10/

## 注意

个性化设置必须在关闭激活服务之前完成

![](/img/post/win-activation.png)

## 禁止用户修改密码

```
net users
net user user_cmp /PasswordChg:No
```

## 关闭后台服务

turn off the background app functionality

```
Start > Settings > Privacy > Background apps
```