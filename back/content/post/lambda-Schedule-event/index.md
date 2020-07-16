+++
title = "Lambda之任务定时调度"
date = 2020-07-15T19:23:47+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["SLS"]
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


函数计算有很多使用场景，今天介绍定时任务调度

例如每周六生成业务报表

## 事件类别

- 资源生命周期事件
- HTTP请求
- 消息队列
- 调度

## 调度事件

define event rules that self-trigger regularly and configure a target action to do some regular work. So you can define an Amazon Lambda function or AWS Step Functions state machine as scheduled targets. Hence, when this event is triggered at the specified time or interval you defined, your function or state machine is executed. These types of events are called scheduled Amazon CloudWatch Events

## 定义调度

- cron 表达式
- rate 表达式