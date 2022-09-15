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

A single-file component consists of three parts:

```
- <template> which contains the component’s markup in plain HTML
- <script> which exports the component object constructor that consists of all the JS logic within
that component
- <style> which contains all the component styles
```

## CORE

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


## install vue-cli

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

## Vue props

Props are how the variables and other information pass around between different components. 

- Props are passed down the component tree to descendents (not up)
- Props are read-only and cannot be modified 

Vue uses one way data flow, meaning that data can only flow from a parent into a child component. 

And because that parent component "owns" that value it passed down, the child can't modify it.

For a child component to use the props provided to it, it needs to explictly declare the props it

receives with the props option

The v-bind directive is used to bind dynamic values (or objects) as props in a parent instance

The v-bind directive can be shortened with the : symbol:

```

// the full syntax
<img v-bind:src="prop1" />
// the shorthand syntax
<img :src="prop1" />


// the full syntax
<span v-on:click="func1(prop1)"></span>
// the shorthand syntax
<span @click="func1(prop1)"></span>

```
