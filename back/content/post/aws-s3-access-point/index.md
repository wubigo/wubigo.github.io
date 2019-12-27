+++
title = "Aws S3 Access Point"
date = 2019-12-04T22:20:38+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["AWS","S3"]
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
aws sts get-caller-identity

aws s3control list-access-points --account-id 46569194568

aws s3control create-access-point --name my-access-point --account-id 46569194568 --bucket wubigo

aws s3control get-access-point --account-id "46569194568" --name my-access-point
{
    "Name": "my-access-point",
    "PublicAccessBlockConfiguration": {
        "IgnorePublicAcls": true,
        "BlockPublicPolicy": true,
        "BlockPublicAcls": true,
        "RestrictPublicBuckets": true
    },
    "CreationDate": "2019-12-04T14:24:38Z",
    "Bucket": "wubigo",
    "NetworkOrigin": "Internet"
}

```


