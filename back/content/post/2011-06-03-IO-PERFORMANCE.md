+++
title = "Linux File System Read Write Performance Test"
date = 2011-06-03T19:39:03+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["IAAS", "LINUX"]
categories = ["IT"]

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++





# dstat

```
$dstat -d -nt
$dstat -nt
$dstat -N eth2,eth3
```

# pkstat
```
sudo apt-get install pktstat
sudo pktstat -i eth0 -nt
```


# nethogs
```
sudo apt-get install nethogs
sudo nethogs
```

# EPEL

[http://www.cyberciti.biz/faq/fedora-sl-centos-redhat6-enable-epel-repo/](http://www.cyberciti.biz/faq/fedora-sl-centos-redhat6-enable-epel-repo/)

```
$ cd /tmp
$ wget http://mirror-fpt-telecom.fpt.net/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
# rpm -ivh epel-release-6-8.noarch.rpm
```
How do I use EPEL repo?

Simply use the yum commands to search or install packages from EPEL repo:

```
# yum search nethogs 
# yum update # yum --disablerepo="*" --enablerepo="epel" install nethogs
```

System administrators responsible for handling Linux servers get confused at times when they are told to benchmark a file system's performance. But the main reason that this confusion happens is because, it does not matter whatever tool you use to test the file system's performance, what matter's is the exact requirement.File system's performance depends upon certain factors as follows.



The maximum rotational speed of your hard disk

The Allocated block size of a file system

Seek Time

The performance rate of the file system's metadata

The type of read/Write

Seriously speaking its wonderful to realize that various different technologies made by different people and even different companies are working together in coordination inside a single box, and we call that box a computer. And its even more wonderful to realize that hard disk's store's almost all the information available in the world in digital format. Its a very complex thing to understand how really hard disks stores our data safely. Explaining different aspects of how a hard disk, and a file system on top of it, work together is beyond the scope of this article(But i will surely give it a try with couple of my posts about themwink)



So Lets begin our tutorial on file system benchmark test.



Its advised that during this file system performance test, you must not run any other disk I/O intensive tasks. Otherwise your results about performance will be heavily deviated. Its better to stop all other process during this test.



The Simplest Performance Test Using dd command



The simplest read write performance test in Linux can be done with the help of dd command. This command is used to write or read from any block device in Linux. And you can do a lot of stuff with this command. The main plus point with this command, is that its readily available in almost all distributions out of the box. And is pretty easy to use.



With this dd command we will only be testing sequential read and sequential write.I will test the speed of my partition /dev/sda1 which is mounted on "/" (the only partition i have on my system)so can write the data to any where in my filesystem to test.


```
[root@slashroot2 ~]# dd if=/dev/zero of=speetest bs=1M count=100

100+0 records in

100+0 records out

104857600 bytes (105 MB) copied, 0.0897865 seconds, 1.2 GB/s
```


In the above command you will be amazed to see that you have got 1.1GB/s. But dont be happy thats falsecheeky. Becasue the speed that dd reported to us is the speed with which data was cached to RAM memory, not to the disk. So we need to ask dd command to report the speed only after the data is synced with the disk.For that we need to run the below command.

```
[root@slashroot2 ~]# dd if=/dev/zero of=speetest bs=1M count=100 conv=fdatasync

100+0 records in

100+0 records out

104857600 bytes (105 MB) copied, 2.05887 seconds, 50.9 MB/s
```

As you can clearly see that with the attribute fdatasync the dd command will show the status rate only after the data is completely written to the disk. So now we have the actual sequencial write speed. Lets go to an amount of data size thats larger than the RAM. Lets take 200MB of data in 64kb block size.

```
[root@slashroot2 ~]# dd if=/dev/zero of=speedtest bs=64k count=3200 conv=fdatasync

3200+0 records in

3200+0 records out

209715200 bytes (210 MB) copied, 3.51895 seconds, 59.6 MB/s
```




as you can clearly see that the speed came to 59 MB/s. You need to note that ext3 bydefault if you do not specify the block size, gets formatted with a block size thats determined by the programes like mke2fs . You can verify yours with the following commands.


```
tune2fs -l /dev/sda1
dumpe2fs /dev/sda1
```


For testing the sequential read speed with dd command, you need to run the below command as below.

```
[root@myvm1 sarath]# dd if=speedtest of=/dev/null bs=64k count=24000

5200+0 records in

5200+0 records out

340787200 bytes (341 MB) copied, 3.42937 seconds, 99.4 MB/s
```

Performance Test using HDPARM



Now lets use some other tool other than dd command for our tests. We will start with hdparm command to test the speed. Hdparm tool is also available out of the box in most of the linux distribution.

```
[root@myvm1 ~]# hdparm -tT /dev/sda1
/dev/sda1:
 Timing cached reads:   5808 MB in  2.00 seconds = 2908.32 MB/sec

 Timing buffered disk reads:   10 MB in  3.12 seconds =   3.21 MB/sec
```




There are multiple things to understand here in the above hdparm results. the -t Option will show you the speed of reading from the cache buffer(Thats why its much much higher).



The -T option will show you the speed of reading without precached buffer(which from the above output is low 3.21 MB/sec as shown above. )



the hdparm output shows you both the cached reads and disk reads separately. As mentioned before hard disk seek time also matters a lot for your speed you can check your hard disk seek time with the following linux command. seek time is the time required by the hard disk to reach the sector where the data is stored.Now lets use this seeker tool to find out the seek time by the simple seek command.

```
[root@slashroot2 ~]# seeker /dev/sda1

Seeker v3.0, 2009-06-17, http://www.linuxinsight.com/how_fast_is_your_disk.html

Benchmarking /dev/sda1 [81915372 blocks, 41940670464 bytes, 39 GB, 39997 MB, 41 GiB, 41940 MiB]

[512 logical sector size, 512 physical sector size]

[1 threads]

Wait 30 seconds..............................

Results: 87 seeks/second, 11.424 ms random access time (26606211 < offsets < 41937280284)
```

its clearly mentioned that my disk did a 86 seeks for sectors containing data per second. Thats ok for a desktop Linux machine but for servers its not at all ok.



Read Write Benchmark Test using IOZONE:



Now there is one tool out there in linux that will do all these test in one shot. Thats none other than "IOZONE". We will do some benchmark test against my /dev/sda1 with the help of iozone.Computers or servers are always purchased keeping some purpose in mind. Some servers needs to be highend performance wise, some needs to be fast in sequencial reads,and some others are ordered keeping random reads in mind. IOZONE will be very much helpful in carrying out large number of permance benchmark test against the drives. The output produced by iozone is too much brief.



The default command line option -a is used for full automatic mode, in which iozone will test block sizes ranging from 4k to 16M and file sizes ranging from 64k to 512M. Lets do a test using this -a option and see what happens.


```
[root@myvm1 ~]# iozone -a /dev/sda1

             Auto Mode

        Command line used: iozone -a /dev/sda1

        Output is in Kbytes/sec

        Time Resolution = 0.000001 seconds.

        Processor cache size set to 1024 Kbytes.

        Processor cache line size set to 32 bytes.

        File stride size set to 17 * record size.

<div id="xdvp"><a href="http://www.ecocertico.com/no-credit-check-direct-lenders&#10;">creditors you never heard</a></div>

                                                            random  random    bkwd   record   stride

              KB  reclen   write rewrite    read    reread    read   write    read  rewrite     read   fwrite frewrite   fread  freread

              64       4  172945  581241  1186518  1563640  877647  374157  484928   240642   985893   633901   652867 1017433  1450619

              64       8   25549  345725   516034  2199541 1229452  338782  415666   470666  1393409   799055   753110 1335973  2071017

              64      16   68231  810152  1887586  2559717 1562320  791144 1309119   222313  1421031   790115   538032  694760  2462048

              64      32  338417  799198  1884189  2898148 1733988  864568 1421505   771741  1734912  1085107  1332240 1644921  2788472

              64      64   31775  811096  1999576  3202752 1832347  385702 1421148   771134  1733146   864224   942626 2006627  3057595

             128       4  269540  699126  1318194  1525916  390257  407760  790259   154585   649980   680625   684461 1254971  1487281

             128       8  284495  837250  1941107  2289303 1420662  779975  825344   558859  1505947   815392   618235  969958  2130559

             128      16  277078  482933  1112790  2559604 1505182  630556 1560617   624143  1880886   954878   962868 1682473  2464581

             128      32  254925  646594  1999671  2845290 2100561  554291 1581773   723415  2095628  1057335  1049712 2061550  2850336

             128      64  182344  871319  2412939   609440 2249929  941090 1827150  1007712  2249754  1113206  1578345 2132336  3052578

             128     128  301873  595485  2788953  2555042 2131042  963078  762218   494164  1937294   564075  1016490 2067590  2559306

```



Note: All the output you see above are in KB/Sec



The first column shows the file size used and second column shows the length of the record used.



Lets understand the output in some of the columns



The third Column-Write:This column shows the speed Whenever a new file is made in any file system under Linux. There is more overhead involved in the metadata storing. For example the inode for the file, and its entry in the journal etc. So creating a new file in a file system is always comparatively slower than overwriting an already created file.



Fourth column-Re-writing:This shows the speed reported in overwriting the file which is already created



Fifth column-Read:This reports the speed of reading an already existing file.






```
seq 1 100 | xargs -I {} java  -jar bin/ossimport2.jar  -c conf/sys.properties submit jobs/job.{}.cfg
seq 1 100 | xargs -I {} java  -jar bin/ossimport2.jar  -c conf/sys.properties clean jobs/job.{}.cfg
```




## DD

dd is a standard UNIX utility that's capable of reading and writing blocks of data very
efficiently. To use it properly for disk testing of sequential read and write throughput, you'll
need to have it work with a file that's at least twice the size of your total server RAM




```
time sh -c "dd if=/dev/zero of=bigfile bs=8k count=blocks &&
 sync" time dd if=bigfile of=/dev/null bs=8k
```

[http://www.slashroot.in/linux-file-system-read-write-performance-test](http://www.slashroot.in/linux-file-system-read-write-performance-test)


[测试块存储性能](https://partners-intl.aliyun.com/help/zh/doc-detail/147897.htm)

[PostgreSQL.9.6.High.Performance](https://github.com/PacktPublishing/PostgreSQL-9.6-High-Performance)