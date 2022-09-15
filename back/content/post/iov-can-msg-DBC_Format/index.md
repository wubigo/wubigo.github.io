+++
title = "CAN总线消息格式DBC_Format"
date = 2022-05-22T16:30:53+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["IOT", "CAN"]
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

# CAN消息总线格式

## DBC格式


```
BO_ 500 IO_DEBUG: 4 IO
 SG_ IO_DEBUG_test_unsigned : 0|8@1+ (1,0) [0|0] "" DBG
```

说明：

- The message name is IO_DEBUG and MID is 500 (decimal), and the length is 4 bytes (though we only need 1 for 8-bit signal)
- The sender is IO
- 0|8: The unsigned signal starts at bit position 0, and the size of this signal is 8
- (1,0): The scale and offset (discussed later)
- [0|0]: Min and Max is not defined (discussed later)
- "": There are no units (it could be, for instance "inches")
- @1+: Defines that the signal is little-endian, and unsigned: Never change this!


[1] [CAN DBC](http://socialledge.com/sjsu/index.php/DBC_Format)
