+++
title = "Vpn客户端设置参考"
date = 2018-01-02T06:34:20+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["VPN", "SDN", "NFV"]
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

## how-to-allow-local-network-when-using-wireguard-vpn-tunnel

- 允许非隧道流量

```
Open the WireGaurd Windows client.
In the left pane, select the tunnel that you want local network routing to work, if you have more than one tunnel.
Hit the Edit button.
Uncheck Block untunneled traffic (kill-switch) option
```

- 增加本地的网络

```
AllowedIPs = 192.168.0.0/16, 0.0.0.0/1, 128.0.0.0/1, ::/1, 8000::/1
```

## 安装

https://download.wireguard.com/windows-client/wireguard-amd64-0.0.38.msi


## 配置

![](/img/post/wireguard-win.png)

- 更改公钥

- Endpoint所在的vpn服务器地址 





https://github.com/Nyr/openvpn-install

https://github.com/hwdsl2/setup-ipsec-vpn


https://wireguard.isystem.io/


https://github.com/meshbird/meshbird


https://www.tinc-vpn.org/



https://github.com/isystem-io/wireguard-aws



Download and install the TunSafe, which is a Wireguard client for Windows.






```
 wget https://git.io/vpnsetup -O vpnsetup.sh && sudo sh vpnsetup.sh
--2020-01-01 22:26:54--  https://git.io/vpnsetup
Resolving git.io (git.io)... 54.165.216.26, 54.224.175.112, 34.227.147.55, ...
Connecting to git.io (git.io)|54.165.216.26|:443... connected.
HTTP request sent, awaiting response... 302 Found
Location: https://raw.githubusercontent.com/hwdsl2/setup-ipsec-vpn/master/vpnsetup.sh [following]
--2020-01-01 22:26:55--  https://raw.githubusercontent.com/hwdsl2/setup-ipsec-vpn/master/vpnsetup.sh
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 151.101.188.133
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|151.101.188.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 15318 (15K) [text/plain]
Saving to: ‘vpnsetup.sh’

vpnsetup.sh                             100%[=============================================================================>]  14.96K  --.-KB/s    in 0.001s

2020-01-01 22:26:55 (13.1 MB/s) - ‘vpnsetup.sh’ saved [15318/15318]


## VPN credentials not set by user. Generating random PSK and password...


## VPN setup in progress... Please be patient.


## Populating apt-get cache...

Hit:1 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial InRelease
Hit:2 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates InRelease
Hit:3 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-backports InRelease
Hit:4 http://security.ubuntu.com/ubuntu xenial-security InRelease
Reading package lists...

## Installing packages required for setup...

Reading package lists...
Building dependency tree...
Reading state information...
gawk is already the newest version (1:4.1.3+dfsg-0.1).
iptables is already the newest version (1.6.0-2ubuntu3).
net-tools is already the newest version (1.60-26ubuntu1).
sed is already the newest version (4.2.2-7).
dnsutils is already the newest version (1:9.10.3.dfsg.P4-8ubuntu1.15).
grep is already the newest version (2.25-1~16.04.1).
iproute2 is already the newest version (4.3.0-1ubuntu3.16.04.5).
openssl is already the newest version (1.0.2g-1ubuntu4.15).
wget is already the newest version (1.17.1-1ubuntu1.5).
0 upgraded, 0 newly installed, 0 to remove and 59 not upgraded.

## Trying to auto discover IP of this server...

In case the script hangs here for more than a few minutes,
press Ctrl-C to abort. Then edit it and manually enter IP.

## Installing packages required for the VPN...

Reading package lists...
Building dependency tree...
Reading state information...
gcc is already the newest version (4:5.3.1-1ubuntu1).
gcc set to manually installed.
make is already the newest version (4.1-6).
make set to manually installed.
The following additional packages will be installed:
  libbison-dev libcurl3-nss libevent-core-2.0-5 libevent-extra-2.0-5 libevent-openssl-2.0-5 libevent-pthreads-2.0-5 libfl-dev libnspr4 libnss3 libnss3-nssdb
  libpcre16-3 libpcre3-dev libpcre32-3 libpcrecpp0v5 libsepol1-dev m4
Suggested packages:
  bison-doc libcurl4-doc libcurl3-dbg libidn11-dev libkrb5-dev libldap2-dev librtmp-dev zlib1g-dev
The following NEW packages will be installed:
  bison flex libbison-dev libcap-ng-dev libcap-ng-utils libcurl3-nss libcurl4-nss-dev libevent-core-2.0-5 libevent-dev libevent-extra-2.0-5
  libevent-openssl-2.0-5 libevent-pthreads-2.0-5 libfl-dev libnspr4 libnspr4-dev libnss3 libnss3-dev libnss3-nssdb libnss3-tools libpam0g-dev libpcre16-3
  libpcre3-dev libpcre32-3 libpcrecpp0v5 libselinux1-dev libsepol1-dev m4 pkg-config ppp xl2tpd
0 upgraded, 30 newly installed, 0 to remove and 59 not upgraded.
Need to get 6,229 kB of archives.
After this operation, 25.3 MB of additional disk space will be used.
Get:1 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial/main amd64 m4 amd64 1.4.17-5 [195 kB]
Get:2 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial/main amd64 libfl-dev amd64 2.6.0-11 [12.5 kB]
Get:3 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial/main amd64 flex amd64 2.6.0-11 [290 kB]
Get:4 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial/main amd64 libpcrecpp0v5 amd64 2:8.38-3.1 [15.2 kB]
Get:5 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial/main amd64 libbison-dev amd64 2:3.0.4.dfsg-1 [338 kB]
Get:6 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial/main amd64 bison amd64 2:3.0.4.dfsg-1 [259 kB]
Get:7 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial/main amd64 libcap-ng-dev amd64 0.7.7-1 [21.6 kB]
Get:8 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial/universe amd64 libcap-ng-utils amd64 0.7.7-1 [14.9 kB]
Get:9 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libnspr4 amd64 2:4.13.1-0ubuntu0.16.04.1 [112 kB]
Get:10 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libnss3-nssdb all 2:3.28.4-0ubuntu0.16.04.9 [10.6 kB]
Get:11 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libnss3 amd64 2:3.28.4-0ubuntu0.16.04.9 [1,146 kB]
Get:12 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libcurl3-nss amd64 7.47.0-1ubuntu2.14 [190 kB]
Get:13 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libcurl4-nss-dev amd64 7.47.0-1ubuntu2.14 [267 kB]
Get:14 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libevent-core-2.0-5 amd64 2.0.21-stable-2ubuntu0.16.04.1 [70.6 kB]
Get:15 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libevent-extra-2.0-5 amd64 2.0.21-stable-2ubuntu0.16.04.1 [51.1 kB]
Get:16 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libevent-pthreads-2.0-5 amd64 2.0.21-stable-2ubuntu0.16.04.1 [5,020 B]
Get:17 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libevent-openssl-2.0-5 amd64 2.0.21-stable-2ubuntu0.16.04.1 [10.6 kB]
Get:18 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libevent-dev amd64 2.0.21-stable-2ubuntu0.16.04.1 [211 kB]
Get:19 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libnspr4-dev amd64 2:4.13.1-0ubuntu0.16.04.1 [213 kB]
Get:20 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libnss3-dev amd64 2:3.28.4-0ubuntu0.16.04.9 [230 kB]
Get:21 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/universe amd64 libnss3-tools amd64 2:3.28.4-0ubuntu0.16.04.9 [840 kB]
Get:22 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libpam0g-dev amd64 1.1.8-3.2ubuntu2.1 [109 kB]
Get:23 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial/main amd64 libpcre16-3 amd64 2:8.38-3.1 [144 kB]
Get:24 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial/main amd64 libpcre32-3 amd64 2:8.38-3.1 [136 kB]
Get:25 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial/main amd64 libpcre3-dev amd64 2:8.38-3.1 [525 kB]
Get:26 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial/main amd64 libsepol1-dev amd64 2.4-2 [249 kB]
Get:27 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial/main amd64 libselinux1-dev amd64 2.4-3build2 [122 kB]
Get:28 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial/main amd64 pkg-config amd64 0.29.1-0ubuntu1 [45.0 kB]
Get:29 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 ppp amd64 2.4.7-1+2ubuntu1.16.04.1 [330 kB]
Get:30 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/universe amd64 xl2tpd amd64 1.3.6+dfsg-4ubuntu0.16.04.2 [65.6 kB]
Fetched 6,229 kB in 2s (2,631 kB/s)
Selecting previously unselected package m4.
(Reading database ... 57764 files and directories currently installed.)
Preparing to unpack .../archives/m4_1.4.17-5_amd64.deb ...
Unpacking m4 (1.4.17-5) ...
Selecting previously unselected package libfl-dev:amd64.
Preparing to unpack .../libfl-dev_2.6.0-11_amd64.deb ...
Unpacking libfl-dev:amd64 (2.6.0-11) ...
Selecting previously unselected package flex.
Preparing to unpack .../flex_2.6.0-11_amd64.deb ...
Unpacking flex (2.6.0-11) ...
Selecting previously unselected package libpcrecpp0v5:amd64.
Preparing to unpack .../libpcrecpp0v5_2%3a8.38-3.1_amd64.deb ...
Unpacking libpcrecpp0v5:amd64 (2:8.38-3.1) ...
Selecting previously unselected package libbison-dev:amd64.
Preparing to unpack .../libbison-dev_2%3a3.0.4.dfsg-1_amd64.deb ...
Unpacking libbison-dev:amd64 (2:3.0.4.dfsg-1) ...
Selecting previously unselected package bison.
Preparing to unpack .../bison_2%3a3.0.4.dfsg-1_amd64.deb ...
Unpacking bison (2:3.0.4.dfsg-1) ...
Selecting previously unselected package libcap-ng-dev.
Preparing to unpack .../libcap-ng-dev_0.7.7-1_amd64.deb ...
Unpacking libcap-ng-dev (0.7.7-1) ...
Selecting previously unselected package libcap-ng-utils.
Preparing to unpack .../libcap-ng-utils_0.7.7-1_amd64.deb ...
Unpacking libcap-ng-utils (0.7.7-1) ...
Selecting previously unselected package libnspr4:amd64.
Preparing to unpack .../libnspr4_2%3a4.13.1-0ubuntu0.16.04.1_amd64.deb ...
Unpacking libnspr4:amd64 (2:4.13.1-0ubuntu0.16.04.1) ...
Selecting previously unselected package libnss3-nssdb.
Preparing to unpack .../libnss3-nssdb_2%3a3.28.4-0ubuntu0.16.04.9_all.deb ...
Unpacking libnss3-nssdb (2:3.28.4-0ubuntu0.16.04.9) ...
Selecting previously unselected package libnss3:amd64.
Preparing to unpack .../libnss3_2%3a3.28.4-0ubuntu0.16.04.9_amd64.deb ...
Unpacking libnss3:amd64 (2:3.28.4-0ubuntu0.16.04.9) ...
Selecting previously unselected package libcurl3-nss:amd64.
Preparing to unpack .../libcurl3-nss_7.47.0-1ubuntu2.14_amd64.deb ...
Unpacking libcurl3-nss:amd64 (7.47.0-1ubuntu2.14) ...
Selecting previously unselected package libcurl4-nss-dev:amd64.
Preparing to unpack .../libcurl4-nss-dev_7.47.0-1ubuntu2.14_amd64.deb ...
Unpacking libcurl4-nss-dev:amd64 (7.47.0-1ubuntu2.14) ...
Selecting previously unselected package libevent-core-2.0-5:amd64.
Preparing to unpack .../libevent-core-2.0-5_2.0.21-stable-2ubuntu0.16.04.1_amd64.deb ...
Unpacking libevent-core-2.0-5:amd64 (2.0.21-stable-2ubuntu0.16.04.1) ...
Selecting previously unselected package libevent-extra-2.0-5:amd64.
Preparing to unpack .../libevent-extra-2.0-5_2.0.21-stable-2ubuntu0.16.04.1_amd64.deb ...
Unpacking libevent-extra-2.0-5:amd64 (2.0.21-stable-2ubuntu0.16.04.1) ...
Selecting previously unselected package libevent-pthreads-2.0-5:amd64.
Preparing to unpack .../libevent-pthreads-2.0-5_2.0.21-stable-2ubuntu0.16.04.1_amd64.deb ...
Unpacking libevent-pthreads-2.0-5:amd64 (2.0.21-stable-2ubuntu0.16.04.1) ...
Selecting previously unselected package libevent-openssl-2.0-5:amd64.
Preparing to unpack .../libevent-openssl-2.0-5_2.0.21-stable-2ubuntu0.16.04.1_amd64.deb ...
Unpacking libevent-openssl-2.0-5:amd64 (2.0.21-stable-2ubuntu0.16.04.1) ...
Selecting previously unselected package libevent-dev.
Preparing to unpack .../libevent-dev_2.0.21-stable-2ubuntu0.16.04.1_amd64.deb ...
Unpacking libevent-dev (2.0.21-stable-2ubuntu0.16.04.1) ...
Selecting previously unselected package libnspr4-dev.
Preparing to unpack .../libnspr4-dev_2%3a4.13.1-0ubuntu0.16.04.1_amd64.deb ...
Unpacking libnspr4-dev (2:4.13.1-0ubuntu0.16.04.1) ...
Selecting previously unselected package libnss3-dev:amd64.
Preparing to unpack .../libnss3-dev_2%3a3.28.4-0ubuntu0.16.04.9_amd64.deb ...
Unpacking libnss3-dev:amd64 (2:3.28.4-0ubuntu0.16.04.9) ...
Selecting previously unselected package libnss3-tools.
Preparing to unpack .../libnss3-tools_2%3a3.28.4-0ubuntu0.16.04.9_amd64.deb ...
Unpacking libnss3-tools (2:3.28.4-0ubuntu0.16.04.9) ...
Selecting previously unselected package libpam0g-dev:amd64.
Preparing to unpack .../libpam0g-dev_1.1.8-3.2ubuntu2.1_amd64.deb ...
Unpacking libpam0g-dev:amd64 (1.1.8-3.2ubuntu2.1) ...
Selecting previously unselected package libpcre16-3:amd64.
Preparing to unpack .../libpcre16-3_2%3a8.38-3.1_amd64.deb ...
Unpacking libpcre16-3:amd64 (2:8.38-3.1) ...
Selecting previously unselected package libpcre32-3:amd64.
Preparing to unpack .../libpcre32-3_2%3a8.38-3.1_amd64.deb ...
Unpacking libpcre32-3:amd64 (2:8.38-3.1) ...
Selecting previously unselected package libpcre3-dev:amd64.
Preparing to unpack .../libpcre3-dev_2%3a8.38-3.1_amd64.deb ...
Unpacking libpcre3-dev:amd64 (2:8.38-3.1) ...
Selecting previously unselected package libsepol1-dev:amd64.
Preparing to unpack .../libsepol1-dev_2.4-2_amd64.deb ...
Unpacking libsepol1-dev:amd64 (2.4-2) ...
Selecting previously unselected package libselinux1-dev:amd64.
Preparing to unpack .../libselinux1-dev_2.4-3build2_amd64.deb ...
Unpacking libselinux1-dev:amd64 (2.4-3build2) ...
Selecting previously unselected package pkg-config.
Preparing to unpack .../pkg-config_0.29.1-0ubuntu1_amd64.deb ...
Unpacking pkg-config (0.29.1-0ubuntu1) ...
Selecting previously unselected package ppp.
Preparing to unpack .../ppp_2.4.7-1+2ubuntu1.16.04.1_amd64.deb ...
Unpacking ppp (2.4.7-1+2ubuntu1.16.04.1) ...
Selecting previously unselected package xl2tpd.
Preparing to unpack .../xl2tpd_1.3.6+dfsg-4ubuntu0.16.04.2_amd64.deb ...
Unpacking xl2tpd (1.3.6+dfsg-4ubuntu0.16.04.2) ...
Processing triggers for install-info (6.1.0.dfsg.1-5) ...
Processing triggers for man-db (2.7.5-1) ...
Processing triggers for libc-bin (2.23-0ubuntu11) ...
Processing triggers for ureadahead (0.100.0-19.1) ...
Processing triggers for systemd (229-4ubuntu21.22) ...
Setting up m4 (1.4.17-5) ...
Setting up libfl-dev:amd64 (2.6.0-11) ...
Setting up flex (2.6.0-11) ...
Setting up libpcrecpp0v5:amd64 (2:8.38-3.1) ...
Setting up libbison-dev:amd64 (2:3.0.4.dfsg-1) ...
Setting up bison (2:3.0.4.dfsg-1) ...
update-alternatives: using /usr/bin/bison.yacc to provide /usr/bin/yacc (yacc) in auto mode
Setting up libcap-ng-dev (0.7.7-1) ...
Setting up libcap-ng-utils (0.7.7-1) ...
Setting up libnspr4:amd64 (2:4.13.1-0ubuntu0.16.04.1) ...
Setting up libevent-core-2.0-5:amd64 (2.0.21-stable-2ubuntu0.16.04.1) ...
Setting up libevent-extra-2.0-5:amd64 (2.0.21-stable-2ubuntu0.16.04.1) ...
Setting up libevent-pthreads-2.0-5:amd64 (2.0.21-stable-2ubuntu0.16.04.1) ...
Setting up libevent-openssl-2.0-5:amd64 (2.0.21-stable-2ubuntu0.16.04.1) ...
Setting up libevent-dev (2.0.21-stable-2ubuntu0.16.04.1) ...
Setting up libnspr4-dev (2:4.13.1-0ubuntu0.16.04.1) ...
Setting up libpam0g-dev:amd64 (1.1.8-3.2ubuntu2.1) ...
Setting up libpcre16-3:amd64 (2:8.38-3.1) ...
Setting up libpcre32-3:amd64 (2:8.38-3.1) ...
Setting up libpcre3-dev:amd64 (2:8.38-3.1) ...
Setting up libsepol1-dev:amd64 (2.4-2) ...
Setting up libselinux1-dev:amd64 (2.4-3build2) ...
Setting up pkg-config (0.29.1-0ubuntu1) ...
Setting up ppp (2.4.7-1+2ubuntu1.16.04.1) ...
Setting up xl2tpd (1.3.6+dfsg-4ubuntu0.16.04.2) ...
Setting up libnss3-nssdb (2:3.28.4-0ubuntu0.16.04.9) ...
Setting up libnss3:amd64 (2:3.28.4-0ubuntu0.16.04.9) ...
Setting up libcurl3-nss:amd64 (7.47.0-1ubuntu2.14) ...
Setting up libcurl4-nss-dev:amd64 (7.47.0-1ubuntu2.14) ...
Setting up libnss3-dev:amd64 (2:3.28.4-0ubuntu0.16.04.9) ...
Setting up libnss3-tools (2:3.28.4-0ubuntu0.16.04.9) ...
Processing triggers for libc-bin (2.23-0ubuntu11) ...
Processing triggers for ureadahead (0.100.0-19.1) ...
Processing triggers for systemd (229-4ubuntu21.22) ...

## Installing Fail2Ban to protect SSH...

Reading package lists...
Building dependency tree...
Reading state information...
The following additional packages will be installed:
  python3-pyinotify whois
Suggested packages:
  mailx monit python-pyinotify-doc
The following NEW packages will be installed:
  fail2ban python3-pyinotify whois
0 upgraded, 3 newly installed, 0 to remove and 59 not upgraded.
Need to get 286 kB of archives.
After this operation, 1,474 kB of additional disk space will be used.
Get:1 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial/universe amd64 fail2ban all 0.9.3-1 [227 kB]
Get:2 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial/main amd64 python3-pyinotify all 0.9.6-0fakesync1 [24.7 kB]
Get:3 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial/main amd64 whois amd64 5.2.11 [34.0 kB]
Fetched 286 kB in 0s (605 kB/s)
Selecting previously unselected package fail2ban.
(Reading database ... 59042 files and directories currently installed.)
Preparing to unpack .../fail2ban_0.9.3-1_all.deb ...
Unpacking fail2ban (0.9.3-1) ...
Selecting previously unselected package python3-pyinotify.
Preparing to unpack .../python3-pyinotify_0.9.6-0fakesync1_all.deb ...
Unpacking python3-pyinotify (0.9.6-0fakesync1) ...
Selecting previously unselected package whois.
Preparing to unpack .../whois_5.2.11_amd64.deb ...
Unpacking whois (5.2.11) ...
Processing triggers for man-db (2.7.5-1) ...
Processing triggers for ureadahead (0.100.0-19.1) ...
Processing triggers for systemd (229-4ubuntu21.22) ...
Setting up fail2ban (0.9.3-1) ...
Setting up python3-pyinotify (0.9.6-0fakesync1) ...
Setting up whois (5.2.11) ...
Processing triggers for ureadahead (0.100.0-19.1) ...
Processing triggers for systemd (229-4ubuntu21.22) ...

## Compiling and installing Libreswan...

2020-01-01 22:27:11 URL:https://codeload.github.com/libreswan/libreswan/tar.gz/v3.29 [3848730] -> "libreswan-3.29.tar.gz" [1]
Reading package lists...
Building dependency tree...
Reading state information...
The following additional packages will be installed:
  libpam-systemd libsystemd0 systemd
Suggested packages:
  systemd-ui systemd-container
The following NEW packages will be installed:
  libsystemd-dev
The following packages will be upgraded:
  libpam-systemd libsystemd0 systemd
3 upgraded, 1 newly installed, 0 to remove and 56 not upgraded.
Need to get 4,255 kB of archives.
After this operation, 396 kB of additional disk space will be used.
Get:1 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libpam-systemd amd64 229-4ubuntu21.23 [115 kB]
Get:2 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libsystemd0 amd64 229-4ubuntu21.23 [204 kB]
Get:3 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 systemd amd64 229-4ubuntu21.23 [3,777 kB]
Get:4 http://us-west-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libsystemd-dev amd64 229-4ubuntu21.23 [159 kB]
Fetched 4,255 kB in 0s (18.4 MB/s)
(Reading database ... 59432 files and directories currently installed.)
Preparing to unpack .../libpam-systemd_229-4ubuntu21.23_amd64.deb ...
Unpacking libpam-systemd:amd64 (229-4ubuntu21.23) over (229-4ubuntu21.22) ...
Preparing to unpack .../libsystemd0_229-4ubuntu21.23_amd64.deb ...
Unpacking libsystemd0:amd64 (229-4ubuntu21.23) over (229-4ubuntu21.22) ...
Processing triggers for man-db (2.7.5-1) ...
Processing triggers for libc-bin (2.23-0ubuntu11) ...
Setting up libsystemd0:amd64 (229-4ubuntu21.23) ...
Processing triggers for libc-bin (2.23-0ubuntu11) ...
(Reading database ... 59432 files and directories currently installed.)
Preparing to unpack .../systemd_229-4ubuntu21.23_amd64.deb ...
Unpacking systemd (229-4ubuntu21.23) over (229-4ubuntu21.22) ...
Processing triggers for ureadahead (0.100.0-19.1) ...
Processing triggers for dbus (1.10.6-1ubuntu3.4) ...
Processing triggers for man-db (2.7.5-1) ...
Setting up systemd (229-4ubuntu21.23) ...
addgroup: The group `systemd-journal' already exists as a system group. Exiting.
[/usr/lib/tmpfiles.d/var.conf:14] Duplicate line for path "/var/log", ignoring.
Selecting previously unselected package libsystemd-dev:amd64.
(Reading database ... 59432 files and directories currently installed.)
Preparing to unpack .../libsystemd-dev_229-4ubuntu21.23_amd64.deb ...
Unpacking libsystemd-dev:amd64 (229-4ubuntu21.23) ...
Processing triggers for man-db (2.7.5-1) ...
Setting up libpam-systemd:amd64 (229-4ubuntu21.23) ...
Setting up libsystemd-dev:amd64 (229-4ubuntu21.23) ...
a - x509dn.o
a - asn1.o
a - oid.o
a - constants.o
a - alloc.o
a - diag.o
a - id.o
a - initaddr.o
a - initsaid.o
a - initsubnet.o
a - keyblobtoid.o
a - lex.o
a - lswconf.o
a - lswfips.o
a - rangetosubnet.o
a - sameaddr.o
a - secrets.o
a - subnettot.o
a - subnettypeof.o
a - ttoaddr.o
a - ttodata.o
a - ttoprotoport.o
a - ttosa.o
a - ttosubnet.o
a - ttoul.o
a - secitem_chunk.o
a - base64_pubkey.o
a - lswnss.o
a - lsw_passert_fail.o
a - alg_byname.o
a - certs.o
a - addr_lookup.o
a - log_ip.o
a - af_info.o
a - fd.o
a - kernel_alg.o
a - kernel_sadb.o
a - role.o
a - addrtot.o
a - addrtypeof.o
a - anyaddr.o
a - datatot.o
a - goodmask.o
a - satot.o
a - ultot.o
a - proposals.o
a - v1_proposals.o
a - v2_proposals.o
a - esp_info.o
a - ah_info.o
a - ike_info.o
a - ckaid.o
a - chunk.o
a - shunk.o
a - ip_address.o
a - ip_endpoint.o
a - ip_range.o
a - ip_subnet.o
a - lmod.o
a - lset.o
a - deltatime.o
a - realtime.o
a - monotime.o
a - debug.o
a - impair.o
a - keywords.o
a - dbg.o
a - DBG_dump.o
a - DBG_log.o
a - log_to_log.o
a - libreswan_exit_log_errno.o
a - libreswan_log_errno.o
a - libreswan_pexpect.o
a - libreswan_pexpect_log.o
a - libreswan_bad_case.o
a - rate_log.o
a - libreswan_log.o
a - libreswan_log_rc.o
a - fmtbuf.o
a - lswlog.o
a - lswlog_dbg.o
a - lswlog_nss_error.o
a - lswlog_nss_ckm.o
a - lswlog_nss_ckf.o
a - lswlog_nss_cka.o
a - lswlog_nss_secitem.o
a - lswlog_source_line.o
a - lswlog_sanitized.o
a - lswlog_errno.o
a - lswlog_bytes.o
a - lswlog_enum_lset_short.o
a - lswlog_realtime.o
a - lswlog_monotime.o
a - lswlog_to_file_stream.o
a - lswlog_pexpect.o
a - lswlog_passert.o
a - ike_alg.o
a - ike_alg_test.o
a - ike_alg_encrypt_chacha20_poly1305.o
a - ike_alg_encrypt_nss_aead_ops.o
a - ike_alg_encrypt_nss_cbc_ops.o
a - ike_alg_encrypt_nss_ctr_ops.o
a - ike_alg_encrypt_nss_gcm_ops.o
a - ike_alg_desc.o
a - ike_alg_3des.o
a - ike_alg_aes.o
a - ike_alg_camellia.o
a - ike_alg_dh.o
a - ike_alg_md5.o
a - ike_alg_none.o
a - ike_alg_serpent.o
a - ike_alg_sha1.o
a - ike_alg_sha2.o
a - ike_alg_twofish.o
a - nss_copies.o
a - sanitizestring.o
a - pfkey_sock.o
a - pfkey_error.o
a - pfkey_v2_build.o
a - pfkey_v2_ext_bits.o
a - pfkey_v2_parse.o
a - pfkey_v2_debug.o
a - /opt/src/libreswan-3.29/OBJ.linux.x86_64/lib/libswan/version.o
a - serpent.o
a - serpent_cbc.o
a - twofish.o
a - twofish_cbc.o
a - whacklib.o
a - aliascomp.o
a - confread.o
a - confwrite.o
a - starterwhack.o
a - starterlog.o
a - parser.tab.o
a - lex.yy.o
a - keywords.o
a - interfaces.o
a - lswlog.o
a - libreswan_exit.o
IN ipsec.conf.in -> ../../OBJ.linux.x86_64/programs/configs/ipsec.conf
IN ipsec.secrets.in -> ../../OBJ.linux.x86_64/programs/configs/ipsec.secrets
IN clear.in -> ../../OBJ.linux.x86_64/programs/configs/clear
IN clear-or-private.in -> ../../OBJ.linux.x86_64/programs/configs/clear-or-private
IN private-or-clear.in -> ../../OBJ.linux.x86_64/programs/configs/private-or-clear
IN private.in -> ../../OBJ.linux.x86_64/programs/configs/private
IN block.in -> ../../OBJ.linux.x86_64/programs/configs/block
IN portexcludes.conf.in -> ../../OBJ.linux.x86_64/programs/configs/portexcludes.conf
IN _plutorun.in -> ../../OBJ.linux.x86_64/programs/_plutorun/_plutorun
IN _stackmanager.in -> ../../OBJ.linux.x86_64/programs/_stackmanager/_stackmanager
IN _secretcensor.in -> ../../OBJ.linux.x86_64/programs/_secretcensor/_secretcensor
IN _updown.in -> ../../OBJ.linux.x86_64/programs/_updown/_updown
IN _unbound-hook.in -> ../../OBJ.linux.x86_64/programs/_unbound-hook/_unbound-hook
IN auto.in -> ../../OBJ.linux.x86_64/programs/auto/auto
IN barf.in -> ../../OBJ.linux.x86_64/programs/barf/barf
IN verify.in -> ../../OBJ.linux.x86_64/programs/verify/verify
IN show.in -> ../../OBJ.linux.x86_64/programs/show/show
IN ipsec.in -> ../../OBJ.linux.x86_64/programs/ipsec/ipsec
IN look.in -> ../../OBJ.linux.x86_64/programs/look/look
IN newhostkey.in -> ../../OBJ.linux.x86_64/programs/newhostkey/newhostkey
IN setup.in -> ../../OBJ.linux.x86_64/programs/setup/setup
IN _updown.netkey.in -> ../../OBJ.linux.x86_64/programs/_updown.netkey/_updown.netkey
IN ipsec.service.in -> ../../OBJ.linux.x86_64/initsystems/systemd/ipsec.service
IN libreswan.conf.in -> ../../OBJ.linux.x86_64/initsystems/systemd/libreswan.conf
../../OBJ.linux.x86_64/programs/pluto/pluto -> /usr/local/libexec/ipsec/pluto
../../OBJ.linux.x86_64/programs/whack/whack -> /usr/local/libexec/ipsec/whack
../../OBJ.linux.x86_64/programs/addconn/addconn -> /usr/local/libexec/ipsec/addconn
../../OBJ.linux.x86_64/programs/configs/ipsec.conf -> /etc/ipsec.conf
../../OBJ.linux.x86_64/programs/configs/ipsec.secrets -> /etc/ipsec.secrets
../../OBJ.linux.x86_64/programs/configs/ipsec.conf -> /usr/local/share/doc/libreswan/ipsec.conf-sample
../../OBJ.linux.x86_64/programs/configs/ipsec.secrets -> /usr/local/share/doc/libreswan/ipsec.secrets-sample
../../OBJ.linux.x86_64/programs/configs/clear -> /etc/ipsec.d/policies/clear
../../OBJ.linux.x86_64/programs/configs/clear-or-private -> /etc/ipsec.d/policies/clear-or-private
../../OBJ.linux.x86_64/programs/configs/private-or-clear -> /etc/ipsec.d/policies/private-or-clear
../../OBJ.linux.x86_64/programs/configs/private -> /etc/ipsec.d/policies/private
../../OBJ.linux.x86_64/programs/configs/block -> /etc/ipsec.d/policies/block
../../OBJ.linux.x86_64/programs/configs/portexcludes.conf -> /etc/ipsec.d/policies/portexcludes.conf
../../OBJ.linux.x86_64/programs/_plutorun/_plutorun -> /usr/local/libexec/ipsec/_plutorun
../../OBJ.linux.x86_64/programs/_stackmanager/_stackmanager -> /usr/local/libexec/ipsec/_stackmanager
../../OBJ.linux.x86_64/programs/_secretcensor/_secretcensor -> /usr/local/libexec/ipsec/_secretcensor
../../OBJ.linux.x86_64/programs/_updown/_updown -> /usr/local/libexec/ipsec/_updown
../../OBJ.linux.x86_64/programs/_unbound-hook/_unbound-hook -> /usr/local/libexec/ipsec/_unbound-hook
../../OBJ.linux.x86_64/programs/auto/auto -> /usr/local/libexec/ipsec/auto
../../OBJ.linux.x86_64/programs/barf/barf -> /usr/local/libexec/ipsec/barf
../../OBJ.linux.x86_64/programs/verify/verify -> /usr/local/libexec/ipsec/verify
../../OBJ.linux.x86_64/programs/show/show -> /usr/local/libexec/ipsec/show
../../OBJ.linux.x86_64/programs/ipsec/ipsec -> /usr/local/sbin/ipsec
../../OBJ.linux.x86_64/programs/look/look -> /usr/local/libexec/ipsec/look
../../OBJ.linux.x86_64/programs/newhostkey/newhostkey -> /usr/local/libexec/ipsec/newhostkey
../../OBJ.linux.x86_64/programs/rsasigkey/rsasigkey -> /usr/local/libexec/ipsec/rsasigkey
../../OBJ.linux.x86_64/programs/setup/setup -> /usr/local/libexec/ipsec/setup
../../OBJ.linux.x86_64/programs/showhostkey/showhostkey -> /usr/local/libexec/ipsec/showhostkey
../../OBJ.linux.x86_64/programs/readwriteconf/readwriteconf -> /usr/local/libexec/ipsec/readwriteconf
../../OBJ.linux.x86_64/programs/_import_crl/_import_crl -> /usr/local/libexec/ipsec/_import_crl
../../OBJ.linux.x86_64/programs/algparse/algparse -> /usr/local/libexec/ipsec/algparse
../../OBJ.linux.x86_64/programs/cavp/cavp -> /usr/local/libexec/ipsec/cavp
../../OBJ.linux.x86_64/programs/_updown.netkey/_updown.netkey -> /usr/local/libexec/ipsec/_updown.netkey
running: systemctl --system daemon-reload
running: systemd-tmpfiles --create /usr/lib/tmpfiles.d/libreswan.conf
DESTDIR=''
************************** WARNING ***********************************
The ipsec service is currently disabled. To enable this service issue:
 systemctl enable ipsec.service
**********************************************************************
../../OBJ.linux.x86_64/testing/enumcheck/enumcheck -> /usr/local/libexec/ipsec/enumcheck
../../OBJ.linux.x86_64/testing/ipcheck/ipcheck -> /usr/local/libexec/ipsec/ipcheck
../../OBJ.linux.x86_64/testing/fmtcheck/fmtcheck -> /usr/local/libexec/ipsec/fmtcheck
../../OBJ.linux.x86_64/testing/timecheck/timecheck -> /usr/local/libexec/ipsec/timecheck

## Creating VPN configuration...


## Updating sysctl settings...


## Updating IPTables rules...


## Enabling services on boot...


## Starting services...



```
