+++
title = "Nodejs异步通信之Promise"
date = 2017-12-21T07:35:31+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["NODE"]
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

## 与回调函数的区别

- 不用写错误条件`if (err) return callback(err)`
- Promise能被作为对象返回并被后期调用

- 回调

```
function successCallback(result) {
  console.log("Audio file ready at URL: " + result);
}

function failureCallback(error) {
  console.error("Error generating audio file: " + error);
}

createAudioFileAsync(audioSettings, successCallback, failureCallback);

```

- promise

```
const promise = createAudioFileAsync(audioSettings); 
promise.then(successCallback, failureCallback);
```

or

```
createAudioFileAsync(audioSettings).then(successCallback, failureCallback);
```




## 状态

Promise有三种状态

- pending: Initial Case where promise instantiated.
- fulfilled: Success Case which means promise resolved.
- rejected: Failure Case which means promise rejected.

## 方法

Promise有六个方法：

- Promise.all([promise1, promise2, …]);
- Promise.race([promise1, promise2, …]);
- Promise.reject(value);
- Promise.resolve(value);
- Promise.catch(onRejection);
- Promise.then(onFulFillment, onRejection);

    [API参考](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise#)

## 执行函数

- Executor Functions are Parameter for Promise Constructor which holds Resolve and Reject Callbacks.
- It is executed immediately by the Promise implementation which provides the resolve and reject functions.
- It’s Triggered before the Promise constructor even returns the created object.
- The Resolve and Reject functions are bound to the promise to fulfill or reject.
- It’s expected to initiate some asynchronous work and then, once that completes, call either the resolve or reject.

## 可以被覆盖的方法

- Promise.prototype.catch();
- Promise.prototype.then();


## 错误处理

Promise的两种错误处理方式：

- then方法的第二个参数onRejection回调
- catch 

```
'use strict';
// First Approach
yourPromise.catch(function (error) {
 // Your Error Callback
});
// Second Approach
yourPromise.then(undefined, function (error) {
 // Your Error Callback
});
```

错误检测：根据catch或onRejection定义的顺序被触发

```
'use strict';
Promise.catch(onRejected);
Promise.then(onFulfilled, onRejected);
```
