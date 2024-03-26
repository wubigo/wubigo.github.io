+++
title = "LLM Notes"
date = 2023-04-18T11:00:40+08:00
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


# 大模型下载

```
pip install modelscope

from modelscope.hub.snapshot_download import snapshot_download

model_dir = snapshot_download('ZhipuAI/chatglm2-6b', cache_dir='./model', revision='master')
```

下载
[https://www.modelscope.cn/models/ZhipuAI/chatglm2-6b](https://www.modelscope.cn/models/ZhipuAI/chatglm2-6b)

# 分词器(Tokenizer)

tokenization算法大致经历了从word/char到subword的进化.

目前有三种主流的Subword分词算法，分别是Byte Pair Encoding (BPE), WordPiece和Unigram Language Model


Back in the ancient times, before 2013, we usually encoded basic unigram tokens using simple 1’s and 0’s in a process called One-Hot encoding. word2vec improved things by expanding these 1’s and 0’s into full vectors (aka word embeddings). BERT improved things further by using transformers and self-attention heads to create full contextual sentence embeddings.

## 传统的词编码：one-hot
## 分布式词编码：word embedding

- word2vec

CBOW模型是在已知当前词上下文context的前提下预测当前词w(t)，类似阅读理解中的完形填空；
而Skip-Gram模型恰恰相反，是在已知当前词w(t)的前提下，预测上下文context。

对于两个模型，word2vec给出了两套框架，用于训练快而好的词向量：
Hierarchical Softmax和Negative Sampling

- BERT(Bidirectional Encoder Representations from Transformers)




# 安装Tensor2Tensor

## 内存较小的环境安装

```
pip install tensorflow==2.12 tensor2tensor --no-cache-dir
```


***You must be using python <=3.7 to install Tensorflow 1.15***

## 	OpenAssistant 

[Democratizing Large Language Model Alignment](https://www.ykilcher.com/OA_Paper_2023_04_15.pdf)

Aligning large language models (LLMs) with human preferences has proven to drastically improve usability and has driven rapid adoption as demonstrated by ChatGPT. Alignment techniques such as supervised fine-tuning (SFT) and reinforcement learning from human feedback (RLHF) greatly reduce the required skill and domain knowledge to effectively harness the capabilities of LLMs, increasing their accessibility and utility across various domains.



## 训练数据集for open-source model


[RedPajama-Data-1T](https://huggingface.co/datasets/togethercomputer/RedPajama-Data-1T)



## Large Transformer Model Inference Optimization

