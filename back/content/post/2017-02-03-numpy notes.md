---
layout: post
title: numpy notes
date: 2017-01-03
tag: [python, scipy, numpy]
---

# along an axis
Axes are defined for arrays with more than one dimension. A 2-dimensional 
array has two corresponding axes: the first running vertically downwards 
across rows (axis 0), and the second running horizontally across columns (axis 1)
```
>>>print np.arange(12)
>>>print np.arange(12).reshape(3, 4)
>>>print np.arange(12).reshape(3, 4).mean(axis=1)
>>>print np.arange(12).reshape(3, 4).mean(axis=0)
```