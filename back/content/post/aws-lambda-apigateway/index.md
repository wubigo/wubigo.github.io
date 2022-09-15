+++
title = "Aws Lambda Apigateway"
date = 2018-10-26T14:49:57+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = []
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
 awslocal lambda add-permission --function-name ServerlessExample --action lambda:InvokeFunction --statement-id sns-topic --principal apigateway.amazonaws.com --source-arn "arn:aws:execute-api:us-east-1:123456789012:pmte6kdjb6/*/*"
```
