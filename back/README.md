# setup 

```
cmd\>hugo version
Hugo Static Site Generator v0.56.3
```


```
 git clone https://github.com/sourcethemes/academic-kickstart.git 
 cd academic-kickstart
 git submodule update --init --recursive
```

# View your new website:
    
    >hugo server -D

# 远程访问

```
hugo server -D --bind 0.0.0.0
```

#  Create a new post

    >hugo new post/<post-name>/index.md

# Create a new project

    >hugo new project/<project-name>/index.md