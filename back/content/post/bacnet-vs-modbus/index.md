+++
title = "Bacnet vs Modbus工控协议对比"
date = 2024-01-31T16:59:12+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = []
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


# BACnet简介

BACnet协议(A Data Communication Protocol for Building Automation and Control Networks)，是由美国采暖、制冷和空调工程师协会（ASHRAE）制定的一个楼宇自动控制技术标准文件，BACnet协议最根本的目的是提供一种楼宇自动控制系统实现互操作的方法。BACnet协议并不能简单的认为是一种应用层的协议，而是包含四个层次的简化分层体系结构，这四层相当于OSI模型中的物理层、数据链路层、网络层和应用层。BACnet是用于楼宇自动化和控制网络的简短形式的数据通信协议。BACnet是主要行业供应商产品中常用的自动化和控制协议之一.BACnet应用包括照明控制，安全，消防，报警，HVAC（加热，通风，空调和与公用事业公司的接口）


## BACnet物理层

BACnet上层不依赖于物理层。BACnet物理层使BACnet可以在不同的网络上实现。BACnet物理层已指定用于以下内容：
- ARCNET 
- 以太网
- IP隧道
- BACnet / IP 
- RS-232 (RS232用于点对点通信。RS485支持最多32个节点，距离为1200米，速率为76Kbps)
- RS485 
- Lonworks / LonTalk

## 服务原语

与ISO服务中的约定用法一致，BACnet中两个对等应用进程间的信息交换，被表示成抽象服务原语的交换。这些服务原语用来传递一些特定的服务参数，本协议定义了四种服务原语：请求（request）、指示（indication）、响应（response）和证实（confirm）。
同样，本协议定义了下列几种服务：有证实（confirmed）服务：用CONF_SERV标记，表示客户方通过具体的服务请求实例向服务器方请求服务，服务器方通过响应请求来为客户方提供服务。存在客户/服务器模型、区分“请求方BACnet用户”和“响应方BACnet用户”等。
无证实（unconfirmed）服务：用UNCONF_SERV标记，只有“发送方BACnet用户”和“接收方BACnet用户”的概念，不存在客户/服务器模型，只有发送方和接收方，而不是请求-响应对。
分段确认（segment acknowledge）服务：用SEGMENT_ACK标记，为了实现长报文（长度大于通信网络、收/发设备所支持的长度）的传输，BACnet采取了应用层报文分段的机制来对报文进行分段。在BACnet中只有有证实请求（Confirmed-Request）和复杂确认（Complex-ACK）报文可能需要分段，因此分段还是BACnet的一个可选特性。
另外，还有差错（ERROR）服务，拒绝（REJECT）服务，中止（ABORT）服务。
因此，根据不同的服务类型和原语类型，据有下表所示的服务原语。这些原语中的信息，由各种协议数据单元（PDU：Protocol Data Unit）传递。


## 服务选择

BACnet定义了以下几类可选择的服务，用于两个对等实体之间的交互。

### 文件访问服务
定义一组访问和操作在BACnet设备中的文件的服务。文件只是一个抽象的概念,表示一个任意长度和意义的字节集合的网络可见形式。
基本读文件（AtomicReadFile）服务：一个客户端的BACnet用户使用基本读文件服务对某个文件进行一个“打开－读出－关闭”的操作。
基本写文件（AtomicWriteFile）服务：一个客户端的BACnet用户使用基本写文件服务对某个字节流进行一个“打开－写入－关闭”的操作，将它写入到文件的某个位置。
###  对象访问服务
###  远程设备管理服务
定义一组远程设备管理服务。
- 设备通信控制（DeviceCommunicationControl）服务。
- 有证实专有传输（ConfirmedPrivateTransfer）服务。
- 无证实专有传输（UnconfirmedPrivateTransfer）服务。
- 重新初始化设备（ReinitializeDevice）服务。
- 有证实文本报文（ConfirmedTextMessage）服务。
- 无证实文本报文（UnconfirmedTextMessage）服务。
- 时间同步（TimeSynchronization）服务。


# ModBus简介

Modbus 协议广泛应用于工业自动化、建筑自动化、环境监测、能源管理等领域，以下是一些常见的应用场景：工业自动化：Modbus 是一种常用的通信协议，可以实现工厂中各种设备的数据采集、控制和监测，如传感器、PLC、变频器、电机驱动器、控制器等设备。建筑自动化：Modbus 可以用于建筑自动化系统中
modbus 是工业现场较为常用的总线协议，是应用层报文传输协议（OSI模型第7层），支持1对1传输、1对多传输。支持的模式有：modbus-TCP、modbus-RTU、modbus-ASCII。其中modbus-TCP是基于TCP/IP之上的应用协议。modbus-RTU、modbus-ASCII 是串口协议，主要的电气接口有：RS232、RS485。

