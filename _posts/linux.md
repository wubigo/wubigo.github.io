# Find the latest file by modified date

find /path -printf '%T+ %p\n' | sort -r | head

# ghost systemd service

/etc/systemd/system/ghost.service
```
Running sudo command: ln -sf /var/www/ghost/system/files/ghost_localhost.service /lib/systemd/system/ghost_localhost.service
Running sudo command: systemctl daemon-reload

```

```
ls /lib/systemd/system/ghost*
sudo systemctl stop ghost_localhost
```

Admin URL
As per the SSL section above, admin.url can be used to specify a different protocol for your admin panel. It can also be used to specify a different hostname (domain name). It cannot be used to affect the path at which the admin panel is served (this is always /ghost/).

"admin": { 
  "url": "http://example.com" 
}


```
ubuntu@ip-192-168-114-240:/lib/systemd/system$ sudo systemctl disable ghost_54-169-190-39.service
Removed symlink /etc/systemd/system/multi-user.target.wants/ghost_54-169-190-39.service.
Removed symlink /etc/systemd/system/ghost_54-169-190-39.service.
```

# Rotate Tomcat catalina.out

https://dzone.com/articles/how-rotate-tomcat-catalinaout
