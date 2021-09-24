+++
title = "Lakehouse Notes"
date = 2021-09-24T09:32:22+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["DW","DATALAKE"]
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



## Replication Method

Replication Method - Replication method to use for extracting data from the database. STANDARD replication requires no setup on the DB side but will not be able to represent deletions incrementally. CDC uses the Binlog to detect inserts, updates, and deletes. This needs to be configured on the source database itself.  

# S3 Support in Apache Hadoop

Apache Hadoop ships with a connector to S3 called "S3A", with the url prefix "s3a:";
its previous connectors "s3", and "s3n" are deprecated and/or deleted from recent Hadoop versions.

Amazon's EMR Service is based upon Apache Hadoop, but contains modifications and their own closed-source S3 client

**Important: you need a consistency layer to use Amazon S3 as a destination of MapReduce, Spark and Hive work**
You cannot use any of the S3 filesystem clients as a drop-in replacement for HDFS. Amazon S3 is an "object store" with

- Eventual consistency: changes made by one application (creation, updates and deletions) will not be visible until some undefined time.
- Non-atomic rename and delete operations. Renaming or deleting large directories takes time proportional to the number of entries -and visible to other processes during this time, and indeed, until the eventual consistency has been resolved. This breaks the commit protocol used by all these applications to safely commit the output of multiple tasks within a job.
Hadoop 3.x ships with S3Guard for consistency, and the S3A Committers for committing work.

# 统一元数据

统一的元数据管理，可以实现：

## 持久化的元数据存储

支持统一元数据之前，元数据都是在集群内部的MySQL数据库，元数据会随着集群的释放而丢失，特别是EMR提供了灵活按量模式，集群可以按需创建用完就释放。如果您需要保留现有的元数据信息，必须登录集群手动将元数据信息导出。支持统一元数据之后，释放集群不会清理元数据信息。所以，在任何时候删除OSS上或者集群HDFS上数据（包括释放集群操作）的时候，需要先确认该数据对应的元数据已经删除（即要删掉数据对应的表和数据库），否则元数据库中可能出现一些脏数据。

## 计算存储分离

EMR上可以支持将数据存放在阿里云OSS中，在大数据量的情况下将数据存储在OSS上会大大降低使用的成本，EMR集群主要用来作为计算资源，在计算完成之后可以随时释放，数据在OSS上，同时也不用再考虑元数据迁移的问题。

## 数据共享

使用统一的元数据库，如果您的所有数据都存放在OSS之上，则不需要做任何元数据的迁移和重建，所有集群都是可以直接访问数据，这样每个EMR集群可以做不同的业务，但是可以很方便地实现数据的共享。