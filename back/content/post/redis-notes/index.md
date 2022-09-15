+++
title = "Redis Notes"
date = 2012-08-02T07:34:07+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["REDIS", "CACHE"]
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

#  系统配置

`/etc/sysctl.conf`

```
vm.swappiness = 1
vm.overcommit_memory = 1
```
 
# 改变数据目录

```
sudo install -o redis -g redis -d /mnt/redis-data


> config get dir
1) "dir"
2) "/mnt/redis-data"
```

`/lib/systemd/system/redis-server.service`
```
[Service]
ReadWriteDirectories=-/mnt/redis-data
```

# pidfile NOT FOUND FROM SYSTEMD

`/etc/redis/redis.conf`

```
pidfile /var/run/redis/redis-server.pid
```

`/lib/systemd/system/redis-server.service`
```
PIDFile=/run/redis/redis-server.pid
```




# 删除消费组

```
XGROUP DESTROY STREAM:TEST STRRAM:TEST:GROUP
```


# Redis latency problems troubleshooting


- Make sure you are not running slow commands that are blocking the server. Use the Redis Slow Log feature to check this.
- For EC2 users, make sure you use HVM based modern EC2 instances, like m3.medium. Otherwise fork() is too slow.
- Transparent huge pages must be disabled from your kernel. Use echo never > /sys/kernel/mm/transparent_hugepage/enabled to disable them, and restart your Redis process.
- If you are using a virtual machine, it is possible that you have an intrinsic latency that has nothing to do with Redis. Check the minimum latency you can expect from your runtime environment using ./redis-cli --intrinsic-latency 100. Note: you need to run this command in the server not in the client.
- Enable and use the Latency monitor feature of Redis in order to get a human readable description of the latency events and causes in your Redis instance.


# stop-writes-on-bgsave-error(save RDB snapshots)

MISCONF Redis is configured to save RDB snapshots, but is currently not able to persist on disk. Commands that may modify the data set are disabled. Please check Redis logs for details about the error.
```
$ redis-cli
> config set stop-writes-on-bgsave-error no
```

# Delete all the keys of the currently selected DB
    127.0.0.1:6379>FLUSHALL  or flushall

# select database

the number of databases is defined in the configuration file with the databases directive (the default value is 16). To switch between the databases, call SELECT.
    127.0.0.1:6379>select <1>

# DataType
```
    DataType type = redisTemplate.type(key);
             if(DataType.NONE == type){
                 return null;
             }else if(DataType.STRING == type){
                 return super.redisTemplate.opsForValue().get(key);
             }else if(DataType.LIST == type){
                 return super.redisTemplate.opsForList().range(key, 0, -1);
             }else if(DataType.HASH == type){
                 return super.redisTemplate.opsForHash().entries(key);
             }else
                 return null;
```

# allowing remote connection to redis

echo "bind 0.0.0.0" >> redis.conf
```
1) Just disable protected mode sending the command 'CONFIG SET protected-mode no' from the loopback interface by connecting to Redis from the same host the server is running, however MAKE SURE Redis is not publicly accessible from internet if you do so. Use CONFIG REWRITE to make this change permanent.
2) Alternatively you can just disable the protected mode by editing the Redis configuration file, and setting the protected mode option to 'no', and then restarting the server.
3) If you started the server manually just for testing, restart it with the '--protected-mode no' option.
4) Setup a bind address or an authentication password. NOTE: You only need to do one of the above things in order for the server to start accepting connections from the outside.
```

