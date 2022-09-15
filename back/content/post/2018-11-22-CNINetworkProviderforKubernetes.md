---
layout: post
title: Choosing a CNI Network Provider for Kubernetes
date: 2018-11-22
tags: ["K8S", "CNI", "DOCKER"]
---


The Container Network Interface (CNI) is a library definition, and a set of tools under the umbrella of the Cloud 
Native Computing Foundation project. For more information visit their GitHub project. 
Kubernetes uses CNI as an interface between network providers and Kubernetes networking.


# Why Use CNI
Kubernetes default networking provider, kubenet, is a simple network plugin that works with various cloud providers. 
Kubenet is a very basic network provider, and basic is good, but does not have very many features. Moreover, kubenet 
has many limitations. For instance, when running kubenet in AWS Cloud, you are limited to 50 EC2 instances. 
Route tables are used to configure network traffic between Kubernetes nodes, and are limited to 50 entries per VPC. 
Moreover, a cluster cannot be set up in a Private VPC, since that network topology uses multiple route tables. Other 
more advanced features, such as BGP, egress control, and mesh networking, are only available with different CNI providers.


# CNI in kops
At last count, kops supports seven different CNI providers besides kubenet. Choosing from seven different network providers is a daunting task.

Here is our current list of providers that can be installed out of the box, sorted in alphabetical order.

Calico
Canal (Flannel + Calico)
flannel
kopeio-vxlan
kube-router
romana
Weave Net
Any of these CNI providers can be used without kops. All of the CNI providers use a daemonset installation model, 
where their product deploys a Kubernetes Daemonset. Just use kubectl to install the provider on the master once the 
K8S API server has started. Please refer to each projects specific documentation


# Support Matrix
a table of different features from each of the CNI providers mentioned:

|  Provider     | Network Model| Route Distribution|Network Policies|Mesh      | |External Datastore|Encryption|Ingress/Egress Policies| Commercial Support|
| :------------ | :----------: | ---------------------------------: |:-------- | :----------------: | -------------------------------: |:--------------- : |
|  Calico       | Layer 3      | Yes                                |Yes       | Etcd               | Yes                              | Yes               | 
|  flannel      | Layer 2 vxlan| Mo                                 |No        | None               | No                               | No                | 
|  Weave        | Layer 2 vxlan| N/A                                |Yes       | No                 | Yes                              | Yes               | 

1. Calico and Canal include a feature to connect directly to Kubernetes, and not use Etcd.
2. Weave Net can operate in AWS-VPC mode without vxlan, but is limited to 50 nodes in EC2.
3. Weave Net does not have egress rules out of the box.


Table Details
# Network Model
The Network Model with providers is either encapsulated networking such as VXLAN, or unencapsulated layer 2 networking.
 Encapsulating network traffic requires compute to process, so theoretically is slower. In my opinion, most use cases 
 will not be impacted by the overhead. More about VXLAN on wikipedia.

# Route Distribution
For layer 3 CNI providers, route distribution is necssary. Route distribution is typically via BGP. Route distribution
is nice to have a feature with CNI, if you plan to build clusters split across network segments. It is an exterior
gateway protocol designed to exchange routing and reachability information on the internet. BGP can assist with pod to
pod networking between clusters.

# Network Policies
A kubernetes.io blog post about network policies in 1.8 here.
```
Kubernetes now offers functionality to enforce rules about which pods can communicate with each other using network
policies. This feature is has become stable Kubernetes 1.7 and is ready to use with supported networking plugins. 
The Kubernetes 1.8 release has added better capabilities to this feature.
```

# Mesh Networking
This feature allows for “Pod to Pod” networking between Kubernetes clusters. This technology is not Kubernetes
federation, but is pure networking between Pods.

# Encyption
Encrypting the network control plane, so all TCP and UDP traffic is encrypted.

# Ingress / Egress Policies
The network policies are both Kubernetes and Non-Kubernetes routing control. For instance, many providers will allow 
an administrator to block a pod communicating with an EC2 instance meta and data service on 169.254.169.254.

Summary
If you do not need the advanced features that a CNI provider delivers, use kubenet. It is stable, and fast. 
Otherwise, pick one. If you do need run more than 50 nodes on AWS, or need other advanced features, make a decision 
quickly (don’t spend days deciding), and test with your cluster. File bugs, and develop a relationship with your 
network provider. At this point in time, networking is not boring in Kubernetes. It is getting more boring every 
day! Monitor test and monitor more.




[https://chrislovecnm.com/kubernetes/cni/choosing-a-cni-provider/](https://chrislovecnm.com/kubernetes/cni/choosing-a-cni-provider/)



