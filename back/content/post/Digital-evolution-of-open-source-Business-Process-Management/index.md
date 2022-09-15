+++
title = "开源的工作流引擎技术演进历史"
date = 2019-10-27T11:26:02+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["BPM", "工作流"]
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


#  第一代

2003年， jBPM 1.0发布。

运行环境：J2EE

过程定义语言：jPDL(当时工作流厂商都有各自的过程定义语言和建模工具)

当时的主流的技术： applets, Swing桌面和EJB

# 第二代

2004年，jBPM 2.0发布

同时jBPM加入JBoss基金会.

运行环境：任何JAVA环境(POJO实现过程运行时)，不需要应用服务器

# 第三代

2005年, jBPM 3.0发布，支持BPEL

过程定义语言：过程虚拟机

架构： 与二代相比，架构发生了巨大变化。可以操作的业务功能大范围扩展，不仅通

过JAVA实现状态机，而且支持建模

HIBERNETE作为持久机制并同时提供会话对象的概念，

工作流引擎所有的相关性交互都纳入[contextual block](https://docs.jboss.org/jbpm/v3.2/javadoc-jpdl/org/jbpm/JbpmContext.html)范畴

这为以后的工作流命令设计模式和命令拦截设计模式的广泛应用打下良好的基础


# 第四代

2009年， jBPM 4.0 alpha版发布.

过程虚拟机成功工作流引擎的核心。

过程定义语言：BPMN, jPDL 和 BPEL

因为团队人员离开并启动Activiti，正式版没能发布。

主要改进：

- 无状态的服务API
- 运行时和历史数据的分离： 保证运行时持久的性能

# 第五代

2010年, Activiti 1发布

改变：

- 版权从LGPL转到APACHE.

- 过程定义语言：BPMN(唯一)

- 从性能和扩展性加强PVM

- 多租户支持

- 轻量级架构

# 第六代

2017年，flowable 6.0发布。

改变：

- 过程模型：放弃PVM,使用原生BPMN， 实现真正的动态过程执行和复杂的过程迁移

- 数据远完全抽象：支持NoSQL

- CMMN支持

- 函数式工作流











