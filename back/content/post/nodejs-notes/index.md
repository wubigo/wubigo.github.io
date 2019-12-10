+++
title = "Nodejs Notes"
date = 2017-12-03T08:39:52+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["NODE","JS"]
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


## set registry

```
npm config set registry=http://registry.npm.taobao.org

npm config ls -l

userconfig = "C:\\Users\\Administrator\\.npmrc"
```


## declare variables

ES6 comes with two more options to declare your variables: const and let. In JavaScript ES6, you will

rarely find var anymore.

A variable declared with const cannot be re-assigned or re-declared. It cannot get mutated (changed,

modified)

Immutability is embraced in React and its ecosystem. That’s why const should be your default

choice when you define a variable.


## ES6 Arrow Functions


```
// function expression
function () { ... }
// arrow function expression
() => { ... }
```


You can remove the   parentheses when the function

gets only one argument, but have to keep them when 

it gets multiple arguments.


```
// allowed
item => { ... }
// allowed
(item) => { ... }


// not allowed
item, key => { ... }
// allowed
(item, key) => { ... }

```



Additionally, you can remove the block body, meaning the curly braces, of the ES6 arrow function.
In a concise body an implicit return is attached. Thus you can remove the return statement. That
will happen more often in the book, so be sure to understand the difference between a block body
and a concise body when using arrow functions


##  ES6 Object Initializer

you are allowed to use computed property names in JavaScript ES6

```
// ES6
const key = 'name';
const user = {
  \[key]: 'Robin',
};
```
