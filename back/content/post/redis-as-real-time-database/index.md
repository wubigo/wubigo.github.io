+++
title = "Redis消息队列和实时数据处理"
date = 2022-02-05T11:40:58+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["REDIS", "CACHE", "NOSQL", "KVS"]
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

# REDIS

Redis (Remote Dictionary Server)是一个流行的开源内存
提供高级键值抽象的键值存储。
Redis 是单线程的，它只处理一个命令
客户端在进程的主线程中一次。 不同于传统的KV
键是简单数据类型（通常是字符串）的系统，键
在 Redis 中可以用作复杂的数据类型，例如哈希、列表、
集和排序集。 此外，Redis 支持复杂的原子
对这些数据类型的操作（例如，从
一个列表，将具有给定分数的新值插入排序集等）。
Redis 抽象和高摄取速度已被证明特别重要
对于许多延迟敏感的任务很有用。 因此，Redis
已获得广泛采用，并被越来越多的人使用
生产环境中的公司.

Redis 支持高可用性和持久性。 高可用性
是通过将数据从主节点复制到
从节点并同步它们。 当一个主进程失败时，它的
对应的从属进程已准备好接管后续进程
称为故障转移。 持久性可以通过以下任一方式配置
以下两个选项：

1. 使用时间点快照文件
称为 RDB（Redis 数据库）

2. 使用名为AOF（仅附加文件）。

注意这三种机制（AOF重写、RDB 快照和复制）依赖 fork 获取
进程内存的时间点快照并将其序列化
（而主进程继续为客户端命令提供服务）

# 项目简介

最近在做工业自动化(IIoT)项目，涉及到很多场景需要对一系列设备进行监控和信号处理。
该类场景对实时处理能力，系统稳定性，高可用性，容灾能力等等要求非常高。
其中几个核心的需求：

1. 设备数据不能丢失
2. 实时告警(毫秒级延迟)
3. 设备数据必须优先在边缘节点处理，边缘节点的物理服务器只有两台
4. 每个边缘节点接入的设备上行数据量大概6万点/秒，数据包小于1K
5. 中心需要汇聚和分析所有边缘节点的设备数据

# 技术现状

## 实时数据处理

实时数据处理是一个自 1990 年代以来一直在研究的问题 。
产生的数据量增加了，加上越来越复杂的软件解决方案
开发，需要满足这些需求出现了流式应用程序，例如
欺诈检测、网络监控和电子交易依赖于实时数据处理
确保所提供的服务被认为是正确和可靠的。
绝大多数现代应用程序使用某种数据库管理系统
处理数据。当应用程序收集或生成数据时，它会被存储和索引
它可以在以后由应用程序查询。但是，对于具有更严格
对实时数据处理的要求，这不是一个合适的方法。这是流的地方
处理开始发挥作用。流处理是在接收数据时直接处理数据。实时流
处理应用程序通常具有必须满足的某些关键要求。有低
输入和处理后的数据输出之间的延迟是实现实时的关键特征
应用。更传统的批处理方法需要以这样的方式收集数据
称为批次，其中处理只能在每个批次的最终数据块完成后开始
到达的。对于实时用例，这导致的延迟是不可接受的，因为这些实时的延迟
流应用程序最好在毫秒内。

## 现有资源

公司现有的工控产品都是基于微服务架构实现的。用于满足超大型集团公司
工控自动化需求:DEV/OPS，PaaS，双活，AI/OPS等。需要上百个虚机来支
撑现有的工控平台。

# 技术调研

## 更换消息中间件

使用REDIS STREAM替换消息中间件。
在测试中，发现REDIS作为队列，使用比较方便：

1. 消息队列动态创建，目前以时间戳为标识方便处理(例如"STREAM:02041123")
2. 消息队列消费完后删除，释放内存( isDelived && isSaved  -> redisson.getKeys().delete("STREAM:02041123"))
3. 动态检查消息队列列表，如果没有消费，立即处理(redisson.getKeys())
4. 主节点配置为缓存，从节点配置为存储

经过测试，现在redis消息队列每小时能处理2千万条的设备数据。
还需要进一步优化写入速度。

### REDIS消息处理确认流程图

![REDIS消息队列](/img/redis-stream.svg)

## 更换分布式监控
## 更换实时数据库


# REDIS数据可靠性

## REDIS ON FLASH

在许多情况下，SSD 的高性能也将延迟和吞吐量的性能瓶颈从设备 I/O 转移到了网络上。
对于应用程序而言，将其架构设计为将数据存储在本地 SSD 上而不是使用远程数据存储
服务变得更具吸引力。 这增加了对可嵌入应用程序的键值存储引擎的需求.

RocksDB单节点的存储上限是100GB，超过100GB需要使用分区。

![REDIS ON FLASH](/img/redis-on-flash.svg)

## REDIS SHARD











## 参考

[1] [A COMPARISON OF DATA INGESTION PLATFORMS IN REAL-TIME STREAMING](https://www.doria.fi/bitstream/handle/10024/177865/tallberg_sebastian.pdf?sequence=2&isAllowed=y)

[2] [Interview with the Creator of Redisson](https://www.alibabacloud.com/blog/interview-with-the-creator-of-redisson-building-an-open-source-enterprise-redis-client_593854)

[3] [What every software engineer should know about real-time data's unifying abstraction](https://engineering.linkedin.com/distributed-systems/log-what-every-software-engineer-should-know-about-real-time-datas-unifying)

[4] [Optimization of RocksDB for Redis on Flash](http://www.kereno.com/rocksdb-rof.pdf)

[5] [Memtier benchmark](https://github.com/RedisLabs/memtier_benchmark)

[6] [Distributed key-value database](https://tikv.org/docs/5.1/reference/architecture/overview/)

[7] [Evolution of Development in a Key-value Store Serving Large-scale Applications](https://dl.acm.org/doi/fullHtml/10.1145/3483840)

[8] [Block storage performance](https://cloud.google.com/compute/docs/disks/performance)

[9] [built CockroachDB on top of RocksDB](https://www.cockroachlabs.com/blog/cockroachdb-on-rocksd/)

[10] [Separating Keys from Values in SSD-conscious Storage](https://www.usenix.org/system/files/conference/fast16/fast16-papers-lu.pdf)

[11] [Atlas: Baidu’s Key-value Storage System for Cloud Data](https://wubigo.com/talk/)

[12] [Scaling HDFS to Manage Billions of Files with Key Value Stores(Hadoop Summit 2015)](https://www.slideshare.net/Hadoop_Summit/scaling-hdfs-to-manage-billions)