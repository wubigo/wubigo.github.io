+++
title = "Spring Oauth2"
date = 2017-04-28T17:08:07+08:00
tags = ["SHELL", "MYSQL"]
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.

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

# 为什么要使用OIDC

只使用基本OAUTH2认证是不安全因为无法保证与用户的访问令牌是真实的。使用
OIDC可以做到这一点

https://security.stackexchange.com/questions/37818/why-use-openid-connect-instead-of-plain-oauth2/260519#260519


# hasRole

 a role is just an authority with a special ROLE_ prefix. So in Spring security 3 @PreAuthorize("hasRole('ROLE_XYZ')") is the same as @PreAuthorize("hasAuthority('ROLE_XYZ')") and in Spring security 4 @PreAuthorize("hasRole('XYZ')") is the same as @PreAuthorize("hasAuthority('ROLE_XYZ')").




http://localhost:8080/oauth/token


curl -u eagleeye:thisissecret -i -H 'Accept:application/json'  -d "grant_type=password&scope=webclient&username=will&password=pass" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://localhost:8080/oauth/token


![](./basic-auth.png)


![](./post-form.png)


# access protected resource

![](./res.png)



