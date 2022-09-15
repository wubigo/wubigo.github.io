+++
title = "Aws EC2 多网卡配置"
date = 2017-02-28T16:26:49+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["AWS", "SDN"]
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

>We can no longer assign a public IP address to your instance
>
>The auto-assign public IP address feature for this instance is 
>disabled because you specified multiple network interfaces. 
>Public IPs can only be assigned to instances with one network interface.
>To re-enable the auto-assign public IP address feature, please specify only the eth0 network interface.








![](/img/post/NIC-Type.png)


## ip

```
MAC=`curl http://169.254.169.254/latest/meta-data/mac` 
curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/${MAC}/local-ipv4s
```



## 配置第二块网卡




```
ip a | grep ^[[:digit:]]



tee -a /etc/network/interfaces.d/50-cloud-init.cfg <<-'EOF'
auto eth1
iface eth1 inet dhcp
EOF




tee -a /etc/dhcp/dhclient-enter-hooks.d/restrict-default-gw <<-'EOF'
case ${interface} in
  eth0)
    ;;
  *)
    unset new_routers
    ;;
esac
EOF



systemctl restart networking
```


## 访问互联网

必须分配并关联EIP