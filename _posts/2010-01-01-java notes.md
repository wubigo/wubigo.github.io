---
layout: post
title: java notes
date: 2010-01-01
tag: Java
---

# visibility and Atomicity
in  the  absence  of  synchronization,  there  are  a  number  of  reasons  a  thread might  not  immediately  ‐  or  ever  ‐  see  the  results  of  an  operation  in  another  thread.  Compilers  may  generate  instructions in  a  different  order  than  the  "obvious"  one  suggested  by  the  source  code,  or  store  variables  in  registers  instead  of  in memory;  processors  may  execute  instructions  in  parallel  or  out  of  order;  caches  may  vary  the  order  in  which  writes  to variables  are  committed  to  main  memory;  and  values  stored  in  processor‐local  caches  may  not  be  visible  to  other processors.  These  factors  can  prevent  a  thread  from  seeing  the  most  up‐to‐date  value  for  a  variable  and  can  cause memory actions  in  other  threads  to  appear  to  happen  out  of  order  ‐  if  you  don't  use  adequate  synchronization. 

# Lock and ReentrantLock

Before Java 5.0, the only mechanisms for coordinating access to shared data were synchronized and volatile. Java
5.0 adds another option: ReentrantLock. Contrary to what some have written, ReentrantLock is not a replacement for
intrinsic locking, but rather an alternative with advanced features for when intrinsic locking proves too limited

Intrinsic locking works fine in most situations
but has some functional limitations ‐ it is not possible to interrupt a thread waiting to acquire a lock, or to attempt to
acquire a lock without being willing to wait for it forever. Intrinsic locks also must be released in the same block of code
in which they are acquired; this simplifies coding and interacts nicely with exception handling, but makes non‐blockstructured
locking disciplines impossible

# ReadWriteLock
The  locking  strategy  implemented  by  read‐write  locks  allows  multiple  simultaneous  readers  but  only  a  single  writer.
In  practice, read‐write  locks  can  improve  performance  for  frequently  accessed  read‐mostly  data  structures  on  multiprocessor systems;  under  other  conditions  they  perform  slightly  worse  than  exclusive  locks  due  to  their  greater  complexity. Whether  they  are  an  improvement  in  any  given  situation  is  best  determined  via  profiling;  because  ReadWriteLock  uses Lock  for  the  read  and  write  portions  of  the  lock,  it  is  relatively  easy  to  swap  out  a  read‐write  lock  for  an  exclusive  one  if profiling  determines  that  a  read‐write  lock  is  not  a  win. 

# hashtable

* Hashtable is synchronized, whereas HashMap is not. This makes HashMap better for non-threaded applications, as unsynchronized Objects typically perform better than synchronized ones.
* Hashtable does not allow null keys or values. HashMap allows one null key and any number of null values.
* One of HashMap's subclasses is LinkedHashMap, so in the event that you'd want predictable iteration order (which is insertion order by default), you could easily swap out the HashMap for a LinkedHashMap. This wouldn't be as easy if you were using Hashtable.

HashTable is obsolete in Java 1.7 and it is recommended to use ConcurrentMap implementation
