+++
title = "Server Side Rendering"
date = 2018-12-13T09:14:26+08:00
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


## Client Side Rendering(CSR)


Rendering an app in a browser, generally using the DOM

The initial HTML rendered by the server is a placeholder and 

the entire user interface and data rendered in the browser 

once all your scripts load.


### PROS

- Rich site interactions
- Fast rendering after the initial load
- Partial real-time updates
- Cheaper to host & scale

### CONS

- SEO and index issues
- Mostly initial bundle.js load duration
- Performance issues on old mobile devices/slow networks
- Social Media crawlers and sharing problems (SMO)

## Server Side Rendering(SSR)

Server rendering generates the full HTML for a page 

on the server in response to navigation


### PROS

- Consistent SEO
- Performance, initial page load
- Works well with Social Media crawlers and platforms (SMO)

### CONS

- Frequent requests
- Slow page rendering (TTFB — Time to first byte)
- Complex architecture (For universal approach)

