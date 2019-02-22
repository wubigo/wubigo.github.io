---
layout: post
title: streaming note
date: 2016-03-21
tag: Bigdata
---


# log-based vs memory-based broker

“Thus, in situations where messages may be expensive to process and you want to parallelize 
processing on a message-by-message basis, and where message ordering is not so important, 
the JMS/AMQP style of message broker is preferable. On the other hand, in situations 
with high message throughput, where each message is fast to process and where message 
ordering is important, the log-based approach works very well.”


“the throughput of a log remains more or less constant, since every message is written to disk 
anyway [18]. This behavior is in contrast to messaging systems that keep messages in memory
by default and only write them to disk if the queue grows too large: such systems are fast 
when queues are short and become much slower when they start writing to”




