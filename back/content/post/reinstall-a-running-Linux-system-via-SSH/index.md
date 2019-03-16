+++
title = "通过SSH远程修复linux"
date = 2017-03-11T22:35:16+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["LINUX"]
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


tl;dr

```
uget https://osdn.net/projects/systemrescuecd/storage/releases/6.0.2/systemrescuecd-6.0.2.iso
sudo mount -t tmpfs  tmpfs /takeover/
sudo mount -o loop,ro -t iso9660 ~/systemrescuecd-6.0.2.iso /mnt/cd
cp -rf /mnt/cd/* /takeover/
curl -L https://www.busybox.net/downloads/binaries/1.26.2-defconfig-multiarch/busybox-x86_64 > busybox
chmod u+x /takeover/busybox
git clone https://github.com/marcan/takeover.sh.git
gcc takeover.sh/fakeinit.c -o ./fakeinit
```