+++
title = "Lang Java Spring Boot V2"
date = 2018-04-11T08:48:18+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["JAVA","LANG"]
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

# JVM bind with IPv4


Disable IPv6 address lookups when -Djava.net.preferIPv4Stack=true

```
-Djava.net.preferIPv4Stack=true
```

# Spring Boot Actuator

```
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```

 
Actuator comes with most endpoints disabled.
Thus, the only two available by default are /health and /info.

```
management.endpoints.web.exposure.include=*
```

by default, all Actuator endpoints are now placed under the /actuator path


```
mvn dependency:tree

[INFO] +- org.springframework.boot:spring-boot-starter-data-jpa:jar:2.1.4.RELEASE:compile
[INFO] |  +- org.springframework.boot:spring-boot-starter-aop:jar:2.1.4.RELEASE:compile
[INFO] |  |  +- org.springframework:spring-aop:jar:5.1.6.RELEASE:compile
[INFO] |  |  \- org.aspectj:aspectjweaver:jar:1.9.2:compile
[INFO] |  +- org.springframework.boot:spring-boot-starter-jdbc:jar:2.1.4.RELEASE:compile
[INFO] |  |  +- com.zaxxer:HikariCP:jar:3.2.0:compile
[INFO] |  |  \- org.springframework:spring-jdbc:jar:5.1.6.RELEASE:compile
[INFO] |  +- javax.transaction:javax.transaction-api:jar:1.3:compile
[INFO] |  +- javax.xml.bind:jaxb-api:jar:2.3.1:compile
[INFO] |  |  \- javax.activation:javax.activation-api:jar:1.2.0:compile
[INFO] |  +- org.hibernate:hibernate-core:jar:5.3.9.Final:compile
[INFO] |  |  +- org.jboss.logging:jboss-logging:jar:3.3.2.Final:compile
[INFO] |  |  +- javax.persistence:javax.persistence-api:jar:2.2:compile
[INFO] |  |  +- org.javassist:javassist:jar:3.23.1-GA:compile
[INFO] |  |  +- net.bytebuddy:byte-buddy:jar:1.9.12:compile
[INFO] |  |  +- antlr:antlr:jar:2.7.7:compile
[INFO] |  |  +- org.jboss:jandex:jar:2.0.5.Final:compile
[INFO] |  |  +- com.fasterxml:classmate:jar:1.4.0:compile
[INFO] |  |  +- org.dom4j:dom4j:jar:2.1.1:compile
[INFO] |  |  \- org.hibernate.common:hibernate-commons-annotations:jar:5.0.4.Final:compile
[INFO] |  +- org.springframework.data:spring-data-jpa:jar:2.1.6.RELEASE:compile
[INFO] |  |  +- org.springframework.data:spring-data-commons:jar:2.1.6.RELEASE:compile
[INFO] |  |  +- org.springframework:spring-orm:jar:5.1.6.RELEASE:compile
[INFO] |  |  +- org.springframework:spring-context:jar:5.1.6.RELEASE:compile
[INFO] |  |  +- org.springframework:spring-tx:jar:5.1.6.RELEASE:compile
[INFO] |  |  +- org.springframework:spring-beans:jar:5.1.6.RELEASE:compile
[INFO] |  |  \- org.slf4j:slf4j-api:jar:1.7.26:compile
[INFO] |  \- org.springframework:spring-aspects:jar:5.1.6.RELEASE:compile
[INFO] +- org.springframework.boot:spring-boot-starter-thymeleaf:jar:2.1.4.RELEASE:compile
[INFO] |  +- org.springframework.boot:spring-boot-starter:jar:2.1.4.RELEASE:compile
[INFO] |  |  +- org.springframework.boot:spring-boot:jar:2.1.4.RELEASE:compile
[INFO] |  |  +- org.springframework.boot:spring-boot-autoconfigure:jar:2.1.4.RELEASE:compile
[INFO] |  |  +- org.springframework.boot:spring-boot-starter-logging:jar:2.1.4.RELEASE:compile
[INFO] |  |  |  +- ch.qos.logback:logback-classic:jar:1.2.3:compile
[INFO] |  |  |  |  \- ch.qos.logback:logback-core:jar:1.2.3:compile
[INFO] |  |  |  +- org.apache.logging.log4j:log4j-to-slf4j:jar:2.11.2:compile
[INFO] |  |  |  |  \- org.apache.logging.log4j:log4j-api:jar:2.11.2:compile
[INFO] |  |  |  \- org.slf4j:jul-to-slf4j:jar:1.7.26:compile
[INFO] |  |  +- javax.annotation:javax.annotation-api:jar:1.3.2:compile
[INFO] |  |  \- org.yaml:snakeyaml:jar:1.23:runtime
[INFO] |  +- org.thymeleaf:thymeleaf-spring5:jar:3.0.11.RELEASE:compile
[INFO] |  |  \- org.thymeleaf:thymeleaf:jar:3.0.11.RELEASE:compile
[INFO] |  |     +- org.attoparser:attoparser:jar:2.0.5.RELEASE:compile
[INFO] |  |     \- org.unbescape:unbescape:jar:1.1.6.RELEASE:compile
[INFO] |  \- org.thymeleaf.extras:thymeleaf-extras-java8time:jar:3.0.4.RELEASE:compile
[INFO] +- org.springframework.boot:spring-boot-starter-web:jar:2.1.4.RELEASE:compile
[INFO] |  +- org.springframework.boot:spring-boot-starter-json:jar:2.1.4.RELEASE:compile
[INFO] |  |  +- com.fasterxml.jackson.core:jackson-databind:jar:2.9.8:compile
[INFO] |  |  |  +- com.fasterxml.jackson.core:jackson-annotations:jar:2.9.0:compile
[INFO] |  |  |  \- com.fasterxml.jackson.core:jackson-core:jar:2.9.8:compile
[INFO] |  |  +- com.fasterxml.jackson.datatype:jackson-datatype-jdk8:jar:2.9.8:compile
[INFO] |  |  +- com.fasterxml.jackson.datatype:jackson-datatype-jsr310:jar:2.9.8:compile
[INFO] |  |  \- com.fasterxml.jackson.module:jackson-module-parameter-names:jar:2.9.8:compile
[INFO] |  +- org.springframework.boot:spring-boot-starter-tomcat:jar:2.1.4.RELEASE:compile
[INFO] |  |  +- org.apache.tomcat.embed:tomcat-embed-core:jar:9.0.17:compile
[INFO] |  |  +- org.apache.tomcat.embed:tomcat-embed-el:jar:9.0.17:compile
[INFO] |  |  \- org.apache.tomcat.embed:tomcat-embed-websocket:jar:9.0.17:compile
[INFO] |  +- org.hibernate.validator:hibernate-validator:jar:6.0.16.Final:compile
[INFO] |  |  \- javax.validation:validation-api:jar:2.0.1.Final:compile
[INFO] |  +- org.springframework:spring-web:jar:5.1.6.RELEASE:compile
[INFO] |  \- org.springframework:spring-webmvc:jar:5.1.6.RELEASE:compile
[INFO] |     \- org.springframework:spring-expression:jar:5.1.6.RELEASE:compile
[INFO] +- com.h2database:h2:jar:1.4.199:runtime
[INFO] \- org.springframework.boot:spring-boot-starter-test:jar:2.1.4.RELEASE:test
[INFO]    +- org.springframework.boot:spring-boot-test:jar:2.1.4.RELEASE:test
[INFO]    +- org.springframework.boot:spring-boot-test-autoconfigure:jar:2.1.4.RELEASE:test
[INFO]    +- com.jayway.jsonpath:json-path:jar:2.4.0:test
[INFO]    |  \- net.minidev:json-smart:jar:2.3:test
[INFO]    |     \- net.minidev:accessors-smart:jar:1.2:test
[INFO]    |        \- org.ow2.asm:asm:jar:5.0.4:test
[INFO]    +- junit:junit:jar:4.12:test
[INFO]    +- org.assertj:assertj-core:jar:3.11.1:test
[INFO]    +- org.mockito:mockito-core:jar:2.23.4:test
[INFO]    |  +- net.bytebuddy:byte-buddy-agent:jar:1.9.12:test
[INFO]    |  \- org.objenesis:objenesis:jar:2.6:test
[INFO]    +- org.hamcrest:hamcrest-core:jar:1.3:test
[INFO]    +- org.hamcrest:hamcrest-library:jar:1.3:test
[INFO]    +- org.skyscreamer:jsonassert:jar:1.5.0:test
[INFO]    |  \- com.vaadin.external.google:android-json:jar:0.0.20131108.vaadin1:test
[INFO]    +- org.springframework:spring-core:jar:5.1.6.RELEASE:compile
[INFO]    |  \- org.springframework:spring-jcl:jar:5.1.6.RELEASE:compile
[INFO]    +- org.springframework:spring-test:jar:5.1.6.RELEASE:test
[INFO]    \- org.xmlunit:xmlunit-core:jar:2.6.2:test

```