+++
title = "函数计算VPC支持更新"
date = 2019-12-30T06:33:49+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["SERVERLESS", "SLS"]
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

## IN VPC


![](/img/post/lambda-vpc.png)*更新前VPC*



![](/img/post/lambda-vpc-nat.png)*更新后VPC*


While Hyperplane still uses a cross account network interface, it provides the following benefits for Lambda within a VPC:

- Reduced latency when a function is invoked by using pre-created network interfaces. The network interface is created when the Lambda function is initially created.
- Network interfaces are shared across functions with the same security group:subnet combination
- Function scaling is no longer bound to the number of network interfaces


While the new changes make it more conducive for developers to connect Lambda functions to VPCs, the basic architecture doesn’t change in terms of your VPC.

- Your Lambda functions still need the IAM permissions required to create and delete network interfaces in your VPC.
- You still control the subnet and security group configurations of these network interfaces. You can continue to apply normal network security controls and follow best practices on VPC configuration.
- You still have to use a NAT device(for example VPC NAT Gateway) to give a function internet access or use VPC endpoints to connect to services outside of your VPC.
- Nothing changes about the types of resources that your functions can access inside of your VPCs.


## 参考

https://lumigo.io/blog/to-vpc-or-not-to-vpc-in-aws-lambda/

https://medium.com/@emaildelivery/serverless-pitfalls-issues-you-may-encounter-running-a-start-up-on-aws-lambda-f242b404f41c

https://aws.amazon.com/blogs/compute/announcing-improved-vpc-networking-for-aws-lambda-functions/