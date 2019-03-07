+++
title = "应该掌握的linux命令"
date = 2010-03-07T15:52:11+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["SHELL"]
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


LINUX shell常用工具提供强大的功能，在日常中熟练掌握能给我
带来不少动能

- grep
- cat
- find
- head/tail
- wc
- awk
- shuf

# 查找

在logs目录下查找所有包含2010_05_02的日志文件

```
ls logs/ | grep 2010_05_02
```

```
pip freeze | grep scipy
scipy==1.1.0
```

```
grep -oP "'[\w]+ == [\d.]+'"  setup.py
scipy == 1.1.0
```

#

```
find . -name '..*swp' -delete
```

# awk

```
head -n 1 data.csv | awk -F ',' '{print NF}'
```

# shuf

从数据集中随机取50个样本
```
cat big_csv.csv | shuf | head -n 50 > sample_csv.csv
```