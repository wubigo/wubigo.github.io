+++
title = "Leveldb Port in Java Dev"
date = 2018-02-19T18:32:37+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["KVS", "CACHE"]
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


# Windows开发环境


## 

```
[ERROR] src\main\java\org\iq80\leveldb\WriteOptions.java:[6] (regexp) RegexpMultiline: Line contains carriage return
[ERROR] src\main\java\org\iq80\leveldb\WriteOptions.java:[7] (regexp) RegexpMultiline: Line contains carriage return
```

https://github.com/wubigo/leveldb/blob/master/src/checkstyle/checks.xml

```
<module name="RegexpMultiline">
        <property name="format" value="\r"/>
        <property name="message" value="Line contains carriage return"/>
</module>
```


## change the settings on how to deal with line endings

git  3 options:

1. Checkout Windows-style, commit Unix-style

Git will convert LF to CRLF when checking out text files. When committing text files, CRLF will be converted to LF. For cross-platform projects, this is the recommended setting on Windows ("core.autocrlf" is set to "true")

2. Checkout as-is, commit Unix-style

Git will not perform any conversion when checking out text files. When committing text files, CRLF will be converted to LF. For cross-platform projects this is the recommended setting on Unix ("core.autocrlf" is set to "input").

3. Checkout as-is, commit as-is

Git will not perform any conversions when checking out or committing text files. Choosing this option is not recommended for cross-platform projects ("core.autocrlf" is set to "false")


```
git config --global core.autocrlf  false
```


```
git clone git@github.com:wubigo/leveldb.git
mvn package
```
