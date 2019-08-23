+++
title = "Kafka Config"
date = 2013-04-28T17:08:07+08:00
tags = ["KAFKA", "MQ"]
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


# kafka broker  connected remotely by ip

`config/server.properties`

```
advertised.listeners=PLAINTEXT://172.16.16.5:9092


############################# Log Retention Policy #############################

# The following configurations control the disposal of log segments. The policy can
# be set to delete segments after a period of time, or after a given size has accumulated.
# A segment will be deleted whenever *either* of these criteria are met. Deletion always happens
# from the end of the log.

# The minimum age of a log file to be eligible for deletion due to age
log.retention.hours=168

```


# admin topic

- list all topic

```
./kafka-topics.sh --bootstrap-server 172.16.16.5:9092 --list
```

- delete topic

`delete.topic.enable` option set to true

Deleting a topic will also delete all its messages. This is not a reversible operation

```
./kafka-topics.sh --bootstrap-server 172.16.16.5:9092 --delete --topic my-topic
```

- describe topic

```
./kafka-topics.sh --bootstrap-server 172.16.16.5:9092 --describe  --topic alert1
```

# admin consume group

- list

```
./kafka-consumer-groups.sh --bootstrap-server 172.16.16.5:9092 --list
```

```
./kafka-consumer-groups.sh --bootstrap-server 172.16.16.5:9092 --describe --group group_id
```

```
 ./kafka-consumer-groups.sh --bootstrap-server 172.16.16.5:9092  --describe --group group_id --members


 CONSUMER-ID                                     HOST            CLIENT-ID       #PARTITIONS
consumer-2-c76c0c52-35e2-487e-9c63-39719cb2560b /192.168.200.67 consumer-2      0
consumer-2-25c4357a-38e4-4258-aa05-9072a824e03a /192.168.200.67 consumer-2      1

 ```



```
 ./kafka-consumer-groups.sh --bootstrap-server 172.16.16.5:9092  --describe --group group_id --members --verbose

CONSUMER-ID                                     HOST            CLIENT-ID       #PARTITIONS     ASSIGNMENT
consumer-2-c76c0c52-35e2-487e-9c63-39719cb2560b /192.168.200.67 consumer-2      0               -
consumer-2-25c4357a-38e4-4258-aa05-9072a824e03a /192.168.200.67 consumer-2      1               users(0)


```

- reset offset

test

```
kafka-consumer-groups.sh --bootstrap-server 172.16.16.5:9092 --reset-offsets --group group_id  --topic users --to-earliest --dry-run
```

execute

```
kafka-consumer-groups.sh --bootstrap-server 172.16.16.5:9092 --reset-offsets --group group_id  --topic users --to-earliest --execute
```


# produce msg from console

```
./kafka-console-producer.sh --broker-list 172.16.16.5:9092 --topic users
```

# consume msg from console

```
 ./kafka-console-consumer.sh --bootstrap-server 172.16.16.5:9092 --topic users
```


# spring boot with spring kafka

Spring for Apache Kafka 2.0.x is not compatible with Spring Boot 2.1.x. You have to use Spring-Kafka 2.2.x. More over would be better to just rely on the dependency from Spring Boot per se. please, see https://start.spring.io/ for more info how properly start the project for Spring Boot.


# offset can't be reset to earliest after log.rention period pass

```
kafka-consumer-groups.sh --bootstrap-server 172.16.16.5:9092 --reset-offsets --group timon-alert  --topic rawdata --to-earliest --execute

TOPIC                          PARTITION  NEW-OFFSET
rawdata                        0          174

```


# counters for number of messages received since start-up

```
kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list  172.16.16.5:9092  --topic testrawdata --time -1 --offsets 1
```

# Kafka consumer list

```
kafka-consumer-groups.sh  --list --bootstrap-server 172.16.16.5:9092
```


```
zkServer.sh start

kafka-server-start.sh -daemon /usr/local/kafka/config/server.properties
```

# delete consumer group

```
kafka-consumer-groups.sh  --delete --bootstrap-server 172.16.16.5:9092 --group timon-raw
```