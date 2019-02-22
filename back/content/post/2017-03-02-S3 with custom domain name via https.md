---
layout: post
title: S3 access with custom domain name via https
date: 2017-03-02
tag: IaaS
---

# Getting an SSL Certificate and CloudFront

# Create CloudFront Distribution

Navigate to CloudFront in your AWS console and click "Create Distribution". Click "Get Started" under the Web option (not the RTMP). You'll arrive on the Create Distribution page. Here you need to change three things:
1. Click inside the input field for "Origin Domain Name". A list of your Amazon S3 buckets should pop up. Select the S3 bucket you want to use.
2. Scroll to the "Alternate Domain Names (CNAMEs)" field and enter your domain/subdomain you're using
3. Scroll down to SSL Certificate and change the option to "Custom SSL Certificate", then select the certificate you just created in the drop-down list. Scroll the rest of the way down and click "Create Distribution".

# Change Distribution CNAME
