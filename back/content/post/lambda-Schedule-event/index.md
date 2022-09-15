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

## 函数调用网关接口类型

- HTTP API：A lightweight, low-latency RESTful API(Gateway version 2 API)
- REST API：A customizable, feature-rich RESTful API
- WebSocket API 

### HTTP API features

Automatic deployments – When you modify routes or integrations, changes deploy automatically to stages that have automatic deployment enabled.

Default stage – You can create a default stage ($default) to serve requests at the root path of your API's URL. For named stages, you must include the stage name at the beginning of the path.

CORS configuration – You can configure your API to add CORS headers to outgoing responses, instead of adding them manually in your function code.

REST APIs are the classic RESTful APIs that API Gateway has supported since launch. REST APIs currently have more customization, integration, and management features.

### REST API features

Integration types – REST APIs support custom Lambda integrations. With a custom integration, you can send just the body of the request to the function, or apply a transform template to the request body before sending it to the function.

Access control – REST APIs support more options for authentication and authorization.

Monitoring and tracing – REST APIs support AWS X-Ray tracing and additional logging options.