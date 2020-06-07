+++
title = "泛播IPV4"
date = 2014-06-07T14:44:19+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["BGP", "NETWORK"]
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


## What is anycast?

Anycast, also known as IP anycast, is a networking technique that allows for multiple machines to share the same IP address. Based on the location of the user request, the routers send it to the machine in the network that is closest. This is beneficial since, among other things, it reduces latency and increases redundancy. If a particular data center were to go offline, an anycasted IP would choose the best path for users and automatically redirect them to the next closest data center. The following outlines some of the pros and cons that are associated with configuring anycast.

### Pros

- Speed. Traffic going to an anycast node will be routed to the nearest node thus reducing latency between the client and the node itself. This ensures that speeds will be optimized no matter where the client is requesting information from.
- Redundancy. Anycast improves redundancy by placing multiple servers across the globe using the same IP. This allows for traffic to be rerouted to the next nearest server in the case that one server fails or goes offline.
- DDoS mitigation. DDoS attacks are caused by botnets which can generate so much traffic they overwhelm a typical Unicast machine. The benefit of having an anycast configuration in this situation is that each server is able to "absorb" a portion of the attack resulting in less strain on the server overall.
- Load balancing. Load balancing can be utilized in the case that there are multiple nodes all within the same geographic distance from the request. This takes some of the resource requirements off of a singular node and disperses them across multiple nodes.

### Cons

- Difficult to Implement. Implementing IP anycast is a complex endeavor that requires additional hardware, reliable upstream providers, and proper traffic routing


https://www.linuxjournal.com/magazine/ipv4-anycast-linux-and-quagga