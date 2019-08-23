+++
title = "Flink Cluster"
date = 2018-04-28T17:08:07+08:00
tags = ["STREAM", "BIGDATA"]
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


# execution environment

```
Creates an execution environment that represents the context in which the program is
   currently executed. If the program is invoked standalone, this method returns a local
   execution environment. If the program is invoked from within the command line client
   to be submitted to a cluster, this method returns the execution environment of this cluster.

```

# REST instead of akka

in 1.5 changing the client to communicate via REST instead of akka. Thus, the port you usually want to specify is 8081, the same that the WebUI runs on.

The exception is caused by the client sending http messages to the port that akka listens on, which it of course cannot properly read.


```
flink list -m localhost:8081
```


```
StreamExecutionEnvironment.createRemoteEnvironment("localhost", 8081)
```


# Flink Kafka Consumer

The Flink Kafka Consumer integrates with Flink’s checkpointing mechanism to provide exactly-once processing semantics. To achieve that, Flink does not purely rely on Kafka’s consumer group offset tracking, but tracks and checkpoints these offsets internally as well.