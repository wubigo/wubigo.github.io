+++
title = "Redis With Spring Boot V2"
date = 2016-04-28T17:08:07+08:00
tags = ["CACHE", "REDIS"]
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




# LETTUCE VS JEDIS
While Jedis is easy to use and supports a vast number of Redis features, it is not thread safe and needs connection pooling to work in a multi-threaded environment. Connection pooling comes at the cost of a physical connection per Jedis instance which increases the number of Redis connections.

Lettuce, on the other hand, is built on netty (https://netty.io/) and connection instances can be shared across multiple threads. So a multi-threaded application can use a single connection regardless the number of concurrent threads that interact with Lettuce.

SYNC VS ASYNC
One other reason we opted to go with Lettuce was that it facilitates asynchronicity from building the client on top of netty that is a multithreaded, event-driven I/O framework. Asynchronous methodologies allow you to utilize better system resources, instead of wasting threads waiting for network or disk I/O. Threads can be fully utilised to perform other work instead.

For the purpose of having a concurrently processing system, it’s convenient, in this scenario, to have all communication handled asynchronously. There are scenarios where this might not be the case, where you have quick running tasks and try to access data that has just been invalidated by a different task.



# Connecting to Redis

***
  spring-boot-starter-data-redis resolves Lettuce by default. Spring provides LettuceConnectionFactory to get connections. To get pooled connection factory we need to provide commons-pool2 on the classpath
***

```
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-pool2</artifactId>
        </dependency>
```



```
redis-cli
CONFIG GET databases
INFO keyspace
```