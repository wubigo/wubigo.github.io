+++
title = "微服务安全：认证，授权和审计(AAA)"
date = 2018-12-01T08:01:48+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["K8S", "SECURITY"]
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


# 微服务安全要点

- 通信链路加密
- 灵活的服务访问控制，包括细粒度访问策略
- 访问日志审计
- 服务提供方可替代性(batteries included)和可集成性

# 基本概念

- 安全标识

在K8S，安全标识(service account)代表一个用户，一个服务或一组服务。

- 安全命名

安全命名定义可运行服务的安全标识

# 微服务认证

- 传输层认证
- 终端用户认证

每一个终端请求通过JWT(JSON Web Token)校验, 支持Auth0, Firebase。

https://medium.facilelogin.com/securing-microservices-with-oauth-2-0-jwt-and-xacml-d03770a9a838





