+++
title = "Python3 Notes"
date = 2020-07-14T19:44:56+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["PYTHON"]
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

## PYTHON 镜像


>ERROR: Could not install packages due to an EnvironmentError: 
>HTTPSConnectionPool(host='files.pythonhosted.org', port=443)



`$HOME/.config/pip/pip.conf` 

```
[global]

trusted-host=mirrors.aliyun.com

index-url=http://mirrors.aliyun.com/pypi/simple/
```

## WINDOWS 10

```
Python 3.6.8
```


```
  File "C:\code\venv3\lib\site-packages\pip\_vendor\distlib\scripts.py", line 383, in _get_launcher
    raise ValueError(msg)
ValueError: Unable to find resource t64.exe in package pip._vendor.distlib
```


```
python -m pip uninstall pip
python -m ensurepip
python -m pip install -U pip
```
