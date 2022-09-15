+++
title = "Aws Apigateway Notes"
date = 2017-11-23T20:52:46+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = []
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


## create rest api resource

```
awslocal apigateway create-rest-api --name 'My First API' --description 'This is my first API'
```

```
awslocal apigateway get-rest-apis                                         {
    "items": [
        {
            "createdDate": 1574513755,
            "id": "tjc336382o",
            "name": "hello_api2"
        },
        {
            "description": "This is my first API",
            "createdDate": 1574513755,
            "id": "foyylqv018",
            "name": "My First API"
        }
    ]
}

```