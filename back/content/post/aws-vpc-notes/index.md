+++
title = "Aws VPC 基础"
date = 2016-02-06T07:39:39+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["AWS", "VPC"]
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

## 典型使用场景

- 单一公开子网

![](/img/post/vpc-public-subnet.png)

- 公开子网和私有子网

![](/img/post/vpc-pub-private-subnet.png)

- 企业数据中心+公开子网

![](/img/post/vpc-vpn.png)

- 企业数据中心

![](/img/post/vpc-private-vpn.png)


## 公网网关

An Internet gateway is a fully managed AWS service that performs bi-direction source and destination network address translation for your EC2 instances. Optionally, a VPC may use a virtual private gateway to grant instances secure access to a user’s corporate network via VPN or direct connect links. Instances in a subnet can also be granted outbound only Internet access through a NAT gateway.

##  security group

- security group as the source for a rule

When you specify a security group as the source for a rule, traffic is allowed from the network interfaces that are associated with the source security group for the specified protocol and port. Adding a security group as a source does not add rules from the source security group

## public subnet

---

A public subnet is a subnet that's associated with a route table that has a route to an Internet gateway

if your subnet is not associated to a specific route table, then by default it’s going to the main route table



## Internet Gateway

---

An Internet Gateway is a logical connection between an Amazon VPC and the Internet. It is nota physical device. Only one can be associated with each VPC. It does not limit the bandwidth of Internet connectivity. (The only limitation on bandwidth is the size of the Amazon EC2 instance, and it applies to all traffic -- internal to the VPC and out to the Internet.)

If a VPC does not have an Internet Gateway, then the resources in the VPC cannot be accessed from the Internet (unless the traffic flows via a corporate network and VPN/Direct Connect).

A subnet is deemed to be a Public Subnet if it has a Route Table that directs traffic to the Internet Gateway.

## NAT Instance

---

A NAT Instance is an Amazon EC2 instance configured to forward traffic to the Internet. It can be launched from an existing AMI, or can be configured via User Data like this:

```
#!/bin/sh
echo 1 > /proc/sys/net/ipv4/ip_forward
echo 0 > /proc/sys/net/ipv4/conf/eth0/send_redirects
/sbin/iptables -t nat -A POSTROUTING -o eth0 -s 0.0.0.0/0 -j MASQUERADE
/sbin/iptables-save > /etc/sysconfig/iptables
mkdir -p /etc/sysctl.d/
cat <<EOF > /etc/sysctl.d/nat.conf
net.ipv4.ip_forward = 1
net.ipv4.conf.eth0.send_redirects = 0
EOF
```

Instances in a private subnet that want to access the Internet can have their Internet-bound traffic forwarded to the NAT Instance via a Route Table configuration. The NAT Instance will then make the request to the Internet (since it is in a Public Subnet) and the response will be forwarded back to the private instance.

Traffic sent to a NAT Instance will typically be sent to an IP address that is not associated with the NAT Instance itself (it will be destined for a server on the Internet). Therefore, it is important to turn off the Source/Destination Check option on the NAT Instance otherwise the traffic will be blocked.

## NAT Gateway

---

AWS introduced a NAT Gateway Service that can take the place of a NAT Instance. The benefits of using a NAT Gateway service are:

It is a fully-managed service -- just create it and it works automatically, including fail-over
It can burst up to 10 Gbps (a NAT Instance is limited to the bandwidth associated with the EC2 instance type)
However:

Security Groups cannot be associated with a NAT Gateway
You'll need one in each AZ since they only operate in a single AZ


## Route table

---

Every VPC is attached to an implicit router. This router is not visible to the user and is fully managed and scaled by AWS. What is visible is the route table associated with each subnet, which is used by the VPC router to determine the allowed routes for outbound network traffic leaving a subnet.

every route table contains a default local route to facilitate communication between instances in the same VPC, even across subnets. This intra-VPC local route is implied and cannot be changed.

In the case of the main route table that is associated with a default subnet, there will also be a route out to the Internet via the default gateway for the VPC.

every subnet must be associated with a route table. If the association is not explicitly defined, then a subnet will be implicitly associated with the main route table.

and as such each subnet can route to each other. The fact that the subnets are in different AZs is irrelevant.

## VPC Endpoints

---

There are two types of VPC endpoints: interface endpoints and gateway endpoints. Create the type of VPC endpoint required by the supported service

- Interface Endpoints (Powered by AWS PrivateLink)

- Gateway Endpoints

