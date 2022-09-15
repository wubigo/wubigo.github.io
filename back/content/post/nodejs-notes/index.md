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

## Bindings

class methods don’t

automatically bind this to the class instance

That’s a main source of bugs when using React, because if you want to access

this.state in your class method, it cannot be retrieved because this is undefined. So in order to

make this accessible in your class methods, you have to bind the class methods to this.

class methods can be autobound automatically without

binding them explicitly by using JavaScript ES6 arrow functions

```
class A { 
    constructor() {
        this.foo = this.foo.bind(this)
    }

    foo() {
        console.log('foo from A')
    }
}





class A {
    foo = () => {
        console.log('foo from A')
    }
}
```


The official React documentation sticks to the class method bindings in the constructor


## EXPORT default statement

- to export and import a single functionality
- to highlight the main functionality of the exported API of a module
- to have a fallback import functionality


```
const robin = {
    firstname: 'robin',
    lastname: 'wieruch',
};
export default robin;
```

Furthermore, the import name can differ from the exported default name


## Asynchronous code execution

Because most of the JavaScript runtimes are single-threaded, many longer operations,
such as network requests, are executed asynchronously. Asynchronous code execution
is handled by two known concepts: callbacks and promises.

- promises 

        A promise represents an eventual result of an asynchronous operation

        Promises are just pretty wrappers around callbacks. In real-world situations, you
        wrap a promise around a certain action or operation. A promise can have two possible
        outcomes: it can be resolved (fulfilled) or rejected (unfulfilled).


##  enable "TypeScript and JavaScript Language Features" extension in VS Code

Go to extensions and search `@builtin typescript` to find the extension



## uuid

The fastest possible way to create random 32-char string in Node 

is by using native crypto module(no external dependency is needed):

```
const randomBytes = require('crypto').randomBytes;
const uuid = randomBytes(16).toString("hex");
```
