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

![](/img/skip-list.png)

> Skip lists are a data structure that can be used in place of balanced trees.
> Skip lists use probabilistic balancing rather than strictly enforced balancing
> and as a result the algorithms for insertion and deletion in skip lists are
> much simpler and significantly faster than equivalent algorithms for
> balanced trees.

> 跳表是一种可以用来代替平衡树的数据结构，跳表使用概率平衡而不是严格执行的平衡，
> 因此，与等效树的等效算法相比，跳表中插入和删除的算法要简单得多，并且速度要快得多。

跳表是由包含多个级别的链表组成，最低级别的链表存储了所有的主键并且按序链接


# java跳表

https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ConcurrentSkipListMap.html


## 跳表结构

1. 多条链构成，是关键字升序排列的数据结构；
2. 包含多个级别，一个head引用指向最高的级别，最低（底部）的级别，包含所有的key；
3. 每一个级别都是其更低级别的子集，并且是有序的；
4. 如果关键字key在级别level=i中出现，则level<=i的链表中都会包含该关键字key；




ConcurrentSkipListMap和TreeMap类似，它们虽然都是有序的哈希表。但是，第一，它们的线程安全机制不同，TreeMap是非线程安全的，而ConcurrentSkipListMap是线程安全的。第二，ConcurrentSkipListMap是通过跳表实现的，而TreeMap是通过红黑树实现的

跳表分为许多层(level)，每一层都可以看作是数据的索引，这些索引的意义就是加快跳表查找数据速度。每一层的数据都是有序的，上一层数据是下一层数据的子集，并且第一层(level 1)包含了全部的数据；层次越高，跳跃性越大，包含的数据越少。跳表包含一个表头，它查找数据时，是从上往下，从左往右进行查找。

ConcurrentSkipListMap优点：

1. ConcurrentSkipListMap 的key是有序的。

2. ConcurrentSkipListMap 支持更高的并发。ConcurrentSkipListMap 的存取时间是log（N），和线程数几乎无关

## 使用场景举例

在其他线程向集合插入数据时安全的获取一个只读快照

实时流数据处理：最近5分钟订阅的最新消息列表


```
ConcurrentSkipListMap<Instant, String> events = new ConcurrentSkipListMap<>(
                                Comparator.comparingLong(v -> v.toEpochMilli()));
```

# 参考

[1] [Skip Lists: A Probabilistic Alternative to
Balanced Trees](https://15721.courses.cs.cmu.edu/spring2018/papers/08-oltpindexes1/pugh-skiplists-cacm1990.pdf)
