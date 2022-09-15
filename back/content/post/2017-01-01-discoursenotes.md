---
layout: post
title: discourse notes
date: 2017-01-01
tag: tools
---

# discourse-setup

 discourse-setup script does, more-or-less, is just copy samples/standalone.yml to containers/app.yml and edit a bunch of stuff in response to the answers to a bunch of questions
```
$cp samples/standalone.yml containers/app.yml
```

Discourse app.yml AWS setup example

[Discourse app.yml AWS setup](https://gist.github.com/stroupaloop/7fa3cab406423da02d02)

 [how-to-specify-a-different-port-not-80-during-install](https://meta.discourse.org/t/how-to-specify-a-different-port-not-80-during-installation/47859)

  fix these settings after bootstrapping, edit the /containers/app.yml
  then rebuild to take effect
```
./launcher rebuild app
```
