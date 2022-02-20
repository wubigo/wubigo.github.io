+++
title = "键值存储引擎基础数据结构之跳表"
date = 2020-02-20T09:58:26+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["KVS", "CACHE"]
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

# 跳表介绍

> Skip lists are a data structure that can be used in place of balanced trees.
> Skip lists use probabilistic balancing rather than strictly enforced balancing
> and as a result the algorithms for insertion and deletion in skip lists are
> much simpler and significantly faster than equivalent algorithms for
> balanced trees.

> 跳表是一种可以用来代替平衡树的数据结构，跳表使用概率平衡而不是严格执行的平衡，
> 因此，与等效树的等效算法相比，跳表中插入和删除的算法要简单得多，并且速度要快得多。

# java跳表

```
ConcurrentSkipList
```



# 参考

[1] [Skip Lists: A Probabilistic Alternative to
Balanced Trees](https://15721.courses.cs.cmu.edu/spring2018/papers/08-oltpindexes1/pugh-skiplists-cacm1990.pdf)
