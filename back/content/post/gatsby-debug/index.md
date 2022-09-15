+++
title = "Gatsby Debug"
date = 2018-12-13T11:45:14+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["NODEJS","NODE","REACT"]
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

## Debugging the Build Process

Gatsby’s build and develop steps run as a Node.js application

which you can debug using standard tools for Node.js applications.

### Debugging with Node.js’ built-in console

```
console.log(args)
```

### VS Code Debugger (Auto-Config)

- Preferences: Type node debug into the search bar. Make sure the Auto Attach option is set to on.

- launch.json

`launch.json`

```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "type": "node",
            "request": "launch",
            "name": "Gatsby develop",
            "skipFiles": [
                "<node_internals>/**"
            ],
            "program": "D:/Downloads/node-v12.13.1-win-x64/node_modules/gatsby/dist/bin/gatsby",
            "args": ["develop"],
            "stopOnEntry": false,
            "runtimeArgs": ["--nolazy"],
            "sourceMaps": false
        }
    ]
}
```


After putting a breakpoint in gatsby-node.js and 

using the Start debugging command from VS Code you can see the final result



