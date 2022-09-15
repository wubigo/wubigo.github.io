+++
title = "基于Localstack的本地云服务编排"
date = 2018-04-29T14:20:42+08:00
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


https://stackoverflow.com/questions/44547574/create-api-gateway-in-localstack/48682628




https://github.com/localstack/localstack/issues/632

AWS SAM is an extension for the AWS CloudFormation template language that lets you define serverless
applications at a higher level

# localstack default regrion


**us-east-1**


# create stack 

**file path has to be in file URL format(file:///home/user/...)**

`func.yaml`

```
AWSTemplateFormatVersion: '2010-09-09'
Description: Simple CloudFormation Test Template
Resources:
  S3Bucket:
    Type: AWS::S3::Bucket
    Properties:
      AccessControl: PublicRead
      BucketName: test-bucket-1
```

```
aws cloudformation create-stack --stack-name funstack --template-body file:///data/func.yaml --endpoint-url=http://localhost:4581 --region us-east-1
```


```
aws cloudformation describe-stacks  --endpoint-url=http://localhost:4581 --region us-east-1


```

