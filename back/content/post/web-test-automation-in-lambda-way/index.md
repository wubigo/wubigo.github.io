+++
title = "Web Test Automation in Lambda Way"
date = 2021-10-09T10:15:58+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["WEBDRIVER", "LAMBDA"]
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


# 调整默认配置（设置内存和超时时间）

函数计算的模式内存是128 MB， 超时是3秒。  默认配置

pyppeteer无法正常工作。

```
aws lambda get-function --function-name webdriver
{
    "Configuration": {
        "FunctionName": "webdriver",
        "FunctionArn": "arn:aws:lambda:ap-northeast-1:762491489154:function:webdriver",
        "Runtime": "nodejs12.x",
        "Role": "arn:aws:iam::762491489154:role/service-role/webdriver-role-3hxi35t5",
        "Handler": "index.handler",
        "CodeSize": 598,
        "Description": "",
        "Timeout": 63,
        "MemorySize": 1024,
        "LastModified": "2021-10-08T09:44:02.000+0000",
        "CodeSha256": "Ma8ntxB5UxdLSOdotZBnSGDuBUDI+XEGlggfpPlV/AI=",
        "Version": "$LATEST",
        "TracingConfig": {
            "Mode": "PassThrough"
        },
        "RevisionId": "3c08812d-e958-4427-a47e-be628966be36",
        "Layers": [
            {
                "Arn": "arn:aws:lambda:ap-northeast-1:764866452798:layer:chrome-aws-lambda:25",
                "CodeSize": 51779390
            }
        ],

```


# 使用lambda  layer

https://github.com/shelfio/chrome-aws-lambda-layer

注意要使用相应分区



