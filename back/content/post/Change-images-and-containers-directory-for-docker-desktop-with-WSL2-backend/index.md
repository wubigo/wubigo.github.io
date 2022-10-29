+++
title = "Change Images and Containers Directory for Docker Desktop With WSL2 Backend"
date = 2022-10-29T16:04:45+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["WSL", "DOCKER"]
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



# Quit docker-desktop


```
wsl --shutdown

```

# Export Docker Desktop data 

```
wsl --export docker-desktop-data D:\data.tar
wsl --unregister docker-desktop-data
```


# Import the exported data to your desired location 


```
wsl --import docker-desktop-data D:\wsl\docker-desktop-data  d:\data.tar --version 2
```

# restart docker-desktop

```
λ wsl -l -v
  NAME                   STATE           VERSION
* Ubuntu2                Running         2
  docker-desktop-data    Running         2
  docker-desktop         Running         2
```
