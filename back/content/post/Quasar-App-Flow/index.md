+++
title = "Quasar App Flow"
date = 2021-10-28T15:53:54+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["VUE"]
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



# CQuasar App Flow

In order to better understand how a boot file works and what it does, you need to understand how your website/app boots:


Quasar is initialized (components, directives, plugins, Quasar i18n, Quasar icon sets)
Quasar Extras get imported (Roboto font – if used, icons, animations, …)
Quasar CSS & your app’s global CSS are imported
App.vue is loaded (not yet being used)
Store is imported (if using Vuex Store in src/store)
Router is imported (in src/router)
Boot files are imported
Router default export function executed
Boot files get their default export function executed
(if on Electron mode) Electron is imported and injected into Vue prototype
(if on Cordova mode) Listening for “deviceready” event and only then continuing with following steps
Instantiating Vue with root component and attaching to DOM


# Vue组件脚手架

```
quasar new --list
quasar new [type] <name of your component with optional subfolder>
```

创建组件
```
quasar new component com1
quasar new page page1

```

## 组件类型
layout, page, component , boot, store