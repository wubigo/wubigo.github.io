+++
title = "Spring Gateway"
date = 2017-04-28T17:08:07+08:00
tags = ["SPRING", "MICROSERVICE"]
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



```
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-zuul</artifactId>
</dependency>
```


# gateway with routing

`@EnableZuulServer` is used
when you want to build your own routing service and not use any Zuul prebuilt
capabilities. An example of this would be if you wanted to use Zuul to
integrate with a service discovery engine other than Eureka (for example,
Consul). We’ll only use the `@EnableZuulServer` annotation in this book.



The Zuul proxy server is designed by default to work on the Spring products. As such,
Zuul will automatically use Eureka to look up services by their service IDs and then use
Netflix Ribbon to do client-side load balancing of requests from within Zuul.