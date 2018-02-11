---
layout: post
title: redis note
date: 2012-05-03
tag: Iaas
---

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
