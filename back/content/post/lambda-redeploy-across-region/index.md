+++
title = "Lambda Redeploy Across Region"
date = 2021-10-22T11:59:36+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["LAMBDA", "SLS"]
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


# 计算时间 vs 请求数量

## 平均计算时长

427586 / 27386 = 15.6 (秒)

![](/img/aws-lambda-fee.png)

# 设置默认配置

```
aws configure list-profiles

default
us-east-1
us-east-2
us-west-2
us-west-1
eu
eu-west-1
af-south-1
ap-east-1
ap-south-1
ap-northeast-3
ap-northeast-2
ap-southeast-1
ap-southeast-2
ca-central-1
eu-west-2
eu-south-1
eu-west-3
eu-north-1
me-south-1
sa-east-1

export AWS_PROFILE=us
```

# 下载部署包


```
aws lambda get-function --function-name webdriver


"Code": {
        "RepositoryType": "S3",
        "Location": "https://awslambda-ap-ne-1-tasks.s3.ap-northeast-1.amazonaws.com/snapshots/webdriver-aeb2eb63-9baf-4d06-9d3a-79459b172200?versionId=a71tk2dwwmvW1lPNB5VHKq8SbGS3laqE&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEHIaDmFwLW5vcnRoZWFzdC0xIkcwRQIhAMRkIxPh1Fkd2nlCzgiDbsrmnCZEVunHibw2Cm6cyRIUAiB5t60IO6iESPDeUsTuQEjGyLfI73QyMK1mJY9Al70yECqNBAj8%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAIaDDkxOTk4MDkyNTEzOSIMjVD0S8e1HGmJujr6KuEDO8SCL9OcolFOwL4IKMbE3euJLEtiGjSxH6c8jRPbnjp07Zf%2BxrOfJmWT2MORQs0RAQSLJV5nOFfRWTIPI4dSNhI3Q628XqklZ8%2BF1UktvA5vRdEU3LhDvOSsDCmL19k&X-Amz-Signature=7f876918ec5283db390a3037512e7ad62e434330ec3e406db18b25f25f3da0fe"
```

从Location下载部署包


```
PROF = "eu-central-1"

aws lambda create-function --function-name webdriver --runtime nodejs12.x --zip-file fileb:///home/ubuntu/webdriver.zip --handler index.handler  --role arn:aws:iam::762491489154:role/service-role/webdriver-role-3hxi35t5   --timeout 63 --memory-size 1024 --layers arn:aws:lambda:us-east-1:764866452798:layer:chrome-aws-lambda:25  --profile us
```
# 配置

`role-policy.json`

```
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
            "Service": ["lambda.amazonaws.com"]
    },
    "Action": "sts:AssumeRole"
    }
  ]
}
```


```
aws iam create-role --role-name lambda-s3 --assume-role-policy-document file://role-policy.json
aws iam attach-role-policy --role-name lambda-s3 --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
```

# 测试


```
export AWS_PROFILE=eu-south-1
aws lambda invoke --function-name webdriver --cli-binary-format raw-in-base64-out --payload '{"pageNo": 5}' out --log-type Tail --query 'LogResult' --output text |  base64 -d
```

# 调度

```
aws events put-rule --name webdriver-scheduled-rule --schedule-expression 'rate(30 minutes)' 


aws lambda add-permission --function-name webdriver --statement-id webdriver-scheduled-event --action 'lambda:InvokeFunction' --principal events.amazonaws.com --source-arn arn:aws:events:eu-central-1:762491489154:rule/webdriver-scheduled-rule


aws events put-targets --rule webdriver-scheduled-rule --targets file://targets.json
```

## 调整周期 

```
aws events put-rule --name webdriver-scheduled-rule --schedule-expression "rate(10 minutes)"
```

https://github.com/wubigo/API/blob/master/bash/put-rule.sh




# 自动

```
if [ -z "$1" ]
  then
    echo "No region supplied"
    exit 1
fi
export AWS_PROFILE=$1

FN=$(aws lambda create-function --function-name webdriver --runtime nodejs12.x --zip-file fileb:///home/ubuntu/webdriver.zip --handler index.handler  --role arn:aws:iam::762491:role/lambda-s3   --timeout 63 --memory-size 1024 --layers arn:aws:lambda:${AWS_PROFILE}:762491:layer:chrome-aws-lambda:25)
echo $FN

aws events put-rule --name webdriver-scheduled-rule --schedule-expression 'rate(30 minutes)'


EVENT=$(aws lambda add-permission --function-name webdriver --statement-id webdriver-scheduled-event --action 'lambda:InvokeFunction' --principal events.amazonaws.com --source-arn arn:aws:events:${AWS_PROFILE}:762491:rule/webdriver-scheduled-rule)
echo $EVENT

T=$(python3 targets.py ${AWS_PROFILE})
cat targets.json
aws events put-targets --rule webdriver-scheduled-rule --targets file://targets.json
sleep 5
awslogs streams /aws/lambda/webdriver
awslogs get /aws/lambda/webdriver --filter-pattern="[r=REPORT,...]"
```

# 禁止调用



```
 aws lambda put-function-concurrency --function-name webdriver --reserved-concurrent-executions 0
```

function cannot be invoked while the reserved concurrency is zero.

Calling the invoke API action failed with this message: Rate Exceeded.

# 并发配额重置

```
aws lambda delete-function-concurrency  --function-name webdriver
```

# 清理

```
aws lambda remove-permission --function-name webdriver --statement-id webdriver-scheduled-event
aws events list-targets-by-rule --rule webdriver-scheduled-rule
aws events remove-targets --rule  webdriver-scheduled-rule --ids 1
aws events delete-rule --name "webdriver-scheduled-rule"
```

