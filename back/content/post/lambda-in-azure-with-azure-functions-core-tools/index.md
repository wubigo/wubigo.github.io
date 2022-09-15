+++
title = "Lambda in Azure With Azure Functions Core Tools"
date = 2021-11-06T23:07:10+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["LAMBDA"]
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

# 安装FUNC

```
npm i -D azure-functions-core-tools@3

export PATH=./

export CLI_DEBUG=1

func host start --verbose

```

# 安装playwright-chromium

```
export PLAYWRIGHT_BROWSERS_PATH=0
npm install playwright-chromium@1.3.0
```

确认chrome的存放路径

`node_modules/playwright-chromium/.local-browsers/chromium-792639`

# 创建函数

```
/home/ubuntu/sls/azure-sls/node_modules/.bin/func  init
func new
func start
```

# 本地测试

```
export CLI_DEBUG=1
func host start --verbose
```

`host.json`


```
{
  "version": "2.0",
  "logging": {
    "applicationInsights": {
      "samplingSettings": {
        "isEnabled": true,
        "excludedTypes": "Request"
      }
    }
  },
  "extensionBundle": {
    "id": "Microsoft.Azure.Functions.ExtensionBundle",
    "version": "[2.*, 3.0.0)"
  }
}
```

如果遇到如下问题

> Value cannot be null. (Parameter 'provider')

注释/禁用 extensionBundle

# 发布

```
func azure functionapp publish my_function_app_name  --build remote
```

# 总结

部署节点和运行环境在同一可用区加快部署速度