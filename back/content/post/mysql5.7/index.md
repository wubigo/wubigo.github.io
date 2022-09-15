+++
title = "Mysql5.7"
date = 2013-04-22T17:08:07+08:00
tags = ["SHELL", "MYSQL"]
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.

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


# mysql install

ubuntu 16.04 install mysql 5.7 at default

```
sudo apt-get update
sudo apt-get install mysql-server
```

- Enable root remote connection

```
mysql -u root -p

mysql>GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '<password>' WITH GRANT OPTION;
mysql>FLUSH PRIVILEGES;
```

# SHOW current setting

```
mysql> SHOW VARIABLES WHERE Variable_name LIKE 'innodb%';
```

 MySQL 5.7 has significantly better default values. the following variables are set by default:




```
[mysqld]
innodb_buffer_pool_instances=8 
innodb_flush_method=O_DIRECT
```

# setting of mysql 5.7




# Use utf8mb4 to fully support Unicode 


```
[client]
default-character-set=utf8mb4
[mysql]
default-character-set=utf8mb4
[mysqld]
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci
```


```
mysql> SHOW VARIABLES WHERE Variable_name LIKE 'character\_set\_%' OR Variable_name LIKE 'collation%';
+--------------------------+--------------------+
| Variable_name            | Value              |
+--------------------------+--------------------+
| character_set_client     | utf8mb4            |
| character_set_connection | utf8mb4            |
| character_set_database   | utf8mb4            |
| character_set_filesystem | binary             |
| character_set_results    | utf8mb4            |
| character_set_server     | utf8mb4            |
| character_set_system     | utf8               |
| collation_connection     | utf8mb4_unicode_ci |
| collation_database       | utf8mb4_unicode_ci |
| collation_server         | utf8mb4_unicode_ci |
+--------------------------+--------------------+
```

Repair and optimize all tables to ensure there is no side effect.

```
mysqlcheck -u root -p --auto-repair --optimize --all-databases
```


# MySQL 5.7 Performance Tuning after installation

- Basic settings

innodb_buffer_pool_size: this is the #1 setting to look at for any installation using InnoDB. The buffer pool is where data and indexes are cached: having it as large as possible will ensure you use memory and not disks for most read operations. Typical values are 5-6GB (8GB RAM), 20-25GB (32GB RAM), 100-120GB (128GB RAM).


innodb_log_file_size: this is the size of the redo logs. The redo logs are used to make sure writes are fast and durable and also during crash recovery. Up to MySQL 5.1, it was hard to adjust, as you wanted both large redo logs for good performance and small redo logs for fast crash recovery. Fortunately crash recovery performance has improved a lot since MySQL 5.5 so you can now have good write performance and fast crash recovery. Until MySQL 5.5 the total redo log size was limited to 4GB (the default is to have 2 log files). This has been lifted in MySQL 5.6.

Starting with innodb_log_file_size = 512M (giving 1GB of redo logs) should give you plenty of room for writes. If you know your application is write-intensive and you are using MySQL 5.6, you can start with innodb_log_file_size = 4G.


max_connections: if you are often facing the ‘Too many connections’ error, max_connections is too low. It is very frequent that because the application does not close connections to the database correctly, you need much more than the default 151 connections. The main drawback of high values for max_connections (like 1000 or more) is that the server will become unresponsive if for any reason it has to run 1000 or more active transactions. Using a connection pool at the application level or a thread pool at the MySQL level can help here.



https://www.percona.com/blog/2016/10/12/mysql-5-7-performance-tuning-immediately-after-installation/

```
[mysqld]
# other variables here
innodb_buffer_pool_size = 1G # (adjust value here, 50%-70% of total RAM)
innodb_log_file_size = 256M
innodb_flush_log_at_trx_commit = 1 # may change to 2 or 0
innodb_flush_method = O_DIRECT
```



Variable|	Value
:---|:---
innodb_buffer_pool_size |	Start with 50% 70% of total RAM. Does not need to be larger than the database size
innodb_flush_log_at_trx_commit	|1   (Default) 0/2 (more performance, less reliability)
innodb_log_file_size   |	128M – 2G (does not need to be larger than buffer pool)
innodb_flush_method | 	O_DIRECT (avoid double buffering)
 


 # InnoDB settings

 - innodb_file_per_table

 With MySQL 5.6, the default value is ON so you have nothing to do in most cases

 - innodb_flush_log_at_trx_commit

 the default setting of 1 means that InnoDB is fully ACID compliant. It is the best value when your primary concern is data safety, for instance on a master. However it can have a significant overhead on systems with slow disks because of the extra fsyncs that are needed to flush each change to the redo logs. Setting it to 2 is a bit less reliable because committed transactions will be flushed to the redo logs only once a second, but that can be acceptable on some situations for a master and that is definitely a good value for a replica. 0 is even faster but you are more likely to lose some data in case of a crash: it is only a good value for a replica.

 - innodb_flush_method
 
  this setting controls how data and logs are flushed to disk. Popular values are O_DIRECT when you have a hardware RAID controller with a battery-protected write-back cache and fdatasync (default value) for most other scenarios. sysbench is a good tool to help you choose between the 2 values.

- innodb_log_buffer_size

  this is the size of the buffer for transactions that have not been committed yet. The default value (1MB) is usually fine but as soon as you have transactions with large blob/text fields, the buffer can fill up very quickly and trigger extra I/O load. Look at the Innodb_log_waits status variable and if it is not 0, increase innodb_log_buffer_size.


  # other setting

 - query_cache_type

 disables the query cache, as does setting query_cache_type=0. By default, the query cache is disabled.

 - query_cache_size
 
 the query cache is a well known bottleneck that can be seen even when concurrency is moderate. The best option is to disable it from day 1 by setting query_cache_size = 0 (now the default on MySQL 5.6) and to use other ways to speed up read queries: good indexing, adding replicas to spread the read load or using an external cache (memcache or redis for instance). If you have already built your MySQL application with the query cache enabled and if you have never noticed any problem, the query cache may be beneficial for you. So you should be cautious if you decide to disable it.

- log_bin

 enabling binary logging is mandatory if you want the server to act as a replication master. If so, don’t forget to also set server_id to a unique value. It is also useful for a single server when you want to be able to do point-in-time recovery: restore your latest backup and apply the binary logs. Once created, binary log files are kept forever. So if you do not want to run out of disk space, you should either purge old files with PURGE BINARY LOGS or set expire_logs_days to specify after how many days the logs will be automatically purged.

Binary logging however is not free, so if you do not need for instance on a replica that is not a master, it is recommended to keep it disabled.

- skip_name_resolve

 when a client connects, the server will perform hostname resolution, and when DNS is slow, establishing the connection will become slow as well. It is therefore recommended to start the server with skip-name-resolve to disable all DNS lookups. The only limitation is that the GRANT statements must then use IP addresses only, so be careful when adding this setting to an existing system.
