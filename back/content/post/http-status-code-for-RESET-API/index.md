+++
title = "REST API中如何使用Http状态码"
date = 2018-10-26T11:14:14+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["HTTP", "REST"]
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



# Status-Line
The first line of a Response message is the Status-Line, consisting of the protocol version followed by a numeric status code and its associated textual phrase, with each element separated by SP characters. No CR or LF is allowed except in the final CRLF sequence.

```
      Status-Line = HTTP-Version SP Status-Code SP Reason-Phrase CRLF
```



# status code vs status in body

https://www.codetinkerer.com/2015/12/04/choosing-an-http-status-code.html


https://httpstatuses.com/




The main choice is do you want to treat the HTTP status code as part of your REST API or not.

Both ways work fine. I agree that, strictly speaking, one of the ideas of REST is that you should use the HTTP Status code as a part of your API (return 200 or 201 for a successful operation and a 4xx or 5xx depending on various error cases.) However, there are no REST police. You can do what you want. I have seen far more egregious non-REST APIs being called "RESTful."

At this point (August, 2015) I do recommend that you use the HTTP Status code as part of your API. It is now much easier to see the return code when using frameworks than it was in the past. In particular, it is now easier to see the non-200 return case and the body of non-200 responses than it was in the past.

The HTTP Status code is part of your api

You will need to carefully pick 4xx codes that fit your error conditions. You can include a rest, xml, or plaintext message as the payload that includes a sub-code and a descriptive comment.

The clients will need to use a software framework that enables them to get at the HTTP-level status code. Usually do-able, not always straight-forward.

The clients will have to distinguish between HTTP status codes that indicate a communications error and your own status codes that indicate an application-level issue.

The HTTP Status code is NOT part of your api

The HTTP status code will always be 200 if your app received the request and then responded (both success and error cases)

ALL of your responses should include "envelope" or "header" information. Typically something like:


```
envelope_ver: 1.0
status:  # use any codes you like. Reserve a code for success. 
msg: "ok" # A human string that reflects the code. Useful for debugging.
data: ...  # The data of the response, if any.
```

This method can be easier for clients since the status for the response is always in the same place (no sub-codes needed), no limits on the codes, no need to fetch the HTTP-level status-code.






https://cloud.google.com/blog/products/api-management/restful-api-design-what-about-errors
