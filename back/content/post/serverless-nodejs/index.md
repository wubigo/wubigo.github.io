+++
title = "函数计算Nodejs实例"
date = 2018-12-15T22:54:39+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["AWS","SLS","CLOUD","NODE","SERVERLESS"]
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


## restore snapshot shell

`snapshot.sh`

```
!#/bin/bash


wget https://nodejs.org/dist/v12.13.1/node-v12.13.1-linux-x64.tar.xz

tar xvf node-v12.13.1-linux-x64.tar.xz

export PATH=/home/ubuntu/node-v12.13.1-linux-x64/bin:$PATH


wget https://manning-content.s3.amazonaws.com/download/0/ddbbd36-251d-42ef-9934-55e5a881a336/FinalSourceCode.zip


sudo apt update
sudo apt install unzip

unzip FinalSourceCode.zip

mv Final\ Source\ Code/ sls


sudo apt install python-pip

pip install awscli

which aws_completer

cp ~/.bashrc ~/.bashrc_orig

tee -a ~/.bashrc <<-'EOF'
complete -C '/home/ubuntu/.local/bin/aws_completer' aws
export PATH=/home/ubuntu/node-v12.13.1-linux-x64/bin:$PATH
EOF

```



```
aws configure

npm install claudia -g

claudia -v
5.11.0


cd chapter-03

npm install

claudia create \
--region ap-northeast-1 \
--api-module api


packaging files npm install -q --no-audit --production
npm WARN pizza-api@1.0.0 No repository field.

saving configuration
{
  "lambda": {
    "role": "pizza-api-executor",
    "name": "pizza-api",
    "region": "ap-northeast-1"
  },
  "api": {
    "id": "4auh8wzh16",
    "module": "api",
    "url": "https://4auh8wzh16.execute-api.ap-northeast-1.amazonaws.com/latest"
  }
}

```


## IAM policy to that allows Lambda function to communicate with database 


```

aws iam put-role-policy \
> --role-name pizza-api-executor \
> --policy-name PizzaApiDynamoDB \
> --policy-document file://./roles/dynamodb.json

```

`package.json`

```
"dependencies": {
    "claudia-api-builder": "^4.1.2"
},
```


```
aws apigateway get-resources --rest-api-id "4auh8wzh16"

 {
            "path": "/pizzas/{id}",
            "resourceMethods": {
                "OPTIONS": {},
                "GET": {}
            },
            "id": "i9rknj",
            "pathPart": "{id}",
            "parentId": "el67kl"
}

```

```
claudia update

updating REST API       apigateway.setAcceptHeader
{
  "FunctionName": "pizza-api",
  "FunctionArn": "arn:aws:lambda:ap-northeast-1:465691908928:function:pizza-api:2",
  "Runtime": "nodejs12.x",
  "Role": "arn:aws:iam::465691908928:role/pizza-api-executor",
  "Handler": "api.proxyRouter",
  "CodeSize": 17910,
  "Description": "A pizza API, an example app from \"Serverless applications with Claudia.js\"",
  "Timeout": 3,
  "MemorySize": 128,
  "LastModified": "2019-12-16T02:01:14.766+0000",
  "CodeSha256": "RDF1eXIMV2PKlTQZt9uUSayhdREMECZzTQaP92WWCqg=",
  "Version": "2",
  "KMSKeyArn": null,
  "TracingConfig": {
    "Mode": "PassThrough"
  },
  "MasterArn": null,
  "RevisionId": "d0e645d2-86e5-44b2-b20c-f95526be2094",
  "State": "Active",
  "StateReason": null,
  "StateReasonCode": null,
  "LastUpdateStatus": "Successful",
  "LastUpdateStatusReason": null,
  "LastUpdateStatusReasonCode": null,
  "url": "https://4auh8wzh16.execute-api.ap-northeast-1.amazonaws.com/latest"
}

```

![](/img/serverless-node-packaging.png)



