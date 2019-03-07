+++
title = "HTTP Session Management"
date = 2017-01-05T10:46:00+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["HTTP"]
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

# COOKIE & HTTP SESSION

H5 addition that adds a key/value store to browsers and cookies

# stateful session

Some examples of scaling stateful sessions:

    Once you run multiple backend processes on a server: A Redis daemon (on that server) for session storage.
    Once you run on multiple servers: A dedicated server running Redis just for session storage.
    Once you run on multiple servers, in multiple clusters: Sticky sessions.



# JWT session

- Stateless JWT: A JWT token that contains the session data, encoded directly into the token.
- Stateful JWT: A JWT token that contains just a reference or ID for the session. The session data is stored server-side.
- Session token/cookie: A standard (optionally signed) session ID, like web frameworks have been using for a long time. The session data is stored server-side.


Stop using JWT for sessions
http://cryto.net/~joepie91/blog/2016/06/13/stop-using-jwt-for-sessions/



