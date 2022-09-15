+++
title = "Monitoring notes"
date = 2018-05-20T17:23:01+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["MONITORING", "DEVOPS"]
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

## Container

When working with cloud native solutions such as Kubernetes, resources are volatile. Services come and go by design, and that’s fine—as long as the whole system operates in a regular way. Classical monitoring solutions aren’t always able to handle this transience gracefully

## Graphite

Graphite has no direct data collection support. Carbon listens passively for data, but in order to enable data collection, you should include solutions like fluentd, statd, collectd, or others in your time series data pipeline. Once collected, Graphite has a built-in UI with which to visualize data.

Prometheus, on the other hand, is a complete monitoring solution, which includes built-in collection, along with storage, visualization, and exporting.


If you want a clustered solution that can hold historical data of any sort long term, Graphite may be a better choice due to its simplicity and long history of doing exactly that. Graphite also has rollup of data built in. Similarly, Graphite may be preferred if your existing infrastructure already uses collection tools like fluentd, collectd, or statd, because Graphite supports them.

## metric vs log

subsystems in your applications, making it easier to determine what exactly is causing
a slowdown. Logs could not record that many fields, but once you know which sub‐
system is to blame, logs can help you figure out which exact user requests are
involved.
This is where the tradeoff between logs and metrics becomes most apparent. Metrics
allow you to collect information about events from all over your process, but with
generally no more than one or two fields of context with bounded cardinality. Logs
allow you to collect information about all of one type of event, but can only track a
hundred fields of context with unbounded cardinality. This notion of cardinality and
the limits it places on metrics is important to understand, and I will come back to it
in later chapters.