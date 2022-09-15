+++
title = "通过SDK操纵公有云"
date = 2019-03-03T20:24:49+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["K8S", "API", "SDK", "TENCENT"]
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

基于腾讯云Go SDK开发

# 下载开发工具集

```
go get -u github.com/tencentcloud/tencentcloud-sdk-go
```

# 为集群准备CVM

从本地开发集群K8S读取安全凭证secretId和secretKey配置信息，
然后把安全凭证传送给SDK客户端

```
secretId, secretKey:= K8SClient.Secrets("namespace=tencent").Get("cloud-pass")
credential := CloudCommon.NewCredential("secretId", "secretKey")
client, _ := cvm.NewClient(credential, regions.Beijing)
```  


```
request := cvm.NewAllocateHostsRequest()
request.FromJsonString(K8SClient.Configs("namespace=tencent").Get("K8S-TENCENT-PROD"))
response, err := client.AllocateHosts(request)
```

# 通过ANSIBLE在CVM搭建K8S集群

```
Ansible.Hosts().Get(response.ToJsonString())
```

调用ANSIBLE开始在CVM部署K8S集群