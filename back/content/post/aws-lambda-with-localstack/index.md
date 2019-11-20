+++
title = "基于Localstack的本地Lambda开发"
date = 2018-09-29T09:39:28+08:00
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


# Create function

`index.js`

```
exports.handler = async function(event, context) {
  console.log("ENVIRONMENT VARIABLES\n" + JSON.stringify(process.env, null, 2))
  console.log("EVENT\n" + JSON.stringify(event, null, 2))
  return context.logStreamName
}
```

- 打包

```
zip function.zip index.js
```

```
aws lambda create-function --function-name my-function --zip-file fileb://function.zip --handler index.handler --runtime nodejs10.x --role arn:aws:iam::123456789012:role/lambda-cli-role --endpoint-url=http://localhost:4574
```


```
 aws lambda get-function --function-name my-function  --endpoint-url=http://localhost:4574
{
    "Code": {
        "Location": "http://localhost:4574/2015-03-31/functions/my-function/code"
    },
    "Configuration": {
        "TracingConfig": {
            "Mode": "PassThrough"
        },
        "Version": "$LATEST",
        "CodeSha256": "3d149vplmMjIEgZuPhQgnFJ+tndL4I9D11GL1qdgT6M=",
        "FunctionName": "my-function",
        "LastModified": "2019-09-29T01:16:43.752+0000",
        "RevisionId": "c79398c9-556b-4ed1-ad72-91332dd1f6e0",
        "CodeSize": 322,
        "FunctionArn": "arn:aws:lambda:us-east-1:000000000000:function:my-function",
        "Handler": "index.handler",
        "Role": "arn:aws:iam::123456789012:role/lambda-cli-role",
        "Timeout": 3,
        "Runtime": "nodejs10.x",
        "Description": ""
    }
}

```

- 验证调用

```
(venv) $aws lambda list-functions --endpoint-url=http://localhost:4574


(venv) $aws lambda invoke --function-name my-function out --log-type Tail --endpoint-url=http://localhost:4574
```


- 清理

```
aws lambda delete-function --function-name my-function --endpoint-url=http://localhost:4574
```