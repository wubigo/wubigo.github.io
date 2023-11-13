+++
title = "K8s 多租户"
date = 2021-11-12T10:07:12+08:00
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


# 多租户的运行

## 不同的应用运行在同一个集群

## 相同应用的多个实例运行在同一个集群

## 敏感数据应用独享实例，非敏感数据共享实例

hybrid architectures are also possible, such as a SaaS provider using a combination of per-customer workloads for sensitive data, combined with multi-tenant shared services.

# 隔离方式

## 控制面隔离机制

### 名字空间

### 访问控制

### 资源配额

## 数据面隔离机制

### 网络隔离

Pod-to-pod communication can be controlled using Network Policies, which restrict communication between pods using namespace labels or IP address ranges. In a multi-tenant environment where strict network isolation between tenants is required, starting with a default policy that denies communication between pods is recommended with another rule that allows all pods to query the DNS server for name resolution

### 存储隔离

### 节点隔离