+++
title = "Nodejs Xpath名字空间"
date = 2018-02-21T15:45:05+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["NODE", "XML"]
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

如果xml文件带有名字空间，XPATH支持

还不够完善。下面介绍两种可以工作的方式


## namespace for XML documents


```
http.get("https://wubigo.com/en/sitemap.xml", function(res) {    
```

### useNamespaces

```
const select = xpath.useNamespaces({"ns0": "http://www.sitemaps.org/schemas/sitemap/0.9"});
const nodes = select("//ns0:loc", doc);
nodes.forEach((value) => console.log("ns0:"+value));
```


### Implementing a Default Namespace Resolver


```
const nsResolver = function nsResolver(prefix) {
    const ns = {
        'ns0' : 'http://www.sitemaps.org/schemas/sitemap/0.9',
        'mathml': 'http://www.w3.org/1998/Math/MathML'
    };
    return ns[prefix] || null;
};
nsResolver.lookupNamespaceURI = nsResolver;


var result = xpath.evaluate(
            "//ns0:loc",            // xpathExpression
            doc,                        // contextNode
            nsResolver,                       // namespaceResolver
            xpath.XPathResult.ANY_TYPE, // resultType
            null                        // result
        )
         
node = result.iterateNext();
while (node) {
            console.log("url="+node.toString());
            node = result.iterateNext();
}

```


