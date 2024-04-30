+++
title = "本地大模型知识库问答"
date = 2024-03-27T09:43:56+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["LLM","GPT"]
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

# 本地部署

## 下载大模型

[大模型下载](https://wubigo.com/post/llm-notes/)

- https://www.modelscope.cn/models/AI-ModelScope/bge-large-zh-v1.5
- https://www.modelscope.cn/models/ZhipuAI/chatglm3-6b


## ChatGLM3

```
git clone https://github.com/THUDM/ChatGLM3
cd ChatGLM3
pip install -r requirements.txt
python
from transformers import AutoTokenizer, AutoModel
tokenizer = AutoTokenizer.from_pretrained("/home/wubigo/model/ZhipuAI/chatglm3-6b", trust_remote_code=True)
model = AutoModel.from_pretrained("/home/wubigo/model/ZhipuAI/chatglm3-6b", trust_remote_code=True, device='cuda')
model = model.eval()
response, history = model.chat(tokenizer, "你好", history=[])
```

## 初始化知识库

```
git clone --recursive https://github.com/chatchat-space/Langchain-Chatchat.git
cd Langchain-Chatchat
pip install -r requirements.txt
python copy_config_example.py
python init_database.py --recreate-vs
```

## 启动服务

```
python startup.py -a
```