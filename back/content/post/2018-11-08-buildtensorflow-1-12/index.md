---
layout: post
title: build tensorflow 1.12
date: 2018-11-08
tags: ["DEEPLEARNING","TENSORFLOW"]
---


Note: 

1. Starting with TensorFlow 1.6, binaries use AVX instructions which may not run on older CPUs
      Have to build 1.6 or higher from source to run on older CPU

2. Bazel 0.19.0 doesn't read tools/bazel.rc anymore
WARNING: The following rc files are no longer being read, please transfer their contents or import their path into one of the standard rc files:
tensorflow-1.12.0/tools/bazel.rc

```
$bazel build --config=opt //tensorflow/tools/pip_package:build_pip_package --cxxopt="-D_GLIBCXX_USE_CXX11_ABI=0" --sandbox_debug > build.log 2>&1

$bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg

$pip install /tmp/tensorflow_pkg/tensorflow-<blah>.whl

$python -c 'import tensorflow as tf; print(tf.__version__)'

$pip list | grep tensorflow
```

# network-performance-monitoring
[https://github.com/tensorflow/tensorflow/issues/23402](https://github.com/tensorflow/tensorflow/issues/23402)



