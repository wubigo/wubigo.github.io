---
layout: post
title: java notes
date: 2010-01-01
tag: java
---

# Lock and ReentrantLock

Before Java 5.0, the only mechanisms for coordinating access to shared data were synchronized and volatile. Java
5.0 adds another option: ReentrantLock. Contrary to what some have written, ReentrantLock is not a replacement for
intrinsic locking, but rather an alternative with advanced features for when intrinsic locking proves too limited

Intrinsic locking works fine in most situations
but has some functional limitations ‐ it is not possible to interrupt a thread waiting to acquire a lock, or to attempt to
acquire a lock without being willing to wait for it forever. Intrinsic locks also must be released in the same block of code
in which they are acquired; this simplifies coding and interacts nicely with exception handling, but makes non‐blockstructured
locking disciplines impossible

# hashtable
