+++
title = "Web Test Automation in Lambda Way"
date = 2021-10-09T10:15:58+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["WEBDRIVER", "LAMBDA"]
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

# aws客户端环境准备

```
git clone 
pip install awscli https://github.com/wubigo/API.git
python API/python/aws/aws.py
cp API/python/aws/cred.json  ~/.aws/credentials
cp API/python/aws/config  ~/.aws/config

```

# 创建函数部署包

```
mkdir lambda_web
wget https://github.com/wubigo/API/blob/master/nodejs/lambda/aws/index.js -P lambda_web
zip -r  webdriver.zip lambda_web/*
```



# 配置


`policy.json`

```
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
            "Service": ["lambda.amazonaws.com", "s3.amazonaws.com"]
    },
    "Action": "sts:AssumeRole"
    }
  ]
}
```

```
export ACCOUNT_ID=820934811997 
aws iam create-role --role-name lambda-s3 --assume-role-policy-document file://policy.json
aws iam attach-role-policy --role-name lambda-s3 --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
aws iam attach-role-policy --role-name lambda-s3 --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
```

# 复制

```
aws lambda create-function --function-name webdriver --runtime nodejs12.x --zip-file fileb:///home/ubuntu/webdriver.zip --handler index.handler  --role arn:aws:iam::762491489154:role/service-role/webdriver-role-3hxi35t5   --timeout 63 --memory-size 1024 --layers arn:aws:lambda:us-east-1:764866452798:layer:chrome-aws-lambda:25  --profile us
```

# 调整默认配置（设置内存和超时时间）

函数计算的默认配置：  内存是128 MB， 超时是3秒。  

默认配置 pyppeteer无法正常工作。

```
aws lambda get-function --function-name webdriver
{
    "Configuration": {
        "FunctionName": "webdriver",
        "FunctionArn": "arn:aws:lambda:ap-northeast-1:762491489154:function:webdriver",
        "Runtime": "nodejs12.x",
        "Role": "arn:aws:iam::762491489154:role/service-role/webdriver-role-3hxi35t5",
        "Handler": "index.handler",
        "CodeSize": 598,
        "Description": "",
        "Timeout": 63,
        "MemorySize": 1024,
        "LastModified": "2021-10-08T09:44:02.000+0000",
        "CodeSha256": "Ma8ntxB5UxdLSOdotZBnSGDuBUDI+XEGlggfpPlV/AI=",
        "Version": "$LATEST",
        "TracingConfig": {
            "Mode": "PassThrough"
        },
        "RevisionId": "3c08812d-e958-4427-a47e-be628966be36",
        "Layers": [
            {
                "Arn": "arn:aws:lambda:ap-northeast-1:764866452798:layer:chrome-aws-lambda:25",
                "CodeSize": 51779390
            }
        ],

```


# 使用lambda  layer

https://github.com/shelfio/chrome-aws-lambda-layer

注意要使用相应分区

## 自定义函数服务层


```
git clone --depth=1 https://github.com/alixaxel/chrome-aws-lambda.git && \
cd chrome-aws-lambda && \
make chrome_aws_lambda.zip


aws lambda publish-layer-version --layer-name chrome_aws_lambda --zip-file fileb:///home/ubuntu/chrome-aws-lambda/chrome_aws_lambda.zip --compatible-runtimes nodejs12.x
   
```

# 函数定义

```
const chromium = require('chrome-aws-lambda');


function getRandomInt(max) {
  let r = Math.floor(Math.random() * max)
  if ( r <= 1 )
    r = 2
  return r;
}


exports.handler = async (event, context, callback) => {
  console.log("fn EVENT: \n" + JSON.stringify(event, null, 2))
  let e = JSON.parse(JSON.stringify(event, null, 2));
  let pageNo = e["pageNo"]
  if ( pageNo == null )
    pageNo = getRandomInt(17)
  console.log("pageNo="+pageNo);
  let result = null;
  let browser = null;

  try {
    
    let path = await chromium.executablePath;
    console.log("browser begin: "+ path+"\n" );
    browser = await chromium.puppeteer.launch({
      args: chromium.args,
      defaultViewport: chromium.defaultViewport,
      executablePath: await chromium.executablePath,
      headless: chromium.headless,
      ignoreHTTPSErrors: true,
    });
    
    let page = await browser.newPage();
    await page.setDefaultTimeout(0);

    await page.goto('https://wubigo.com/post/page/'+pageNo);
    console.log("go to wubigo");
    result = await page.title();
    console.log("title: " +result +"\n" );
    

    const page2 = await browser.newPage();
    await page2.setDefaultNavigationTimeout(0);
    const articles = await page.$$('h3.article-title');
    for (let i = 0; i < articles.length; i++) {
      const link = await articles[i].$eval('a', a => a.getAttribute('href'))
        .catch((e) => console.log('catch err: ' + e));
      console.log('link='+link);
      e["link"+i]=link;
      // await articles[i].click().catch((e) => console.log('err: ' + e));
      await page2.goto('https://wubigo.com/'+link);
      // await page.goBack();
      
    }
  } catch (error) {
    return callback(error);
  } finally {
    if (browser !== null) {
      await browser.close();
    }
  }
  result = JSON.stringify(e)
  return callback(null, result);
};

```


# 执行

```
aws lambda invoke --function-name webdriver --cli-binary-format raw-in-base64-out --payload '{"pageNo": 5}' response.json --profile us




aws lambda invoke --function-name webdriver --cli-binary-format raw-in-base64-out --payload '{"pageNo": 5}' out --log-type Tail --query 'LogResult' --output text --profile us |  base64 -d

```

# 检查结果

```
cat response.json
```


# EventBridge调度


```
aws events put-rule --name webdriver-scheduled-rule --schedule-expression 'rate(30 minutes)'


aws lambda add-permission --function-name webdriver --statement-id webdriver-scheduled-event --action 'lambda:InvokeFunction' --principal events.amazonaws.com --source-arn arn:aws:events:ap-northeast-1:762491489154:rule/webdriver-scheduled-rule


aws events put-targets --rule webdriver-scheduled-rule --targets file://targets.json
```


`targets.json`

```
[
    {
        "Id": "1",
        "Arn": "arn:aws:lambda:ap-northeast-1:762491489154:function:webdriver"
    }
]

```


# 检查调度结果

```
2021-10-21T09:55:56.099Z	397385df-555a-451a-9ba6-b9548438c797	INFO	fn EVENT: 
{
    "version": "0",
    "id": "8945024c-4594-df8a-74f3-9c98b0e75ed5",
    "detail-type": "Scheduled Event",
    "source": "aws.events",
    "account": "762491489154",
    "time": "2021-10-21T09:55:11Z",
    "region": "ap-northeast-1",
    "resources": [
        "arn:aws:events:ap-northeast-1:762491489154:rule/webdriver-scheduled-rule"
    ],
    "detail": {}
}


# 检查日志

`log-events.json`
```
{
 "logStreamName": "2021/10/21/[$LATEST]eae72f7f77124ab69d0a1fc398172cec",
 "logGroupName": "/aws/lambda/webdriver",
 "startFromHead": true
}

```



```
aws logs describe-log-streams --log-group-name /aws/lambda/webdriver --log-stream-name-prefix 2021/10/21

aws logs get-log-events --cli-input-json file://log-events.json
```