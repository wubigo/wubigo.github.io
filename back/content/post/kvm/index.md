+++
title = "Kvm"
date = 2013-11-05T10:35:07+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["KVM", "IAAS"]
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

QEMU runs the guest code via the KVM kernel module. When working with KVM, QEMU also does I/O emulation, I/O device setup, live migration, and so on.
QEMU opens the device file (/dev/kvm) exposed by the KVM kernel module and executes ioctls()on it


KVM exposesa device file called /dev/kvmto applications to make use of the ioctls()provided. QEMU makes use of this device file to talk with KVM and to create, initialize, and manage the kernel mode context of virtual machines



The KVM or kernel-based virtual machine is not a full hypervisor; however, with the help of QEMU and emulators (a slightly modified QEMU for I/O device emulation and BIOS), it can become one. KVM needs hardware virtualization-capable processors to operate. Using these capabilities, KVM turns the standard Linux kernel into a hypervisor. When KVM runs virtual machines, every VM is a normal Linux process, which can obviously be scheduled to run on a CPU by the host kernel as with any other process present in the host kernel





# KVM APIs

there are three main types of ioctl()s
Three sets of ioctl make up the KVM API. The KVM API is a set of ioctls that are issued to control various aspects of a virtual machine. These ioctls belong to three classes:
System ioctls: These query and set global attributes, which affect the whole KVM subsystem. In addition, a system ioctl is used to create virtual machines.
VM ioctls: These query and set attributes that affect an entire virtual machine—for example, memory layout. In addition, a VM ioctl is used to create virtual CPUs (vCPUs). It runs VM ioctls from the same process (address space) that was used to create the VM.
Vcpu ioctls: These query and set attributes that control the operation of a single virtual CPU. They run vCPU ioctls from the same thread that was used to create the vCPU.