Modbus通信协议已经成为工业领域通信协议的业界标准（De facto），并且现在是工业电子设备之间常用的连接方式（一种行业规范）。此外，还具有三大特点：
- 公开发表并且无版权要求
- 易于部署和维护
- 修改移动本地的比特或字节没有很多限制

概括来讲，Modbus协议就是一种用于工业控制的协议，Modbus具有免费使用、上手简单、需改方便三大特点，已经被广泛使用。

Modbus协议主要分为Modbus TCP、Modbus RTU、Modbus ASCII、Modbus Plus四种

Modbus协议是主从方式通信，也就是说，不能同步进行通信，总线上每次只有一个数据进行传输，即主机发送，从机应答，主机不发送，从机应答完毕后，总线上就没有数据通信。



## Modbus TCP协议
Modbus TCP协议是用于管理和控制自动化设备的，它覆盖了使用TCP/IP协议的“Intranet”和“Internet”环境中Modbus报文的用途，Modbus RTU协议运行于以太网。

Modbus TCP使用TCP/IP和以太网在站点间传送Modbus报文，Modbus TCP结合了以太网物理网络和网络标准TCP/IP以及以Modbus作为应用协议标准的数据表示方法。Modbus TCP通信报文被封装于以太网TCP/IP数据包中。与传统的串口方式，Modbus TCP插入一个标准Modbus报文到TCP报文中，不再带有数据校验和地址。

## Modbus RTU协议
Modbus协议是运行于设备间的协议，或者说设备间必须要有Modbus RTU协议！这是Modbus协议上规定的，且默认模式必须是RTU协议。帧结构一般由地址、功能码、数据、校验组成。

地址用于区分设备，占用一个字节，范围0-255，其中有效范围是1-247，其他有特殊用途，比如255是广播地址(广播地址就是应答所有地址，正常的需要两个设备的地址一样才能进行查询和回复)。

功能码占用一个字节，意义在于指示这个指令的功能。

数据根据功能码确认，不同的功能码有不同的数据结构。

校验位是为了保证数据不出现错误而增加的。校验位将前面的数据进行计算，看数据是否一致，如果一致，就说明这帧数据是正确的，再进行回复;如果不一样，说明数据在传输过程中出了问题，数据产生错误。

## Modbus ASCII协议
Modbus ASCII协议是建立在Modbus RTU协议上的，是将指令转换为ASCII字符进行传输的。比如Modbus RTU协议需要传输“12”，只需要一个字节；Modbus ASCII协议需要将“1”转换为“31”，“2”转化为“32”，再进行传输，需要占用两个字节，因此Modbus ASCII效率不高，使用率较低。

总的来看，Modbus RTU协议和Modbus ACSII协议都是基于232和485链路的，所以其通讯模式半双工，一般是主机和从机的模式。其差别就是其字节的格式不同，一个是16进制的数据，一个是ASCII数据。

## Modbus PLUS协议
Modbus PLUS协议一般被称为MB+，是一种高速现场总线网络，也是一种典型的令牌总线网，针对工业控制应用的本地局域网系统。它允许计算机、可编程序控制器和其他数据源以对等方式进行通信，设备通过"令牌"的方式实现数据的交换，严格定义了令牌的传递方式、数据校验以及通信接口等方面的参数。数据传送速率达1Mbit/s，传输介质一般为为双绞线、同轴电缆或光纤。


# BACnet  vs  Modbus

## BACnet优势
- 支持更多的应用领域：BACnet协议不仅可以用于楼宇自动化系统，还可以应用于工业自动化、能源管理、物流管理等领域，而modbus协议主要应用于工业自动化领域。

- 更好的可扩展性：BACnet协议支持多种通信介质;如以太网、RS-485、无线网络等;可以根据实际需求进行扩展和升级。

- 更高的互操作性：BACnet协议是一种开放的标准协议，可以与不同厂商的设备进行互操作，而modbus协议则存在一些兼容性问题。

- 更强的安全性：BACnet协议支持多种安全机制，如身份认证、数据加密等，可以提高系统的安全性和可靠性。

综上所述，BACnet协议在应用范围、可扩展性、互操作性、安全性和数据传输精度等方面都具有优势，适用于更多的应用场景和需求。


## Modbus的优势
概括来讲，Modbus协议就是一种用于工业控制的协议，Modbus具有如下特性：
- 免费使用、
- 上手简单、
- 需改方便三大特点，已经被广泛使用。