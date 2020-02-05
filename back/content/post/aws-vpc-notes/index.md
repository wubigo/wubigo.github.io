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

## public subnet

A public subnet is a subnet that's associated with a route table that has a route to an Internet gateway



## Internet Gateway

An Internet Gateway is a logical connection between an Amazon VPC and the Internet. It is nota physical device. Only one can be associated with each VPC. It does not limit the bandwidth of Internet connectivity. (The only limitation on bandwidth is the size of the Amazon EC2 instance, and it applies to all traffic -- internal to the VPC and out to the Internet.)

If a VPC does not have an Internet Gateway, then the resources in the VPC cannot be accessed from the Internet (unless the traffic flows via a corporate network and VPN/Direct Connect).

A subnet is deemed to be a Public Subnet if it has a Route Table that directs traffic to the Internet Gateway.

## NAT Instance

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

AWS introduced a NAT Gateway Service that can take the place of a NAT Instance. The benefits of using a NAT Gateway service are:

It is a fully-managed service -- just create it and it works automatically, including fail-over
It can burst up to 10 Gbps (a NAT Instance is limited to the bandwidth associated with the EC2 instance type)
However:

Security Groups cannot be associated with a NAT Gateway
You'll need one in each AZ since they only operate in a single AZ