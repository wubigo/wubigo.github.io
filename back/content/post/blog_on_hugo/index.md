+++
title = "Blog on hugo way"
subtitle = "Learn how to blog with hugo"
summary = "Decide to gave hugo a shot after many years of being jekyll"
date = 2019-02-22T11:38:27+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["BLOG"]
categories = ["IT"]

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

>hugo new post/<post_name>/index.md

# deploy

>hugo
publish the public to web server


# Configuration Lookup Order
`confit/_default/`

1. ./config.toml
2. ./config.yaml
3. ./config.json

`confit/_default/config.toml`

- hugo build destination

```
publishDir
```
- Number of items per page in paginated lists

```
paginate = 20  
```
- taxonomies

  + by tag
  + by author

```
tag = "tags"
author = "authors"
```

`confit/_default/menus.toml`

- Navigation Links widget enable/disabl under `content/home/` folder
- Navigation Links widget display order

```
weight = 1
```

`config/_default/languages.toml`

多语言显示

```
languageCode = "en-us"
languageCode = "zh-Hans"
```


# Blog set
`content/post/_index.md`

- post view as Card

```
view = 3
```
`content/home/posts.md`

- Number of recent posts to list.

```
count = 20
```



![](/img/post/hugo-logo-wide.svg)
 

# theme

https://sourcethemes.com/academic/zh/docs/page-builder/#icons