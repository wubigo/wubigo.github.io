+++
title = "Blog on hugo way"
subtitle = "Learn how to blog with hugo"
summary = "Learn how to blog with hugo"
date = 2019-02-22T11:38:27+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["hugo"]
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

# setup for gitlab
```
tee .gitlab-ci.yml << EOF
image: monachus/hugo

variables:
  GIT_SUBMODULE_STRATEGY: recursive

pages:
  script:
  - hugo
  artifacts:
    paths:
    - public
  only:
  - master
EOF

git init
echo "/public" >> .gitignore  

```



# post

>hugo new post/<post_name>.md

# deploy

>hugo
publish the public to web server


# Configuration Lookup Order
1. ./config.toml
2. ./config.yaml
3. ./config.json

![](/img/post/hugo-logo-wide.svg)
 
