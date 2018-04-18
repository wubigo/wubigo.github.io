---
layout: post
title: Connecting to SSL services
date: 2018-03-07
tag: Java
---

# JDK Version

```
java -version
openjdk version "1.8.0_151"
OpenJDK Runtime Environment (build 1.8.0_151-8u151-b12-0ubuntu0.16.04.2-b12)
OpenJDK 64-Bit Server VM (build 25.151-b12, mixed mode)
```

# Verify that the target server is configured to serve SSL
[https://www.ssllabs.com/ssltest/](https://www.ssllabs.com/ssltest/)


# Connecting to SSL services
[https://confluence.atlassian.com/kb/unable-to-connect-to-ssl-services-due-to-pkix-path-building-failed-779355358.html](https://confluence.atlassian.com/kb/unable-to-connect-to-ssl-services-due-to-pkix-path-building-failed-779355358.html)

If you are getting an exception due to "Illegal key size" and you are using Sun’s JDK, you need to install the Java Cryptography Extension (JCE) Unlimited Strength Jurisdiction Policy Files.
See the following links for more information:

- [Java 6 JCE](http://www.oracle.com/technetwork/java/javase/downloads/jce-6-download-429243.html)

- [Java 7 JCE](http://www.oracle.com/technetwork/java/javase/downloads/jce-7-download-432124.html)

- [Java 8 JCE](http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html)

# Connecting to SSL Server from eclipse
Append the following to use keystore in eclipse tomcat server
```
-Djavax.net.ssl.trustStore="C:\Program Files\Java\jdk1.8.0_121\jre\lib\
security"
```

# check certificate name by alias then remove from keystore files

```
$keytool -list -v -keystore cacerts | grep 'Alias name:'

$sudo keytool -delete -alias wubigo  -keystore cacerts
```
