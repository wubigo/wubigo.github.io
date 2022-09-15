---
layout: post
title: File Gateway for Hybrid Architectures; Overview and Best Practices
date: 2018-03-02
tag: IaaS
---



Organizations are looking for ways to reduce their physical data center footprints, particularly for secondary workloads such as backups, files, or on-demand workloads. However, bridging data between private data centers and the public cloud comes with a unique set of challenges. Traditional data center services rely on low-latency network attached storage (NAS) and storage area network (SAN) protocols to access storage locally. Cloud-native applications are generally optimized for API access to data in scalable and durable cloud object storage, such as Amazon Simple Storage Service (Amazon S3).

A file gateway provides a simple solution for presenting one or more Amazon S3 buckets and
their objects as a mountable NFS to one or more clients on-premises.
