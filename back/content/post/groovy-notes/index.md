+++
title = "Groovy Notes"
date = 2018-04-28T17:08:07+08:00
tags = ["JAVA", "GROOVY"]
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.

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



- Allow more ways of creating objects using literals

- Introduce new datatypes together with their operators and expressions.



# Closure

simple abbreviated syntax of closures: after a method call, put code in braces with parameters delimited from the closure body by an arrow.

```
log = ''
(1..10).each{ log += it }
assert log == '12345678910'


log = ''
(1..10).each{ counter -> log += counter }
assert log == '12345678910'
```


A second way of declaring a closure is to 
directly assign it to a variable:

```
def printer = { line -> println line }
```


- a single parameter default name(it)

Similarly, if the closure needs to take only a single parameter
to work on, Groovy provides a default name—it—so that you don’t need to
declare it specifically

- Closures are Groovy’s way of providing transparent
callback targets as first-class citizens.