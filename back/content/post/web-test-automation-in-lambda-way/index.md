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


# 调整默认配置（设置内存和超时时间）

函数计算的模式内存是128 MB， 超时是3秒。  默认配置

pyppeteer无法正常工作。

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


# 函数定义

```
const chromium = require('chrome-aws-lambda');

exports.handler = async (event, context, callback) => {
  console.log("fn EVENT: \n" + JSON.stringify(event, null, 2))
  let e = JSON.parse(JSON.stringify(event, null, 2));
  let pageNo = e["pageNo"]
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

# 复制

```
aws lambda create-function --function-name webdriver --runtime nodejs12.x --zip-file fileb:///home/ubuntu/webdriver.zip --handler index.handler  --role arn:aws:iam::762491489154:role/service-role/webdriver-role-3hxi35t5   --timeout 63 --memory-size 1024 --layers arn:aws:lambda:us-east-1:764866452798:layer:chrome-aws-lambda:25  --profile us
```

# 执行

```
aws lambda invoke --function-name webdriver --cli-binary-format raw-in-base64-out --payload '{"pageNo": 5}' response.json --profile us

```

# 检查结果

```
cat response.json
```


