+++
title = "Data Lake Notes"
date = 2022-05-11T19:59:38+08:00
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



## three main use cases for metadata repositories:

- Finding data assets
For example, a data architect may want to know which tables in which databases
contain a Customer_ID.

- Tracking lineage (provenance)
Many regulations require enterprises to document the lineage of data assets—in
other words, where the data for those assets came from and how it was generated
or transformed.

- Impact analysis
If developers are making changes in a complex ecosystem, there is always a dan‐
ger of breaking something. Impact analysis allows developers to see all the data
assets that rely on a particular field or integration job before making a change

## Data governance 

tools record, document, and sometimes manage governance poli‐cies. The tools usually 
define who the data steward is for each data asset. Data stew‐
ards are responsible for making sure the data assets are correct, documenting their
purpose and lineage, and defining access and lifecycle management policies for them