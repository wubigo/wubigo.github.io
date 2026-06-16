+++
title = "Web Testing Automation With Playwright in CDP Mode"
date = 2026-06-16T16:09:49+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["HTTP"]
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

# CDP

在 Playwright 中使用 Browser CDP（Chrome DevTools Protocol）模式，通常是连接到已经
启动的 Chrome，而不是让 Playwright 自己启动浏览器

这种方式特别适合：

- 手工登录保存长期登录态
- 降低自动化特征
- 复用真实 Chrome 用户数据目录

## 启动 Chrome 开启 CDP

```
chrome.exe ^
 --remote-debugging-port=9222 ^
 --user-data-dir=~\chrome-profile
 ```

## 访问验证

http://127.0.0.1:9222/json/version

# 开始自动化测试

```
from playwright.sync_api import sync_playwright

with sync_playwright() as p:

    browser = p.chromium.connect_over_cdp(
        "http://127.0.0.1:9222"
    )

    context = browser.contexts[0]

    page = context.new_page()

    page.goto("https://facebook.com")

    print(page.title())
```