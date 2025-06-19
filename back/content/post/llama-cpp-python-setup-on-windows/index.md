+++
title = "在 Windows 上安装 llama-cpp-python 完整指南"
date = 2025-06-17T16:42:02+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["AI", "LLM"]
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

在 Windows 上安装 llama-cpp-python 完整指南



以下是在 Windows 系统上安装支持 GPU 加速的 llama-cpp-python 的详细步骤，包含常见问题解决方案和性能优化技巧

## 🛠 安装前准备

### 1. 系统要求
- **操作系统**：Windows 10 (64位)
- **Python**：3.10 或更高版本
- **内存**：至少 16GB RAM
- **显卡**：AMD GPU (支持 Vulkan)


### 2. 安装必备组件
1. **安装 Python**

```
python
Python 3.10.9 (tags/v3.10.9:1dd9be6, Dec  6 2022, 20:01:21) [MSC v.1934 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information
```

2. **安装 Visual Studio Build Tools**
   - 下载 [Visual Studio 2022](https://visualstudio.microsoft.com/downloads/)
   - 安装时选择：
     - "Desktop development with C++"
     - "Windows 10/11 SDK"
     - "C++ CMake tools"

3. **安装 CUDA Toolkit (NVIDIA 用户)**
   - 下载 [CUDA Toolkit 12.x](https://developer.nvidia.com/cuda-downloads)
   - 选择 Windows 版本安装

4. **安装 CMake**
   - 从 [CMake 官网](https://cmake.org/download/) 下载
   - 安装时勾选 **"Add CMake to the system PATH"**

5. **更新显卡启动**

```
驱动程序提供商: Advanced Micro Devices, inc.
驱动程序日期: 2025/3/6
驱动程序版本: 31.0.21923.1000
```

## 安装llama-cpp-python

```
cmd/>pip install llama-cpp-python --prefer-binary
```

```
cmd/>pip show llama-cpp-python
Name: llama_cpp_python
Version: 0.3.9
Summary: Python bindings for the llama.cpp library
Home-page:
Author:
Author-email: Andrei Betlen <abetlen@gmail.com>
License: MIT
Location: c:\python310\lib\site-packages
Requires: diskcache, jinja2, numpy, typing-extensions
Required-by:
```
### 验证安装

```
import sys
import os
from ctypes import CDLL

try:
    # 尝试直接加载DLL
    dll_path = r"C:\Python310\lib\site-packages\llama_cpp\lib\llama.dll"
    CDLL(dll_path)
    print("✅ DLL 加载成功!")
    
    # 验证功能
    from llama_cpp import Llama
    llm = Llama(model_path="ol.gguf")  # 使用小测试模型
    print(llm.create_completion("Hello", max_tokens=10))
except Exception as e:
    print(f"❌ 错误: {e}")
    print("系统PATH:", os.environ['PATH'])
```

