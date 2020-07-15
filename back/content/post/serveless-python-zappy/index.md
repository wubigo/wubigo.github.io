+++
title = "Serveless Python Zappa"
date = 2020-07-14T14:02:13+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["SLS"]
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


## python3

- 改变操作系统的地区为美国

否则报UnicodeDecodeError: 'gbk' codec can't decode 


`python-3.6.8-amd64`

```
py -3.6 -m pip install virtualenv
py -3.6 -m virtualenv venv3
.\venv3\script\activate
pip install zappa

git clone https://github.com/Miserlou/Zappa.git
cd zappy/example
pip install flask
zappa deploy dev_event
```

- 检查状态

```
zappa  status dev_api
```


## FAQ

- IllegalLocationConstraintException

```
get this error if you're trying to create a bucket with a name that's already been taken

```

https://stackoverflow.com/questions/49174673/aws-s3api-create-bucket-bucket-make-exception


```
--create-bucket-configuration LocationConstraint=eu-west-1
```