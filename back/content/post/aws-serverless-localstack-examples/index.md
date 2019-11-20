+++
title = "基于Localstack的函数计算开发应用列表"
date = 2018-11-16T07:25:19+08:00
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

```
serverless install -u  https://github.com/serverless/examples/tree/master/aws-node-upload-to-s3-and-postprocess  -n aws-node-upload-to-s3-and-postprocess

sls deploy -s local

awslocal logs describe-log-groups

{
    "logGroups": [
        {
            "arn": "arn:aws:logs:us-east-1:1:log-group:/aws/lambda/uload-local-postprocess",
            "creationTime": 1573867924377.624,
            "metricFilterCount": 0,
            "logGroupName": "/aws/lambda/upload-local-postprocess",
            "storedBytes": 0
        }
    ]
}


awslocal logs describe-log-streams --log-group-name /aws/lambda/uload-local-postprocess
{
    "logStreams": []
}


```



```
serverless install -u https://github.com/serverless/examples/tree/master/aws-node-s3-file-replicator -n aws-node-s3-file-replicator


sls deploy -s local


awslocal  s3api get-bucket-notification-configuration --bucket bbbb

awslocal s3api get-bucket-acl --bucket output-bucket-12345

```






`lambda_function.py`

```
import json

def my_handler(event, context):
    print("Received event: " + json.dumps(event, indent=2))
    message = 'Hello {} {}!'.format(event['first_name'], event['last_name'])
    return {
        'message': message
    }
```