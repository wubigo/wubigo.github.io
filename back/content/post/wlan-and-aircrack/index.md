+++
title = "Wlan and Aircrack"
date = 2023-11-11T20:01:49+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["WLAN"]
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


# 准备条件

- VMware Workstation支持 USB 直通的虚拟机软件
- Kali Linux 虚拟机
- 支持 Linux 驱动、Monitor Mode 和 Packet Injection 的 USB 无线网卡

建议使用有较成熟 Linux 支持的网卡，例如：
- Atheros AR9271
- MediaTek MT7612U
- MediaTek MT7601U

并将 USB 无线网卡连接到虚拟机


# 安装

```
sudo apt update
sudo apt install -y aircrack-ng iw rfkill usbutils pciutils

```

## 确认网卡支持 Monitor Mode

```
$sudo iw list
   Supported interface modes:
        * managed
        * monitor

```

再检查是否支持注入

```
sudo aireplay-ng --test wlan1

```

USB 网卡脱离 NetworkManager
```
sudo nmcli device set wlan1 managed no
```

启用 Monitor Mode

```
sudo airmon-ng start wlan1
```

## 网卡设置


```
c:\>netsh wlan show interfaces

系统上有 1 个接口:

    名称                   : WLAN
    描述                   : Intel(R) Wireless-AC 9260 160MHz
    GUID                   : c0d229o0-e3a4-4677-8dfd-1x365b456392
    物理地址               : 7c:2m:7d:4p:87:cc
    状态                   : 已连接
    SSID                   : wubigo-5G
    BSSID                  : bc:8o:ba:f8:qa:bd
    网络类型               : 结构
    无线电类型             : 802.11ac
    身份验证               : WPA2 - 个人
    密码                   : CCMP
    连接模式               : 配置文件
    信道                   : 48
    接收速率(Mbps)         : 1733.3
    传输速率 (Mbps)        : 1733.3
    信号                   : 85%
    配置文件               : wubigo-5G

    承载网络状态  : 不可用
```


## 建立一个安全的测试 AP

找到测试 AP 的 BSSID

路由器在广播 Wi-Fi 信号（信标帧，Beacon Frame）时，SSID（网络名称）
和 BSSID（硬件 MAC 地址）都是明文公开广播的，不需要连接或验证密码即
可扫描读取


```
$nmcli device wifi list

    SSID: Aircrack-Lab
    BSSID: bc:8o:ba:f8:qa:bd
    频道: 6

```

## 在自己的 AP 上进行抓包验证

```
sudo airodump-ng --bssid bc:8o:ba:f8:qa:bd --channel 6 --write lab_capture wlan1mon
```

参数说明：
- bssid：只监听你指定的测试 AP
- channel：固定到测试 AP 所在频道
- write lab_capture：将结果保存为 lab_capture-*
- wlan1mon：Monitor Mode 接口

检查抓包文件

```
ls -lh lab_capture*

aircrack-ng lab_capture-01.cap

```