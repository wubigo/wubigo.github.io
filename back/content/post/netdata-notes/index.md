+++
title = "Netdata notes"
date = 2018-05-05T06:46:41+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["MONITOR"]
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

## INSTALL

- docker

```
docker run -d --name=netdata \
  -p 19999:19999 \
  -v /etc/passwd:/host/etc/passwd:ro \
  -v /etc/group:/host/etc/group:ro \
  -v /proc:/host/proc:ro \
  -v /sys:/host/sys:ro \
  -v /etc/os-release:/host/etc/os-release:ro \
  --cap-add SYS_PTRACE \
  --security-opt apparmor=unconfined \
  netdata/netdata
```


- script

```
bash <(curl -Ss https://my-netdata.io/kickstart.sh) --stable-channel --disable-telemetry



Attempting another netdata start using command 'systemctl start netdata'
[/tmp/netdata-kickstart-uytL3g/netdata-v1.21.1]# systemctl start netdata
 OK

 OK  netdata started!

Downloading default configuration from netdata...
[/tmp/netdata-kickstart-uytL3g/netdata-v1.21.1]# curl -sSL --connect-timeout 10 --retry 3 http://localhost:19999/netdata.conf
 OK

[/tmp/netdata-kickstart-uytL3g/netdata-v1.21.1]# mv /etc/netdata/netdata.conf.new /etc/netdata/netdata.conf
 OK

 OK  New configuration saved for you to edit at /etc/netdata/netdata.conf

[/tmp/netdata-kickstart-uytL3g/netdata-v1.21.1]# chmod 0644 /etc/netdata/netdata.conf
 OK

 --- Check KSM (kernel memory deduper) ---

Memory de-duplication instructions

You have kernel memory de-duper (called Kernel Same-page Merging,
or KSM) available, but it is not currently enabled.

To enable it run:

    echo 1 >/sys/kernel/mm/ksm/run
    echo 1000 >/sys/kernel/mm/ksm/sleep_millisecs

If you enable it, you will save 40-60% of netdata memory.

 --- Check version.txt ---
 --- Check apps.plugin ---
 --- Copy uninstaller ---
 --- Basic netdata instructions ---

netdata by default listens on all IPs on port 19999,
so you can access it with:

  http://this.machine.ip:19999/

To stop netdata run:



To start netdata run:

  systemctl start netdata

Uninstall script copied to: /usr/libexec/netdata/netdata-uninstaller.sh

 --- Installing (but not enabling) the netdata updater tool ---
Update script is located at /usr/libexec/netdata/netdata-updater.sh

 --- Check if we must enable/disable the netdata updater tool ---
Adding to cron
Auto-updating has been enabled. Updater script linked to: /etc/cron.daily/netdata-updater

netdata-updater.sh works from cron. It will trigger an email from cron
only if it fails (it should not print anything when it can update netdata).

 --- Wrap up environment set up ---
Preparing .environment file
[/tmp/netdata-kickstart-uytL3g/netdata-v1.21.1]# chmod 0644 /etc/netdata/.environment
 OK

Setting netdata.tarball.checksum to 'new_installation'



```


##  uninstall


```
sudo /usr/libexec/netdata/netdata-uninstaller.sh --yes
```