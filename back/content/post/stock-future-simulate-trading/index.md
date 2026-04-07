+++
title = "Stock Future Simulate Trading"
date = 2025-04-07T11:43:40+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["IC"]
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


要在 Python 中进行 A股股指期货的模拟交易，最标准且专业的方式是使用 **CTP (Comprehensive Transaction Platform) 接口**。CTP 是国内期货公司普遍支持的交易系统。

以下是实现 Python 模拟下单的三个主要途径，按从易到难排序：

-----

### 1\. 使用开源量化交易框架：vn.py（最推荐）

`vn.py` 是国内最流行的 Python 开源量化交易系统，它已经封装好了 CTP 接口，提供了完整的图形界面和脚本接口。

  * **官方支持：** 提供专用的 [SimNow](https://www.google.com/search?q=http://www.simnow.com.cn/)（中继交易平台）模拟环境对接。
  * **如何操作：**
    1.  前往 **SimNow官网** 注册模拟账号（获取投资人账号、密码、BrokerID）。
    2.  安装 vn.py：`pip install vnpy`。
    3.  通过 `vnpy_ctp` 模块连接 SimNow 环境。
    4.  调用 `send_order` 函数即可下单。

-----

### 2\. 使用原生 CTP 接口的 Python 封装（适合进阶）

如果你不想使用庞大的框架，可以只安装 CTP 的 Python 封装库（如 `tqsdk` 或 `open_ctp`）。

**天勤量化 (TqSdk)** 是目前上手最快的 Python 期货库，它的模拟交易环境（TqSim）非常稳定。

#### 示例代码：使用 TqSdk 进行模拟下单

```python
from tqsdk import TqApi, TqAuth, TqAccount

# 1. 注册天勤账号并认证
api = TqApi(auth=TqAuth("你的手机号", "密码"))

# 2. 获取沪深300指数期货主力合约
quote = api.get_quote("CFFEX.IF2406")

# 3. 开启模拟交易账户（TqSim会自动分配虚拟资金）
# 也可以绑定真实的期货公司模拟账号
account = TqAccount("SIM", "123456") 

# 4. 下单：买入开仓 1 手 IF2406 合约，价格为当前买一价
order = api.insert_order(symbol="CFFEX.IF2406", direction="BUY", offset="OPEN", volume=1, limit_price=quote.bid_price1)

print(f"模拟订单已提交，订单ID: {order.order_id}")

# 5. 循环检查订单状态
while True:
    api.wait_update()
    if order.status == "FINISHED":
        print("模拟交易下单测试成功！")
        break

api.close()
```

-----

### 3\. 三大核心模拟环境对比

如果你准备编写 Python 代码，需要先拥有一个提供 API 接入的模拟账户：

| 平台名称 | 接入方式 | 优点 | 缺点 |
| :--- | :--- | :--- | :--- |
| **SimNow** | CTP 接口 | **最接近实盘**，支持全品种 | 仅在交易日晚上和特定时间段维护，有时不稳定 |
| **天勤 (TqSdk)** | TqApi | **代码最简洁**，无需处理复杂的 CTP 回调 | 部分高级功能可能收费 |
| **聚宽 (JoinQuant)** | 云端 Python | 适合策略回测 + 模拟，无需配置本地环境 | 订单执行逻辑较理想化，与真实撮合有差异 |

-----

### 🛠️ 技术避坑指南

1.  **合约代码格式：** 股指期货在不同平台代码不同。中金所原始代码是 `IF2406`，但在 TqSdk 中是 `CFFEX.IF2406`，在 vn.py 中通常是 `IF2406.CFFEX`。
2.  **交易时间：** 模拟系统通常只在**实盘交易时间**（周一至周五 9:30-11:30, 13:00-15:00）或**夜盘模拟时段**才接受指令。非交易时间下单会报错。
3.  **AppID 与 授权码：** 即使是模拟 CTP 交易，现在很多环境也要求提供 `AppID` 和 `AuthCode`，这些通常可以在模拟平台公告中找到。

