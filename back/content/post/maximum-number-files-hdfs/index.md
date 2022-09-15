+++
title = "Maximum Number Files Hdfs"
date = 2021-10-09T09:55:08+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["HDFS"]
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

# HDFS

The maximum number of files in HDFS depends on two things: 

1. total storage space in the cluster 

2. the heap size of the NameNode.


1) You can find out what percentage of storage has been used from HDFS
NameNode UI.

2) The basic rule of thumb is that 1 GB heap is needed for every million of files.


Each file object and each block object takes about 150 bytes of the memory. For example, if you have 10 million files and each file has 1 one block each, then you would need about 3GB of memory for the NameNode.

If I had 10 million files, each using a block, then we would be using: 10 million + 10 million = 20 million * 150 = 3,000,000,000 bytes = 3 GB MEMORY. Keep in mind the NameNode will need memory for other processes. So to support 10 million files then your NameNode will need much more than 3GB of memory.

So you can increase your max number of files as you go. With increasing
heap for every 1 million files.


# JindoFS介绍和使用

JindoFS提供兼容对象存储的纯客户端模式（SDK）和缓存模式（Cache），
以支持与优化Hadoop和Spark生态大数据计算对OSS的访问；
提供块存储模式（Block），以充分利用OSS的海量存储能力和优化文件系统元数据的操作。


Q：Block模式跟HDFS相比，是更好的HDFS？

A：
HDFS的常规限制为4亿，而Block模式元数据规模上支撑10亿以上的文件数，大于HDFS的限制，而且在集群高峰期时性能更为稳定。
HDFS有Java onheap限制，而Block模式没有Java onheap和内存限制，可以支持更大的数据规模。
Block模式轻运维，不用担心坏盘或坏节点，数据1备份放置在OSS上，支持上下线节点。
支持对冷数据做透明压缩和归档，使用多种手段进行成本优化，对接对象存储，支持EB级数据规模。
Block模式支持HDFS的一些重要特性。例如，HDFS AuditLog、Ranger集成和数据加密。

Q：Block模式具有哪些特别的优势？

A：
Block模式可以管理文件元数据和组织文件数据，因此可以不局限于OSS对象存储，完全可以满足各种大数据引擎对存储接口的需求。这些接口包括但不限于Rename的原子性和事务性能力、高性能本地写入、透明压缩、truncate、append、flush、sync和snapshot等。这些高阶存储接口对实现完整的POSIX和对接更多的大数据引擎到OSS是不可或缺的，例如，Flink、HBase、Kafka和Kudu。其他两种方式使用OSS也可以对接部分接口，但是能力和优势会有所不足。
Block模式在费用上优于其他两种方式使用OSS。Block模式中，因为全部数据中占比60%的温数据和热数据都在本地有缓存备份，大部分读请求都不会通过OSS，所以可以节省一部分费用。