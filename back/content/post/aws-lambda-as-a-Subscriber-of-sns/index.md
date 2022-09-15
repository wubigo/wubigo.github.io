+++
title = "Lambda订阅SNS通知(上)"
date = 2018-12-31T11:04:37+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["AWS", "LAMBDA", "SNS", "SLS", "SERVERLESS"]
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


## 发布测试消息到SNS

```
git clone https://github.com/wubigo/node-fn/blob/master/fn-case/sns_publishtotopic.js

node sns_publishtotopic.js

Message MESSAGE_TEXT send sent to the topic arn:aws:sns:ap-northeast-1:465691908928:func-topic
MessageID is 8b5c90f2-0c74-5985-8a34-c676c0370f73
```


## 根据MessageID查看函数执行结果

The $ in [$LATEST] needs to be escaped...[\$LATEST].

```
aws logs describe-log-groups --query logGroups[*].logGroupName
aws logs describe-log-streams --log-group-name '/aws/lambda/my-function' --query logStreams[*].logStreamName

aws logs get-log-events --log-group-name '/aws/lambda/my-function' --log-stream-name '2019/12/31/[$LATEST]7467497f9cdb4078a876ab889797793c'



        {
            "ingestionTime": 1577764111252,
            "timestamp": 1577764096184,
            "message": "2019-12-31T03:48:16.183Z\tc01c9f5e-6c33-40a1-a6d9-c11ab248ab48\tINFO\tEVENT\n{\n  \"Records\": [\n    {\n      \"EventSource\": \"aws:sns\",\n      \"EventVersion\": \"1.0\",\n      \"EventSubscriptionArn\": \"arn:aws:sns:ap-northeast-1:465691908928:func-topic:2e0e0d95-f1c8-47bd-90ff-40ca4129794b\",\n      \"Sns\": {\n        \"Type\": \"Notification\",\n        \"MessageId\": \"5f80d26e-bdeb-579f-bc81-84ea7ad4e2ae\",\n        \"TopicArn\": \"arn:aws:sns:ap-northeast-1:465691908928:func-topic\",\n        \"Subject\": null,\n        \"Message\": \"MESSAGE_TEXT\",\n        \"Timestamp\": \"2019-12-31T03:48:15.624Z\",\n        \"SignatureVersion\": \"1\",\n        \"Signature\": \"UYKR86o1NPa3xh8LQ6gM8eDxm6l/TY3YHU9Ez5m8Ve8eCHa5e4Xp6+PT/01mjyXGWNHjhcPVYg9esiRLzljcYm26VDODhlTe8q9h20h43azYbMM8CjtK+GhuxDPFoSG/N2FuwnKRZK9JWw+QbG2OD09vy6k5g7EX2BcEGR+A0LGQ0EXvVm9j3fvC2P2yiLCRwZPulsgqMEJeR9rZiBfUnsnhY+oCnTk7OcBhkMQ9LQctFbFXdrG7BQOkqJgN0pJa9f8kwF48lG6eCAZinxNRQ7DoR0pg608XWjbMZF6uu1ttmU1iPNjYwnH0B9HIgK9E0Rs0s819jKqCaHqXW5KjUg==\",\n        \"SigningCertUrl\": \"https://sns.ap-northeast-1.amazonaws.com/SimpleNotificationService-6aad65c2f9911b05cd53efda11f913f9.pem\",\n        \"UnsubscribeUrl\": \"https://sns.ap-northeast-1.amazonaws.com/?Action=Unsubscribe&SubscriptionArn=arn:aws:sns:ap-northeast-1:465691908928:func-topic:2e0e0d95-f1c8-47bd-90ff-40ca4129794b\",\n        \"MessageAttributes\": {}\n      }\n    }\n  ]\n}"
        }



```


