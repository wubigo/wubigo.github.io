+++
title = "Vue notes"
date = 2018-04-25T12:02:41+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["WEB", "JS", "VUE"]
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

## Single File Components

single-file components with a .vue extension is build by tools 

such as Webpack or Browserify

# CORE

- Virtual DOM
- Component-based UI
- Focus on the view library—separate concerns for routing, state management
- Official component library for building mobile apps

```
D:\code\API\web>npm config list
; cli configs
metrics-registry = "https://registry.npmjs.org/"
scope = ""
user-agent = "npm/6.4.1 node/v10.15.3 win32 x64"
```


```
npm config set registry <registry url>
```


- install with another registry

```
npm install --registry=https://registry.npmjs.org/ 
```


# install vue-cli

```
npm install -g @vue/cli
```

```
vue create my-project
```
OR

```
vue ui
```
