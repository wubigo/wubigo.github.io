+++
title = "Warp Integration With Zero Trust"
date = 2025-12-05T21:26:35+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["LLM", "SDN"]
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

# WARP配置

```
cmd\>type conf.json

{

   "interface": {
        "v4": "172.16.0.2",
        
    },
    "endpoints": [
        {
            "v4": "13.179.198.2:443",
        },        
        
        {
            "v4": "13.179.198.2:8443",
            
        },
        {
            "v4": "13.179.198.2:8095",
            
        }
    ],
    "public_key": "-----BEGIN PUBLIC KEY-----\nMFkwEwIKoZIzj0DAQcDQgAEIaU7MToJm9NKp8YfGxR6r+/h4mcG\n7SxI8tsW8OR1A5tv/zCzVbCRRh2t87/kxnP6lAy0lkr7qYwu+ox+k3dr6w==\n-----END PUBLIC KEY-----\n",
    "account": {
        "account_type": "free",
        "id": "6fc1743e-fe50-b46a-58f52d1f",
        "license": "9VI4p0o6-h7T04t3P"
    },
    "policy": {
        "onboarding": null,
        "operation_mode": null,
        "disable_auto_fallback": null,
        "fallback_domains": null,
        "proxy_port": null,
        "exclude": null,
        "gateway_id": null,
        "support_url": null,
        "allow_mode_switch": null,
        "switch_locked": null,
        "auto_connect": null,
        "captive_portal": null,
        "organization": null,
        "allow_updates": null,
        "allowed_to_leave": null,
        "profile_id": null,
        "lan_allow_minutes": null,
        "lan_allow_subnet_size": 24,
        "tunnel_protocol": "masque",
        "register_interface_ip_with_dns": null,
        
        "sccm_vpn_boundary_support": null,
        "speed_test_settings": null,
        "post_quantum": "enabled_with_downgrades",
        "doh_outside_tunnel": null,
        "enable_pmtud": null,
        "dns": null,
        "network_health_thresholds": null
    },
    "valid_until": "2025-12-06T11:24:19.193386Z",
    "alternate_networks": null,
    "dex_tests": null,
    "install_root_ca": false,
    "subnet_cidrs": null,
    "tunnel_key_data": {
        "key_type": "secp256r1",
        "tunnel_type": "masque"
    },
    "device_identifiers": "system_user"
}

```

# DNS 处理

- 创建本地 DNS 拦截：把系统 DNS 修改指向 ::ffff:127.0.2.2 / 127.0.2.2（WARP 内置 DNS 转发器）
- 实际 DNS 请求通过 DoH（DNS over HTTPS）发出，且 DoH 本身走 WARP 隧道 内（加密且受策略控制）

# 典型数据流（Traffic + DNS 模式）

1. 应用程序发包 → Windows 协议栈
2. 路由表指向 WARP 接口
3. warp-svc 捕获包
4. MASQUE 加密 → UDP/QUIC 发出到  Edge
5. Gateway 做零信任策略（Web 过滤、DLP、CASB、SASE 等）
6. 出站到目标服务器

# WARP诊断


运行warp-diag，warp把所有诊断信息及其日志信息打包，并默认发送到桌面，

解压分析诊断信息。

```
cmd\>warp-diag

cmd\>type warp-tunnel-stats.txt

Tunnel Protocol: MASQUE (HTTP/3)
Endpoints: 13.179.198.2, ::
Time since last handshake: 2002s
Sent: 17.7MB; Received: 59.2MB
Estimated latency: 212ms
Estimated loss: 0.47%
TLS Handshake:
	Version: TLSv1.3
	Post-Quantum enabled: true
	Elliptic curve: P256Kyber65erDraft00
	Cipher suite: TLS_AES_256_GCM_SHA384

```






