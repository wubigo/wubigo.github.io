+++
title = "Mysql Tuning on OS"
date = 2013-04-27T17:08:07+08:00
tags = ["SHELL", "MYSQL"]
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.

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



# Server and Operating System

- Kernel – vm.swappiness

Disables swapping completely while 1 causes the kernel to perform the minimum amount of swapping

```
# Set the swappiness value as root
echo 1 > /proc/sys/vm/swappiness
# Alternatively, using sysctl
sysctl -w vm.swappiness=1
# Verify the change
cat /proc/sys/vm/swappiness
1
# Alternatively, using sysctl
sysctl vm.swappiness
vm.swappiness = 1
```


# Filesystems – XFS/ext4/ZFS

|| FILE SIZE| mount option
:---|:---|:---
EXT4| 16TB |   noatime,data=writeback,barrier=0,nobh,errors=remount-ro
XFS|  8EiB|   defaults,nobarrier



# Disk Subsystem – I/O scheduler 

Most modern Linux distributions come with noop or deadline I/O schedulers by default, 
both providing better performance than the cfq and anticipatory ones

```
# View the I/O scheduler setting. The value in square brackets shows the running scheduler
cat /sys/block/sdb/queue/scheduler
noop deadline [cfq]
# Change the setting
sudo echo noop > /sys/block/sdb/queue/scheduler
```

# Disk Subsystem – Volume optimization

separation of OS and data partitions, not just logically but physically, will 
improve database performance. The RAID level can also have an impact: RAID-5 
should be avoided as the checksum needed to ensure integrity is costly


# System Architecture – NUMA settings


the innodb_numa_interleave option to be available, MySQL must be compiled on a NUMA-enabled Linux system