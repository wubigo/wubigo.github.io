+++
title = "基于local stack的Step Function本地化开发"
date = 2018-09-26T14:43:54+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["SERVERLESS", "LOCALSTACK"]
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

- 安装AWS CLI

```
(venv) d:\code\venv>pip install awscli

pip install awscli-local

```

**awslocal = aws --endpoint-url=http://localhost:<port>** 

可以安装到系统环境

- 配置AWS CLI

```
(venv) d:\code\venv>aws configure

AWS Access Key ID [None]: any-id-is-ok
AWS Secret Access Key [None]: fake-key
Default region name [local]: local
Default output format [None]:

```

命令行自动完成

```
$which aws_completer
~/code/venv/bin/aws_completer
```

```

tee ~/.bashrc <<-'EOF'
complete -C '~/code/venv/bin/aws_completer' aws
EOF

```


- 安装AWS SAM CLI

```
(venv) d:\code>pip install aws-sam-cli
(venv) d:\code>sam --version
SAM CLI, version 0.22.0
```

- 启动S3

```
(venv) d:\code>localstack\docker-compose up
```

- 创建bucket

```
(venv) d:\code>aws configure get region
local


(venv) d:\code>aws --endpoint-url=http://localhost:4572 s3 mb s3://demo-bucket
```

upload a file to bucket

```
(venv) d:\code>aws --endpoint-url=http://localhost:4572 s3 cp java0.log s3://demo-bucket
(venv) d:\code>aws --endpoint-url=http://localhost:4572 s3 ls s3://demo-bucket
```




Attach an ACL to the bucket so it is readable:

```
aws --endpoint-url=http://localhost:4572 s3api put-bucket-acl --bucket demo-bucket --acl public-read
```

- list object acl


```
 aws --endpoint-url=http://localhost:4572 s3api get-object-acl --bucket demo-bucket --key java0.log
{
    "Owner": {
        "DisplayName": "webfile",
        "ID": "75aa57f09aa0c8caeab4f8c24e99d10f8e7faeebf76c078efc7c6caea54ba06a"
    },
    "Grants": [
        {
            "Grantee": {
                "Type": "CanonicalUser",
                "ID": "75aa57f09aa0c8caeab4f8c24e99d10f8e7faeebf76c078efc7c6caea54ba06a"
            },
            "Permission": "FULL_CONTROL"
        }
    ]
}
```

- set object url and can be downloaded by public

```
aws --endpoint-url=http://localhost:4572 s3api put-object-acl --bucket demo-bucket --key java0.log  --acl public-read
 
aws --endpoint-url=http://localhost:4572 s3 presign s3://demo-bucket/java0.log

http://localhost:4572/demo-bucket/java0.log
```

display the names of all S3 buckets (across all regions)

```
(venv) d:\code>aws --endpoint-url=http://localhost:4572 s3api list-buckets --query "Buckets[].Name"

[
    "demo-bucket"
]



aws --endpoint-url=http://localhost:4572 s3api list-objects --bucket demo-bucket
{
    "Contents": [
        {
            "LastModified": "2019-09-29T10:17:02.386Z",
            "ETag": "\"d41d8cd98f00b204e9800998ecf8427e\"",
            "StorageClass": "STANDARD",
            "Key": "java0.log",
            "Owner": {
                "DisplayName": "webfile",
                "ID": "75aa57f09aa0c8caeab4f8c24e99d10f8e7faeebf76c078efc7c6caea54ba06a"
            },
            "Size": 0
        }
    ]
}

```

or specified region

```
(venv) d:\code>aws --endpoint-url=http://localhost:4572 --region local s3api list-buckets --query "Buckets[].Name"

[
    "demo-bucket"
]
```


- 下载样例程序

```
(venv) [code]$sam init --runtime python2.7

[+] Initializing project structure...

Project generated: ./sam-app

Steps you can take next within the project folder
===================================================
[*] Invoke Function: sam local invoke HelloWorldFunction --event event.json
[*] Start API Gateway locally: sam local start-api

Read sam-app/README.md for further instructions

```

- 本地调用

```
echo '{"message": "Hey, are you there?" }' | sam local invoke "HelloWorldFunction"
```


- 编译

```
(venv) [sam-app]$ cd sam-app && sam build

Build Succeeded

Built Artifacts  : .aws-sam/build
Built Template   : .aws-sam/build/template.yaml

Commands you can use next
=========================
[*] Invoke Function: sam local invoke
[*] Package: sam package --s3-bucket <yourbucket>

```

- 启动本地API网关

```
venv) [sam-app]$ sam local start-api

2019-09-27 10:18:10  * Running on http://127.0.0.1:3000/ (Press CTRL+C to quit)

```

```
$curl http://127.0.0.1:3000/hello

{"message": "hello world"}
```

- 启动lambda服务

```
(venv) [sam-app]$ sam local start-lambda
```

- 运行函数计算服务

```
aws --endpoint-url=http://localhost:4585 stepfunctions list-state-machines --region local

{
    "activities": []
}

```

```
aws stepfunctions --endpoint http://localhost:4585 create-state-machine --definition "{\
  \"Comment\": \"A Hello World example of the Amazon States Language using an AWS Lambda Local function\",\
  \"StartAt\": \"HelloWorld\",\
  \"States\": {\
    \"HelloWorld\": {\
      \"Type\": \"Task\",\
      \"Resource\": \"arn:aws:lambda:us-east-1:123456789012:function:HelloWorldFunction\",\
      \"End\": true\
    }\
  }\
}\
}}" --name "HelloWorld" --role-arn "arn:aws:iam::012345678901:role/DummyRole" --region local
```
aws --endpoint-url=http://localhost:4585 --lambda-endpoint http://localhost:3001