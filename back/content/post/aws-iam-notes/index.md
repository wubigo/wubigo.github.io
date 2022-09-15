+++
title = "Aws Iam Notes"
date = 2016-02-20T14:30:23+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["AWS","IAM"]
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


## REMOVE ROLE


delete policy before delete role


```
aws iam list-roles

aws iam list-role-policies --role-name api-executor

aws iam delete-role-policy --role-name api-executor -policy-name "log-writer"

aws iam delete-role --role-name pizza-api-executor
```


## ADD ROLE POLICY

```
aws iam put-role-policy \
--role-name pizza-api-executor \
--policy-name PizzaApiDynamoDB \
--policy-document file://./roles/dynamodb.json
```


You need to provide a path to dynamodb.json with the file:// prefix.
If you are providing an absolute path, keep in mind that you will have three
slashes after file:. The first two are for file://, and the third one is from the
absolute path, because it starts with a slash.