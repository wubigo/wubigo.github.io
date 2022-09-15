+++
title = "Aws Lambda Notes"
date = 2018-10-24T09:46:24+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["SERVERLESS","LOCALSTACK", "LAMBDA"]
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


## 事件

事件源发送的事件是JSON格式，LAMBDA运行时把原始JSON事件转换为

对象并发送给函数代码。 

事件的结构和内容由事件源决定

支持事件源的服务

- Kinesis 
- DynamoDB
- Simple Queue Service

## 权限

通过权限策略(permissions policy)来管理IAM用户，组或者角色对lambda

API和资源(函数或函数层）访问权限。

权限策略也可以授权给资源本身，让资源或服务访问lambda。

每一个lamdba函数都有一个执行角色(execution role), 该角色授权lamdba函数

本身对其他资源和服务的访问。执行角色至少包含对CLOUDWATCH日志的访问权限。

lambda也通过执行角色请求对事件源的读取权限。


## 资源


- 函数
- 版本
- 别名
- 层级


举例：授权SNS 调用 my-function

```
aws lambda add-permission --function-name my-function --action lambda:InvokeFunction --statement-id sns \
> --principal sns.amazonaws.com --output text


{"Sid":"sns","Effect":"Allow","Principal":{"Service":"sns.amazonaws.com"},"Action":"lambda:InvokeFunction","Resource":"arn:aws:lambda:ap-northeast-1:465691908928:function:my-function"}

```

## serveless backend

Lambda allows  to trigger execution of code

in response to events in AWS, enabling

serverless backend solutions.

The Lambda Function itself includes source code

and runtime configuration.

