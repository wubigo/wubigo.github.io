+++
title = "Java Notes"
date = 2010-01-01T15:06:20+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["JAVA","LANG"]
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

# 线程同步模式：用户态和内核态

线程间的同步方法大体可分为两类：用户模式和内核模式。顾名思义，内核模式
就是指利用系统内核对象的单一性来进行同步，使用时需要切换内核态与用户态，
而用户模式就是不需要切换到内核态，只在用户态完成操作。

- 用户模式下的方法有：原子操作（例如一个单一的全局变量），临界区。
- 内核模式下的方法有：事件，信号量，互斥量

# volatile 关键字

volatile 提供多线程共享变量可见性和禁止指令重排序优化：

- 对于可见性，Java 提供了 volatile 关键字来保证可见性。
当一个共享变量被 volatile 修饰时，它会保证修改的值会立即被更新到主存，当
有其他线程需要读取时，它会去内存中读取新值
- 禁止指令重排序优化，写操作一定在读操作之后

# 值传递

当一个对象被当作参数传递到一个方法后，此方法可改变
这个对象的属性，并可返回变化后的结果
#  Java诊断利器Arthas

```
curl -O https://arthas.aliyun.com/arthas-boot.jar
java -jar arthas-boot.jar
[arthas@9208]$ thread 1
"main" Id=1 TIMED_WAITING
    at java.base@8.0.12/java.lang.Thread.sleep(Native Method)
    at java.base@8.0.12/java.lang.Thread.sleep(Thread.java:339)
    at java.base@8.0.12/java.util.concurrent.TimeUnit.sleep(TimeUnit.java:446)
```


# JVM MEMORY MODEL

![](./jvm-memory-mode.png)



# javax.net.ssl.SSLException: Received fatal alert: protocol_version


On Java 1.8 default TLS protocol is v1.2. On Java 1.6 and 1.7 default is obsoleted TLS1.0. I get this error on Java 1.8, because url use old TLS1.0

```
echo 'export JAVA_TOOL_OPTIONS="-Dhttps.protocols=TLSv1.2"' >> ~/.bashrc
source ~/.bashrc
```


# 访问可见性

|修饰符|类|包|子类|所有人|
|:---|:----|:---|:---|:---|
|public|是|是|是|是|
|protected|是|是|是|否|
| 没有修饰符|是|是|否|否|
|private|是|否|否|否|

# 方法签名

方法签名包括

- 方法名
- 参数类型
- 参数顺序

不包括

- 返回类型
- 可见性
- 抛出例外

# 过载和覆盖

- 过载: 方法名称相同但签名不同
- 覆盖:
  + 签名相同，而且返回类型也必须相同
  + 可见性不能减少，可以增加可见性
  + 例外必须相同或者是父类例外的子类


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

# Java  Memory Model
The  Java  Memory  Model  is  specified  in  terms  of  actions,  which  include  reads  and  writes  to  variables,  locks  and  unlocks of  monitors,  and  starting  and  joining  with  threads.  The  JMM  defines  a  partial  ordering  [2]  called  happens‐before  on  all actions  within  the  program

# soft reference
four different degrees of reference strength: strong, soft, weak, and phantom, in order from strongest to weakest

SoftReferences aren't required to behave any differently than WeakReferences, but in practice softly reachable objects are generally retained as long as memory is in plentiful supply. This makes them an excellent foundation for a cache, such as the image cache described above

# checked exception
The cardinal rule in deciding whether to use a checked or an unchecked exception is this: use checked exceptions for conditions from which the caller can reasonably be expected to recover. By throwing a checked exception, you force the caller to handle the exception in a catch clause or to propagate it outward. Each checked exception that a method is declared to throw is therefore a potent indication to the API user that the associated condition is a possible outcome of invoking the method.
