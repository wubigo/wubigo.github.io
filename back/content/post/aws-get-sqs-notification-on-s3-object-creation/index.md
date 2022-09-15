+++
title = "基于local stack的本地S3对象创建通知"
date = 2018-11-19T16:46:13+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["LOCALSTACK", "SERVERLESS"]
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


# get s3 object creation notification


-  create queue 

```
awslocal s3 mb s3://localstack
awslocal sqs create-queue --queue-name localstack
```

- get  queue arn

```
 awslocal sqs get-queue-attributes --queue-url http://localhost:4576/queue/localstack --attribute-names All
{
    "Attributes": {
        "ApproximateNumberOfMessagesNotVisible": "0",
        "ApproximateNumberOfMessagesDelayed": "0",
        "CreatedTimestamp": "1574152022",
        "ApproximateNumberOfMessages": "1",
        "ReceiveMessageWaitTimeSeconds": "0",
        "DelaySeconds": "0",
        "VisibilityTimeout": "30",
        "LastModifiedTimestamp": "1574152022",
        "QueueArn": "arn:aws:sqs:us-east-1:000000000000:localstack"
    }
}

```

- create  s3 notification config

```
cat notification.json
{
  "QueueConfigurations": [
    {
      "QueueArn": "arn:aws:sqs:local:000000000000:localstack",
      "Events": [
          "s3:ObjectCreated:*"
        ]
    }
  ]
}

```

- make notification effect

```
awslocal s3api put-bucket-notification-configuration --bucket localstack --notification-configuration file://notification.json
```

- upload object to s3

```
awslocal s3 cp notification.json s3://localstack
```

- get notification

```
awslocal sqs receive-message --queue-url http://localhost:4576/queue/localstack
```

