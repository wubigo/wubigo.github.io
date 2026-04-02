+++
title = "Claude Code Router Setup With Free Tier Llm"
date = 2026-01-02T22:52:47+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["LLM"]
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


# 安装

## 安装claude code
```
PS C:\>irm https://claude.ai/install.ps1 | iex

PS C:\>claude -v
2.1.90 (Claude Code)
```

## 安装claude-code-router

```
c:\>npm install -g @musistudio/claude-code-router
c:\>ccr -v
claude-code-router version: 2.0.0
```

# 配置

创建配置文件`~/.claude-code-router/config.json`

```
{
  "LOG": true,
  "PORT": 3456,
  "LOG_LEVEL": "info",
  "Providers": [{
    "name": "gemini",
    "api_base_url": "https://generativelanguage.googleapis.com/v1beta/models/",
    "api_key": "${GEMINI_API_KEY}",
    "models": ["gemini-2.5-flash", "gemini-2.5-pro"],
    "transformer": { "use": ["gemini"] }
  }],
  "Router": {
    "default": "gemini,gemini-2.5-flash",
    "background": "gemini,gemini-2.5-flash",
    "image": "gemini,gemini-2.5-flash",
    "think": "gemini,gemini-2.5-flash"
  }
}
```


配置环境变量

`C:\Users\bigo\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`

```
$env:ANTHROPIC_BASE_URL = "http://127.0.0.1:3456"
$env:ANTHROPIC_AUTH_TOKEN = "ccr-local-key"
$env:ANTHROPIC_API_KEY = ""
```

# 启动

```
ccr code
```

检查错误日志

`C:\Users\bigo\.claude-code-router\logs`


