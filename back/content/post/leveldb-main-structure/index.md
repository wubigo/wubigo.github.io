+++
title = "LevelDB结构解析"
date = 2020-02-20T19:13:49+08:00
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

LevelDB 是一基于内存+SSD的键值存储引擎。

- 内存存储最新的更改和热数据(缓存)
- SSD持久化所有数据

LevelDB经常使用代理+主从模式构建集群。
与REDIS协议保持兼容，可以被REDIS客户端访问。


![](/img/leveldb-sst.png)


## 内存结构

LevelDB在内存维护两个[跳表](/post/leveldb之跳表/):MemTable,
一个只读，一个可写。

序列号(Sequence number)是全局自增的，每次的修改序列号都会加1。
每个主键保存多个版本的键值。LevelDB用serial number标识键值对
的版本。最大的serial number代表最新的键值对。

键值对有两种更新操作：

- Put = 1
- Delete = 0

当可写的MemTable的大小超过阈值，会把所有的键值转移到只读的MemTable。
同时会创建一个新的可写的MemTable。只读的MemTable会被一个线程异步的
写入SSD。读操作会先查询可写的MemTable，然后查询只读的MemTable，最后
去查询SSD.

对可写的MemTable支持多线程操作，所以需要并发控制。

只读的MemTable存在时间很短，被创建后就会把异步写入SSD,然后清空。
当可写的MemTable增长很快，只读的MemTable会很快被填满。如果只读
的MemTable还没有别完全写入SSD，写入线程就会被阻塞。

### 内存结构操作日志

最近的MemTable的写入操作都会有一个对应的日志文件记录。
日志文件也有两份，对应两个跳表。

## SSD数据结构

### SST

LevelDB在SSD上存储了许多SST(Sorted String Table)文件,
每个文件对应一个级别，每个级别有多个SST文件。
SST文件的大小是相同的，不同的是每个级别文件数目不同。
主键在每个SST文件都是有序的。
级别0的文件和其他级别的文件有一个明显的区别：其他级别的SST
文件之间的主键不会重叠，但级别0的SST文件之间的主键可能重叠，
因为级别0的SST文件之间从MemTable直接转存过来。

为了防止在级别0的SST文件进行键值读取的读放大，LevelDB默认
级别0有4个文件。

### MANIFEST

所有文件的主键范围，级别和其他的元信息存储在MANIFEST文件。
MANIFEST有版本号，通过文件名后缀标识，例如MANIFEST-000031。
每次打开数据库，一个新的版本号的MANIFEST就好被创建，旧版本
的文件就会被删除。

### CURRENT

CURRENT文件内容记录了当前版本的MANIFEST文件名字。LevelDB首先读
CURRENT文件内容知道合法的MANIFEST文件。

### LOCK

LevelDB数据库目录不允许被多个进程同时访问，当一个进程打开数据库，
一个排他的文件锁就创建。

### log

日志文件，记录操作日志，例如次要整理和主要整理日志

## 数据整理

从只读MemTable到0级的SST文件的转移叫次级整理。从SST文件向
更低级转移交主要整理。

## 文件合并

