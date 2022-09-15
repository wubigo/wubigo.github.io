+++
title = "Lambda Provisioned Concurrency"
date = 2019-12-08T11:01:06+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["LAMBDA","SERVERLESS"]
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

## Provisioned Concurrency for Lambda Functions


To provide customers with improved control over their mission-critical app performance on serverless, AWS introduces Provisioned Concurrency, which is a Lambda feature and works with any trigger. For example, you can use it with WebSockets APIs, GraphQL resolvers, or IoT Rules. This feature gives you more control when building serverless applications that require low latency, such as web and mobile apps, games, or any service that is part of a complex transaction.

This is a feature that keeps functions initialized and hyper-ready to respond in double-digit milliseconds. This addition is helpful for implementing interactive services, such as web and mobile backends, latency-sensitive microservices, or synchronous APIs.

On enabling Provisioned Concurrency for a function, the Lambda service will initialize the requested number of execution environments so they can be ready to respond to invocations.

To know more Provisioned Concurrency in detail, read the [Provisioned Concurrency for Lambda Functions](https://aws.amazon.com/blogs/aws/new-provisioned-concurrency-for-lambda-functions/)