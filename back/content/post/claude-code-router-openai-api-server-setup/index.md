+++
title = "Claude Code Router setup as an Openai API Server"
date = 2026-06-12T16:40:58+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = []
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



To set up Claude Code to run through an OpenAI-compatible API server using a tool 

like Claude Code Router (CCR), you need to configure a local proxy that translates 

Claude's native Anthropic requests into standard OpenAI API payloads



# 配置CCR

创建配置文件`~/.claude-code-router/config.json`

```
{
  "LOG": true,
  "PORT": 3456,
  "LOG_LEVEL": "info",
  "Providers": [{
    "name": "gemini",
    "api_base_url": "https://generativelanguage.googleapis.com/v1beta/openai/",
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

# 启动服务

# 测试

```
import os

from openai import OpenAI
import os

client = OpenAI(
    api_key=os.getenv("GEMINI_API_KEY"),          # 从 https://aistudio.google.com/apikey 获取
    base_url="https://generativelanguage.googleapis.com/v1beta/openai/"
)

response = client.chat.completions.create(
    # model="gemini-2.5-pro-exp-03-25",      # 常用模型推荐
    model="gemini-3-flash-preview",            # 速度快、免费额度高
    # model="gemini-1.5-pro",              # 老模型
    messages=[
        {"role": "system", "content": "你是一个有帮助的AI助手。"},
        {"role": "user", "content": "介绍一下你自己"}
    ],
    temperature=0.7,
    max_tokens=2048
)

print(response.choices[0].message.content)
```

