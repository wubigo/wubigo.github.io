+++
title = "RPC GRPC"
date = 2017-04-03T05:53:42+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["RPC"]
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



# the architecture of gRPC is layered:

The lowest layer is the transport: gRPC uses HTTP/2 as its transport protocol. HTTP/2 provides the same basic semantics as HTTP 1.1 (the version with which nearly all developers are familiar), but aims to be more efficient and more secure. The new features in HTTP/2 that are most obvious at first glance are (1) that it can multiplex many parallel requests over the same network connection and (2) that it allows full-duplex bidirectional communication. We’ll learn more about
 HTTP/2 and the ways it differs from and improves on HTTP 1.1 later in the book.


The next layer is the channel: This is a thin abstraction over the transport. The channel defines calling conventions and implements the mapping of an RPC onto the underlying transport. At this layer, a gRPC call consists of a client-provided service name and method name, optional request metadata (key-value pairs), and zero or more request messages. A call is completed when the server provides optional response header metadata, zero or more response messages, and response trailer metadata. The trailer metadata indicates the final disposition of the call: whether it was a success or a failure. At this layer, there is no knowledge of interface constraints, data types, or message encoding. A message is just a sequence of zero or more bytes. A call may have any number of request and response messages.


The last layer is the stub: The stub layer is where interface constraints and data types are defined. Does a method accept exactly one request message or a stream of request messages? What kind of data is in each response message and how is it encoded? The answers to these questions are provided by the stub. The stub marries the IDL-defined interfaces to a channel. The stub code is generated from the IDL. The channel layer provides the ABI that these generated stubs use.





# Streaming


When a very large amount of data must be exchanged, this can mean significant memory pressure on both the client process and the server process. And it means that operations must typically impose hard limits on the size of request and response messages, to prevent resource exhaustion. Streaming alleviates this by allowing the request or response to be an arbitrarily long
sequence of messages. The cumulative total size of a request or response stream may be incredibly large, but clients and servers do not need to store the entire stream in memory. Instead, they can operate on a subset of data, even as little as just one message at a time.

Not only does gRPC support streaming, but it also supports full-duplex bidirectional streams. Bidirectional means that the client can use a stream to upload an arbitrary amount of request data and the server can use a stream to send back an arbitrary amount of response data, all in the same RPC. The novel part is the “full-duplex” part. Most request-response protocols, including HTTP 1.1 are “half-duplex.” They support bidirectional communication (HTTP 1.1 even supports bidirectional streaming), but the two directions cannot be used at the same time. A request must first be fully
uploaded before the server begins responding; only after the client is done transmitting can the server then reply with its full response. gRPC is built on HTTP/2, which explicitly supports full-duplex streams, which means that the client can upload request data at the same time the server is sending back response data. This is very powerful and eliminates the need for things like
web sockets, which is an extension of HTTP 1.1, to allow full-duplex communication over an HTTP 1.1 connection. Thanks to streaming, applications can build very sophisticated conversational protocols on top of gRPC.


