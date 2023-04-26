+++
title = "WebGPU Notes"
date = 2023-04-25T15:41:55+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["CV", "GPU"]
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


WebGPU is the new GPU API that available in browser. It's one of the only 2 APIs that currently available to access the GPU from browser (the other is WebGL).

WebGPU is the successor to WebGL, providing better compatibility with modern GPUs, support for general-purpose GPU computations, faster operations, and access to more advanced GPU features.






# WebGL基本问题

WebGL has some fundamental issues that needed addressing:

- Since WebGL's release, a new generation of native GPU APIs have appeared — the most popular being Microsoft's Direct3D 12, Apple's Metal, and The Khronos Group's Vulkan — which provide a multitude of new features. There are no more updates planned to OpenGL (and therefore WebGL), so it won't get any of these new features. WebGPU on the other hand will have new features added to it going forwards.
- WebGL is based wholly around the use case of drawing graphics and rendering them to a canvas. It does not handle general-purpose GPU (GPGPU) computations very well. GPGPU computations are becoming more and more important for many different use cases, for example those based on machine learning models.
- 3D graphics apps are becoming increasingly demanding, both in terms of the number of objects to be rendered simultaneously, and usage of new rendering features.


# GPU类型

- 集成GPU: 和CPU集成在一块主板上，共享内存
- 独立GPU
- 虚拟GPU: 在CPU上实现GPU


# ONNX Runtime Web

ONNX(Open Neural Network Exchange) Runtime Web enables you to run and deploy machine learning models in your web application using JavaScript APIs and libraries.

[WebGPU backend via JSEP](https://github.com/microsoft/onnxruntime/pull/14579)

