+++
title = "基于Localstack的Serverless框架本地集成"
date = 2018-11-15T15:39:37+08:00
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

# install nodejs


# install serverless

```
npm install -g serverless

npm install serverless-localstack
```


- check serverless version

```
serverless -v

Framework Core: 1.57.0
Plugin: 3.2.3
SDK: 2.2.1
Components Core: 1.1.2
Components CLI: 1.4.0
```


# create serverless function

```

serverless create --template aws-nodejs --path my-service

cd my-service
```


`serverless.yml`


```
functions:
  hello:
    handler: handler.hello
    events:
      - http:
          path: ping
          method: get
```


```
plugins:
 - serverless-localstack
custom:
  localstack:
    debug: true
    stages:
      - local
      - dev
    host: http://localhost
    endpoints:
      S3: http://localhost:4572
      DynamoDB: http://localhost:4570
      CloudFormation: http://localhost:4581
      Elasticsearch: http://localhost:4571
      ES: http://localhost:4578
      SNS: http://localhost:4575
      SQS: http://localhost:4576
      Lambda: http://localhost:4574
      Kinesis: http://localhost:4568
      APIGateway: http://localhost:4567
      CloudWatch: http://localhost:4582
      CloudWatchLogs: http://localhost:4586
      CloudWatchEvents: http://localhost:4587
```


# deploy 


redeploy if all Functions, Events or Resources 

in serverless.yml changed

```
serverless deploy --verbose --stage local




Serverless: Using serverless-localstack
Serverless: Reconfiguring service apigateway to use http://localhost:4567
Serverless: Reconfiguring service cloudformation to use http://localhost:4581
Serverless: Reconfiguring service cloudwatch to use http://localhost:4582
Serverless: Reconfiguring service lambda to use http://localhost:4574
Serverless: Reconfiguring service dynamodb to use http://localhost:4569
Serverless: Reconfiguring service kinesis to use http://localhost:4568
Serverless: Reconfiguring service route53 to use http://localhost:4580
Serverless: Reconfiguring service firehose to use http://localhost:4573
Serverless: Reconfiguring service stepfunctions to use http://localhost:4585
Serverless: Reconfiguring service es to use http://localhost:4578
Serverless: Reconfiguring service s3 to use http://localhost:4572
Serverless: Reconfiguring service ses to use http://localhost:4579
Serverless: Reconfiguring service sns to use http://localhost:4575
Serverless: Reconfiguring service sqs to use http://localhost:4576
Serverless: Reconfiguring service sts to use http://localhost:4592
Serverless: Reconfiguring service iam to use http://localhost:4593
Serverless: Reconfiguring service ssm to use http://localhost:4583
Serverless: Reconfiguring service rds to use http://localhost:4594
Serverless: Reconfiguring service ec2 to use http://localhost:4597
Serverless: Reconfiguring service elasticache to use http://localhost:4598
Serverless: Reconfiguring service kms to use http://localhost:4599
Serverless: Reconfiguring service secretsmanager to use http://localhost:4584
Serverless: Reconfiguring service logs to use http://localhost:4586
Serverless: Reconfiguring service cloudwatchlogs to use http://localhost:4586
Serverless: Reconfiguring service iot to use http://localhost:4589
Serverless: Reconfiguring service cognito-idp to use http://localhost:4590
Serverless: Reconfiguring service cognito-identity to use http://localhost:4591
Serverless: Reconfiguring service ecs to use http://localhost:4601
Serverless: Reconfiguring service eks to use http://localhost:4602
Serverless: Reconfiguring service xray to use http://localhost:4603
Serverless: Reconfiguring service appsync to use http://localhost:4605
Serverless: Reconfiguring service cloudfront to use http://localhost:4606
Serverless: Reconfiguring service athena to use http://localhost:4607
Serverless: Reconfiguring service S3 to use http://localhost:4572
Serverless: Reconfiguring service DynamoDB to use http://localhost:4570
Serverless: Reconfiguring service CloudFormation to use http://localhost:4581
Serverless: Reconfiguring service Elasticsearch to use http://localhost:4571
Serverless: Reconfiguring service ES to use http://localhost:4578
Serverless: Reconfiguring service SNS to use http://localhost:4575
Serverless: Reconfiguring service SQS to use http://localhost:4576
Serverless: Reconfiguring service Lambda to use http://localhost:4574
Serverless: Reconfiguring service Kinesis to use http://localhost:4568
Serverless: config.options_stage: local
Serverless: serverless.service.custom.stage: undefined
Serverless: serverless.service.provider.stage: dev
Serverless: config.stage: local
Serverless: Packaging service...
Serverless: Excluding development dependencies...
Serverless: Creating Stack...
Serverless: Checking Stack create progress...
CloudFormation - CREATE_COMPLETE - AWS::CloudFormation::Stack - my-service-local
Serverless: Stack create finished...
Serverless: Uploading CloudFormation file to S3...
Serverless: Uploading artifacts...
Serverless: Uploading service my-service.zip file to S3 (389 B)...
Serverless: Validating template...
Serverless: Skipping template validation: Unsupported in Localstack
Serverless: Updating Stack...
Serverless: Checking Stack update progress...
CloudFormation - UPDATE_COMPLETE - AWS::CloudFormation::Stack - my-service-local
Serverless: Stack update finished...
Service Information
service: my-service
stage: local
region: us-east-1
stack: my-service-local
resources: 11
api keys:
  None
endpoints:
  GET - http://localhost:4567/restapis/gnz8rtc0xd/local/_user_request_/ping
functions:
  hello: my-service-local-hello
layers:
  None

Stack Outputs
ServerlessDeploymentBucketName: my-service-local-ServerlessDeploymentBucket-01EGLIMU6EYB
HelloLambdaFunctionQualifiedArn: HelloLambdaVersionssJzcvFmzKtAcczGFSyyYtxtSzfXFRBYUf4ZEfoXes
ServiceEndpoint: https://gnz8rtc0xd.execute-api.us-east-1.amazonaws.com/local

```

# debug sls

```
SLS_DEBUG=*  sls deploy -s local
```

# test function

- with serverless

```
serverless invoke local -f hello -l
```

- with curl

```
curl http://localhost:4567/restapis/gnz8rtc0xd/local/_user_request_/ping
```


# deploy function to localstack

```
serverless deploy function -f hello  -v --stage local
```



```
serverless invoke local -f hello -l
```


#  serverless-localstack issue

- service name has to be less than 5 character(the deployment bucket name gets truncated at 63 characters)


By default, Serverless creates a bucket with a generated name like

**<service name>-<stage>-serverlessdeploymentbuck-1x6jug5lzfnl7**

to store your service's stack state



https://github.com/MikeSouza/serverless-deployment-bucket


https://github.com/localstack/serverless-localstack/issues/30


check the buckets after deployment

```
awslocal s3 ls
2006-02-03 08:45:09 my-service-local-ServerlessDeploymentBucket-JBV56BIWWO4T
2006-02-03 08:45:09 simple-point-local-ServerlessDeploymentBucket-NI6J3QAYAJ55
```