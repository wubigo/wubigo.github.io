+++
title = "如何实现Edgex设备服务"
date = 2022-03-13T17:19:50+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["IOT"]
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


# 驱动服务客户端初始化与核心数据和命令服务

// InitDependencyClients triggers Service Client Initializer to establish connection to Metadata and Core Data Services
// through Metadata Client and Core Data Client.
// Service Client Initializer also needs to check the service status of Metadata and Core Data Services,
// because they are important dependencies of Device Service.
// The initialization process should be pending until Metadata Service and Core Data Service are both available.






# 驱动


```
diff --git a/internal/driver/driver.go b/internal/driver/driver.go

@@ -388,7 +389,7 @@ func (d *Driver) Initialize(lc logger.LoggingClient, asyncCh 
-
+       debug.PrintStack()
```


```
runtime/debug.Stack()
        C:/local/go/src/runtime/debug/stack.go:24 +0x7a
runtime/debug.PrintStack()
        C:/local/go/src/runtime/debug/stack.go:16 +0x19
github.com/edgexfoundry/device-camera-go/internal/driver.(*Driver).Initialize(0xc00034fa00, {0x14495f0, 0xc0003714a0}, 0xc000480060, 0x0)        
        D:/code/go/src/github.com/edgexfoundry/device-camera-go/internal/driver/driver.go:392 +0xc7
github.com/edgexfoundry/device-sdk-go/v2/pkg/service.(*Bootstrap).BootstrapHandler(0xc0000d26e0, {0x14408d8, 0xc00036b0c0}, 0xc000388680, {{0xc08
38af7a5288f3c, 0xf37d35, 0x17238c0}, 0xdf8475800, 0x3b9aca00}, 0xc00034fa80)
        D:/code/go/pkg/mod/github.com/edgexfoundry/device-sdk-go/v2@v2.2.0-dev.8/pkg/service/init.go:55 +0x62d
github.com/edgexfoundry/go-mod-bootstrap/v2/bootstrap.RunAndReturnWaitGroup({0x14408d8, 0xc00036b0c0}, 0xc0003827f0, {0x1446b90, 0xc000351500}, {
0x13d7f8f, 0xd}, {0x13d868d, 0xe}, {0x1445710, ...}, ...)
        D:/code/go/pkg/mod/github.com/edgexfoundry/go-mod-bootstrap/v2@v2.1.0/bootstrap/bootstrap.go:158 +0xa33
github.com/edgexfoundry/go-mod-bootstrap/v2/bootstrap.Run({0x14408d8, 0xc00036b0c0}, 0xc0003827f0, {0x1446b90, 0xc000351500}, {0x13d7f8f, 0xd}, {
0x13d868d, 0xe}, {0x1445710, ...}, ...)
        D:/code/go/pkg/mod/github.com/edgexfoundry/go-mod-bootstrap/v2@v2.1.0/bootstrap/bootstrap.go:184 +0x19c
github.com/edgexfoundry/device-sdk-go/v2/pkg/service.Main({0x13d7f8f, 0xd}, {0x13e0370, 0x1a}, {0x1391bc0, 0xc00034fa00}, {0x14408d8, 0xc00036b0c
0}, 0xc0003827f0, 0xc0002c1bc0)
        D:/code/go/pkg/mod/github.com/edgexfoundry/device-sdk-go/v2@v2.2.0-dev.8/pkg/service/main.go:66 +0x9b3
github.com/edgexfoundry/device-sdk-go/v2/pkg/startup.Bootstrap({0x13d7f8f, 0xd}, {0x13e0370, 0x1a}, {0x1391bc0, 0xc00034fa00})
        D:/code/go/pkg/mod/github.com/edgexfoundry/device-sdk-go/v2@v2.2.0-dev.8/pkg/startup/bootstrap.go:19 +0x11a
main.main()
        D:/code/go/src/github.com/edgexfoundry/device-camera-go/cmd/main.go:22 +0x4c

```

