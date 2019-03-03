+++
title = "Dev on Tencent Cloud SDK in Go"
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

# 示例代码

从K8S读取安全凭证secretId和secretKey配置信息，
然后把安全凭证传送给SDK客户端

```go
import (
	"fmt"
	"github.com/tencentcloud/tencentcloud-sdk-go/tencentcloud/common"
	"github.com/tencentcloud/tencentcloud-sdk-go/tencentcloud/common/errors"
	"github.com/tencentcloud/tencentcloud-sdk-go/tencentcloud/common/profile"
	"github.com/tencentcloud/tencentcloud-sdk-go/tencentcloud/common/regions"
	cvm "github.com/tencentcloud/tencentcloud-sdk-go/tencentcloud/cvm/v20170312"
)

func main() {
  secretId, secretKey:= K8SClient.Secrets("namespace").Get("cloud-pass")
  credential := common.NewCredential("secretId", "secretKey")
  client, _ := cvm.NewClient(credential, regions.Beijing)
  request := cvm.NewDescribeZonesRequest()
  response, err := client.DescribeZones(request)
}
```

