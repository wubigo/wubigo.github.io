+++
title = "Decentralized Social Network: Federated VS P2P Protocol"
date = 2021-08-18T15:55:30+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["IM"]
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


# Matrix

Traditionally Matrix decentralises communication by replicating conversation history over a mesh of servers, so that no single server has ownership of a given conversation. Meanwhile, users connect to their given homeserver from clients via plain HTTPS + DNS. This has the significant disadvantage that for a user to have full control and ownership over their communication, they need to run their own server - which comes with a cost, and requires you to be a proficient sysadmin. In order to fully democratise communication and eliminate a compulsory dependency on a homeserver, we've started seriously working on making Matrix run as a P2P protocol by compiling homeservers to run clientside and using P2P transports such as libp2p - while seamlessly supporting all existing Matrix clients (e.g. Riot.im), bots and bridges with negligible changes. This work includes:

Compiling Matrix homeservers (e.g. Dendrite) to efficiently run clientside
Layering HTTPS over P2P transports such as libp2p (e.g. https://github.com/matrix-org/libp2p-proxy)
Switching Matrix identifiers from @user:domain tuples to be Curve25519 public keys (MSC1228)
Decentralising accounts so they can be hosted concurrently on multiple nodes (e.g. a mix of server-side and client-side homeservers)
Experimenting with node discovery from DNS to DHTs and other mechanisms (e.g. gossip mechanisms)
Experimenting with smarter bandwidth-efficient routing algorithms than full-mesh (e.g. combinations of spanning trees, overlapping spanning trees, gossip mechanisms)
Making Matrix's low-bandwidth CoAP transport production grade
Experimenting with metadata-protecting relay mechanisms rather than using full homeservers for server-side relaying.

https://archive.fosdem.org/2020/schedule/event/dip_p2p_matrix/



# Bluesky

https://gitlab.com/bluesky-community1/decentralized-ecosystem