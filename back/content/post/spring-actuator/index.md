+++
title = "Spring Actuator"
date = 2018-04-28T17:08:07+08:00
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



# setup 

```
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
```


# enable web client


all endpoints are exposed to JMX and WEB clents

By default, all endpoints except for shutdown are enabled.


- enable all endpoings

- enable all endpoints accessed by web

```
management:
  endpoints:
    enabled-by-default: true
    web:
      exposure:
        include: "*"
```


https://docs.spring.io/spring-boot/docs/current/reference/html/production-ready-endpoints.html




# WebApplicationType
 
```

spring:
  main:
    web-application-type: reactive
```


- NONE

The application should not run as a web application and should not start an embedded web server.

- REACTIVE

The application should run as a reactive web application and should start an embedded reactive web server.

- SERVLET

The application should run as a servlet-based web application and should start an embedded servlet web server.
