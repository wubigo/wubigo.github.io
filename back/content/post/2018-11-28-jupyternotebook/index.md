---
layout: post
title: entry into jupyter notebook
date: 2018-11-23
tags: ["PYTHON"]
---

# generate configuration file
```
$jupyter notebook --generate-config
Writing default config to: /home/bigo/.jupyter/jupyter_notebook_config.py
$ diff jupyter_notebook_config.py jupyter_notebook_config.py.bak 
c.NotebookApp.allow_remote_access = True
c.NotebookApp.ip = '0.0.0.0'
c.NotebookApp.open_browser = False
```

# set or reset password

```
$jupyter notebook password
Enter password: 
Verify password: 
[NotebookPasswordApp] Wrote hashed password to /home/bigo/.jupyter/jupyter_notebook_config.json
```
then restart notebook server



# Sharing notebooks

When people talk of sharing their notebooks, there are generally two paradigms they may be considering. 
Most often, individuals share the end-result of their work which means 
sharing non-interactive, pre-rendered versions of their notebooks; however, it is also possible to collaborate 
on notebooks with the aid version control systems such as Git

# References
[https://www.dataquest.io/blog/jupyter-notebook-tutorial/](https://www.dataquest.io/blog/jupyter-notebook-tutorial/)



