+++
title = "Lambda Proxy vs Lambda Integration"
date = 2020-07-18T20:34:43+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["SLS"]
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


## Lambda Proxy vs Lambda Integration


https://github.com/vaquarkhan/vaquarkhan/wiki/Lambda-Proxy-vs-Lambda-Integration-in-AWS-API-Gateway


### PYTHON

https://realpython.com/code-evaluation-with-aws-lambda-and-api-gateway/

### JAVA

https://www.baeldung.com/aws-lambda-api-gateway

```
git clone https://github.com/eugenp/tutorials.git
cd tutorials/aws-lambda
mvn clean package shade:shade
aws s3 cp ./target/aws-lambda-0.1.0-SNAPSHOT.jar s3://wubigo/
```

从S3上传文件到lambad

- handler

```
com.baeldung.lambda.apigateway.APIDemoHandler::handleRequest
```

### NODEJS

https://itnext.io/how-to-build-a-serverless-app-with-s3-and-lambda-in-15-minutes-b14eecd4ea89