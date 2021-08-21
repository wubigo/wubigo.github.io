+++
title = "YARN2 Note"
date = 2021-08-20T21:19:44+08:00
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

# 升级YARN

```
npm install -g yarn@1.22.11



> yarn@1.22.11 preinstall C:\local\node-v14.17.5-win-x64\node_modules\yarn
> :; (node ./preinstall.js > /dev/null 2>&1 || true)

C:\local\node-v14.17.5-win-x64\yarn -> C:\local\node-v14.17.5-win-x64\node_modules\yarn\bin\yarn.js
C:\local\node-v14.17.5-win-x64\yarnpkg -> C:\local\node-v14.17.5-win-x64\node_modules\yarn\bin\yarn.js
+ yarn@1.22.11
updated 1 package in 0.7s
```

# yarn link

`/home/ubuntu/.config/yarn/link/matrix-js-sdk`


```
ubuntu@ip-172-31-44-135:~/.config/yarn/link$ ll
total 8
drwxrwxr-x 2 ubuntu ubuntu 4096 Aug 19 09:31 ./
drwxrwxr-x 3 ubuntu ubuntu 4096 Aug 19 07:25 ../
lrwxrwxrwx 1 ubuntu ubuntu   22 Aug 19 09:31 matrix-js-sdk -> ../../../matrix-js-sdk/
lrwxrwxrwx 1 ubuntu ubuntu   25 Aug 19 07:25 matrix-react-sdk -> ../../../matrix-react-sdk/
```


# 创建应用

```
yarn create react-app matrix

yarn start
```


`C:\Users\bigo\AppData\Local\Yarn\Data\global\node_modules\.bin\create-react-app`

`/home/ubuntu/.config/yarn/global/node_modules/.bin/create-react-app`