+++
title = "Lambda in Azure with sls"
date = 2021-11-06T11:59:57+08:00
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


# 创建函数

```
npm install -g serverless@2.65.0
sls -v

Framework Core: 2.65.0
Plugin: 5.5.1
SDK: 4.3.0
Components: 3.17.2

sls create -t azure-nodejs -p azure-fn
cd azure-fn
npm install

```

```
npm list |grep serverless-azure-functions
└─┬ serverless-azure-functions@2.1.3
```

# 部署函数


```
set AZURE_SUBSCRIPTION_ID=02a23ad5-
set AZURE_TENANT_ID=e9950462
set AZURE_CLIENT_ID=39258bc8
set AZURE_CLIENT_SECRET=hYdvD0
sls deploy --dryrun
```


# 测试

```
sls invoke -f hello -d '{"name": "Azure"}'
```

# 清理


`empty.json`

```
{
"$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
"contentVersion": "1.0.0.0",
"parameters": { },
"variables": { },
"resources": [ ],
"outputs": { }
}
```


```

az group deployment create --mode complete --template-file ./empty.json --resource-group testgroup
az group delete -n testgroup -y
```