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


## 检查CCR日志

转换ccr日志时间为可读格式

```
env:ANTHROPIC_BASE_URL = "http://127.0.0.1:3456"
$env:ANTHROPIC_AUTH_TOKEN = "ccr-local-key"   # 很多配置默认用这个，或留空看日志
$env:ANTHROPIC_API_KEY = ""
$env:GEMINI_API_KEY="gemini-key-aistudio"



# Claude Code Router 美化日志函数
function ccr-log {
    param([int]$Tail = 100)

    $logPath = "$HOME\.claude-code-router\logs\ccr-*.log"
    $latestLog = Get-ChildItem $logPath -ErrorAction SilentlyContinue | 
                 Sort-Object LastWriteTime -Descending | 
                 Select-Object -First 1

    if (-not $latestLog) {
        Write-Host "未找到 claude-code-router 日志文件" -ForegroundColor Red
        return
    }

    Write-Host "日志文件: $($latestLog.Name)  (最近 $Tail 行)" -ForegroundColor Green

    Get-Content $latestLog.FullName -Tail $Tail | ForEach-Object {
        if ($_ -match '"time":\s*(\d+)') {
            $unixMs = [long]$matches[1]
            $readableTime = [DateTimeOffset]::FromUnixTimeMilliseconds($unixMs).ToLocalTime().ToString("yyyy-MM-dd HH:mm:ss.fff")
            # 正确转义后的替换
            $_ -replace '"time":\s*\d+', "`"time`": `"$readableTime`""
        } 
        else {
            $_
        }
    }
}
```


```
PS1 c:\>ccr-log |more

{"level":30,"time": "2026-04-03 16:12:23.332","pid":10396,"hostname":"wu-pc","msg":"register transformer: Anthropic (endpoint: /v1/messages)"}       
{"level":30,"time": "2026-04-03 16:12:23.332","pid":10396,"hostname":"wu-pc","msg":"register transformer: gemini (endpoint: /v1beta/models/:modelAndAction)"}
{"level":30,"time": "2026-04-03 16:12:23.332","pid":10396,"hostname":"wu-pc","msg":"register transformer: vertex-gemini (no endpoint)"}
{"level":30,"time": "2026-04-03 16:12:23.332","pid":10396,"hostname":"wu-pc","msg":"register transformer: vertex-claude (no endpoint)"}
{"level":30,"time": "2026-04-03 16:12:23.332","pid":10396,"hostname":"wu-pc","msg":"register transformer: deepseek (no endpoint)"}
{"level":30,"time": "2026-04-03 16:12:23.332","pid":10396,"hostname":"wu-pc","msg":"register transformer: tooluse (no endpoint)"}
{"level":30,"time": "2026-04-03 16:12:23.332","pid":10396,"hostname":"wu-pc","msg":"register transformer: openrouter (no endpoint)"}
{"level":30,"time": "2026-04-03 16:12:23.332","pid":10396,"hostname":"wu-pc","msg":"register transformer: OpenAI (endpoint: /v1/chat/completions)"}
{"level":30,"time": "2026-04-03 16:12:23.332","pid":10396,"hostname":"wu-pc","msg":"register transformer: maxtoken (no endpoint)"}
{"level":30,"time": "2026-04-03 16:12:23.333","pid":10396,"hostname":"wu-pc","msg":"register transformer: groq (no endpoint)"}
{"level":30,"time": "2026-04-03 16:12:23.333","pid":10396,"hostname":"wu-pc","msg":"register transformer: cleancache (no endpoint)"}
{"level":30,"time": "2026-04-03 16:12:23.333","pid":10396,"hostname":"wu-pc","msg":"register transformer: enhancetool (no endpoint)"}
{"level":30,"time": "2026-04-03 16:12:23.333","pid":10396,"hostname":"wu-pc","msg":"register transformer: reasoning (no endpoint)"}
{"level":30,"time": "2026-04-03 16:12:23.333","pid":10396,"hostname":"wu-pc","msg":"register transformer: sampling (no endpoint)"}
{"level":30,"time": "2026-04-03 16:12:23.333","pid":10396,"hostname":"wu-pc","msg":"register transformer: maxcompletiontokens (no endpoint)"}
{"level":30,"time": "2026-04-03 16:12:23.333","pid":10396,"hostname":"wu-pc","msg":"register transformer: cerebras (no endpoint)"}
{"level":30,"time": "2026-04-03 16:12:23.333","pid":10396,"hostname":"wu-pc","msg":"register transformer: streamoptions (no endpoint)"}
{"level":30,"time": "2026-04-03 16:12:23.333","pid":10396,"hostname":"wu-pc","msg":"register transformer: customparams (no endpoint)"}
{"level":30,"time": "2026-04-03 16:12:23.333","pid":10396,"hostname":"wu-pc","msg":"register transformer: vercel (no endpoint)"}
{"level":30,"time": "2026-04-03 16:12:23.333","pid":10396,"hostname":"wu-pc","msg":"register transformer: openai-responses (endpoint: /v1/responses)"}{"level":30,"time": "2026-04-03 16:12:23.333","pid":10396,"hostname":"wu-pc","msg":"register transformer: forcereasoning (no endpoint)"}
```



