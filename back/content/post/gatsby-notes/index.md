+++
title = "Gatsby Notes"
date = 2018-09-03T09:03:37+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["NODE","JS"]
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

## bind eip

```
gatsby develop -- --host=0.0.0.0
```

## Prettier VS Code plugin

## JSX

The hybrid “HTML-in-JS” is actually a syntax extension

of JavaScript, for React, called JSX


In pure JavaScript, it looks more like this:

`src/pages/index.js`

```
import React from "react"
export default () => React.createElement("div", null, "Hello world!")
```

Now you can spot the use of the 'react' import! But wait. You’re writing JSX, not pure HTML and 

JavaScript. How does the browser read that? The short answer: It doesn’t. Gatsby sites come with 

tooling already set up to convert your source code into something that browsers can interpret.


## default plugins

```
query MyQuery {
  allSitePlugin {
    totalCount
    edges {
      node {
        name
        browserAPIs
        pluginFilepath
        version
        resolve
        pluginOptions {
          name
          path
        }
      }
    }
  }
}
```

## implement an API


[API](https://www.gatsbyjs.org/docs/node-apis/)

To implement an API, export a function with the name of the API 

gatsby-node.js

```
exports.onCreateNode = ({ node }) => {
  console.log(node.internal.type)
}
```


This onCreateNode function will be called by Gatsby whenever a new node is created (or updated).


## GraphQL Playground

```
GATSBY_GRAPHQL_IDE=playground gatsby develop


View the GraphQL Playground, an in-browser IDE, to explore your site's data and schema
⠀
  http://localhost:8000/___graphql


```

The GATSBY_GRAPHQL_IDE=playground part of this command is optional.

Adding it enables the GraphQL Playground instead of GraphiQL,

which is an older interface for exploring GraphQL.


## GraphQL query template

 All context values are made available to a template’s GraphQL queries 
 
 as arguments prefaced with $


 ```
 exports.createPages = async function({ actions, graphql }) {
  const { data } = await graphql(`
    query {
      allMarkdownRemark {
        edges {
          node {
            fields {
              slug
            }
          }
        }
      }
    }
  `)
  data.allMarkdownRemark.edges.forEach(edge => {
    const slug = edge.node.fields.slug
    actions.createPage({
      path: slug,
      component: require.resolve(`./src/templates/blog-post.js`),
      context: { slug: slug },
    })
  })
}

```

## Server-side environment variables

`gatsby-config.js` or `gatsby-node.js`:

```

require("dotenv").config({
  path: `.env.${process.env.NODE_ENV}`,
})

```


`.env.development`

```
GATSBY_GRAPHQL_IDE=playground
```

## MDX

After installing gatsby-plugin-mdx, MDX files located in src/pages will turn into pages.

Pages are rendered at a URL that is constructed from the filesystem path inside src/pages.

An MDX file at src/pages/awesome.mdx will result in a page being rendered at mysite.com/awesome


## FAQ

- There are multiple modules with names that only differ in casing(WIN)

Potential solutions:

```
cd C:\gatsby\dir before starting gatsby, specifying uppercase

Use powershell instead of cmd (powershell will redirect to the correct dir and set the env var correctly)

Use UNIX file paths and let Windows figure it out (cd /gatsby/dir instead of cd c:\gatsby\dir), but note this will only help if you always use UNIX paths for shell navigation; if you're already in the bogus dir, cmd will not handle it properly.

Gatsby could always enforce/assume uppercase drive letters when checking paths
```


```
d:\code\hello-world>gatsby -v
Gatsby CLI version: 2.8.18
Gatsby version: 2.18.8
```


