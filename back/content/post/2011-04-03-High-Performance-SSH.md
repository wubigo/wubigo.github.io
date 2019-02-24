---
layout: post
title: High Performance SSH/SCP
date: 2011-04-03
tag: [IAAS]
---

http://mirror.internode.on.net/pub/OpenBSD/OpenSSH/portable/
http://www.psc.edu/index.php/hpn-ssh-patches/hpn-14-kitchen-sink-patches/viewcategory/24
Extract OpenSSH:


1

tar -xzvf openssh-6.6p1.tar.gz



Change directory in extracted folder and apply patch:


1

2

cd openssh-6.6p1

zcat /usr/src/openssh-6.6p1-hpnssh14v5.diff.gz | patch


Configure OpenSSH:


1

./configure –prefix=/usr –sysconfdir=/etc/ssh –with-pam



Remove old config files to prevent any conflicts:


1

2

rm /etc/ssh/ssh_config

rm /etc/ssh/sshd_config



Compile and install:


1

2

make

make install


Now we have the newest version of OpenSSH installed and patched with the improvements from HPN-SSH; however we still need to make some changes to the /etc/ssh/sshd_config to take advantage of them. Near the bottom of your config file you will see a section for HPN related options; I used the following options from other guides I found:


1

2

3

4

5

6

7

8

9

10

11

12

# the following are HPN related configuration options

# tcp receive buffer polling. disable in non autotuning kernels

TcpRcvBufPoll yes



# allow the use of the none cipher

#NoneEnabled no



# disable hpn performance boosts.

#HPNDisabled no



# buffer size for hpn to non-hpn connections

HPNBufferSize 8388608


Linux supports both /proc and sysctl (using alternate forms of the variable names - e.g. net.core.rmem_max) for inspecting and adjusting network tuning parameters. The following is a useful shortcut for inspecting all tcp parameters:


sysctl -a | fgrep tcp

For additional information on kernel variables, look at the documentation included with your kernel source, typically in some location such as /usr/src/linux-<version>/Documentation/networking/ip-sysctl.txt. There is a very good (but slightly out of date) tutorial on network sysctl's at http://ipsysctl-tutorial.frozentux.net/ipsysctl-tutorial.html.


If you would like to have these changes to be preserved across reboots, you can add the tuning commands to your the file /etc/rc.d/rc.local .


echo 1 > /proc/sys/net/ipv4/tcp_moderate_rcvbuf
           echo "8388608"> /proc/sys/net/core/wmem_max
           echo "8388608"> /proc/sys/net/core/rmem_max
           echo "4096 87380 8388608" > /proc/sys/net/ipv4/tcp_rmem
           echo "4096 87380 8388608" > /proc/sys/net/ipv4/tcp_wmem
# optimization start

# increase TCP max buffer size setable using setsockopt()

net.ipv4.tcp_rmem = 4096 87380 8388608

net.ipv4.tcp_wmem = 4096 87380 8388608

# increase Linux auto tuning TCP buffer limits

# min, default, and max number of bytes to use

# set max to at least 4MB, or higher if you use very high BDP paths

net.core.rmem_max = 8388608

net.core.wmem_max = 8388608



net.core.netdev_max_backlog = 5000

net.ipv4.tcp_window_scaling = 1

# optimization end



[1] http://www.psc.edu/index.php/hpn-ssh

[2]http://stackoverflow.com/questions/8849240/why-when-i-transfer-a-file-through-sftp-it-takes-longer-than-ftp

[3]http://www.cyberciti.biz/tips/sshd-server-optimization.html
