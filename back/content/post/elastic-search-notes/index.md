+++
title = "Elastic Search Notes"
date = 2020-11-24T09:26:24+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["ES"]
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


“The act of storing data in Elasticsearch is called indexing, but before we can index a document, we need to decide where to store it”


“Relational DB  ⇒ Databases ⇒ Tables ⇒ Rows      ⇒ Columns
Elasticsearch  ⇒ Indices   ⇒ Types  ⇒ Documents ⇒ Fields”


“_index
Where the document lives

_type
The class of object that the document represents

_id
The unique identifier for the document”



Actually, in Elasticsearch, our data is stored and indexed in shards, while an index is just a logical namespace that groups together one or more shards. However, this is an internal detail; our application shouldn’t care about shards at all. As far as our application is concerned, our documents live in an index. Elasticsearch takes care of the details.


In a relational database, we usually store objects of the same class in the same table, because they share the same data structure. For the same reason, in Elasticsearch we use the same type for documents that represent the same class of thing, because they share the same data structure.
Every type has its own mapping or schema definition, which defines the data structure for documents of that type, much like the columns in a database table. Documents of all types can be stored in the same index, but the mapping for the type tells Elasticsearch how the data in each document should be indexed


An index is just a logical namespace that points to one or more physical shards.
A shard is a low-level worker unit that holds just a slice of all the data in the index


# reindex

create a new index with the new settings and copy all of your documents 

from the old index to the new index