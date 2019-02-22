---
layout: post
title: ghost notes
date: 2016-12-30
tag: tools
---


# Adding swap memory
If your system has less than 1GB memory, you may run into errors. To overcome this, configure a larger amount of swap memory:

```
dd if=/dev/zero of=/var/swap bs=1k count=1024k
mkswap /var/swap
swapon /var/swap
echo '/var/swap swap swap default 0 0' >> /etc/fstab
```

# default-setting

    /var/www/ghost/versions/1.18.2/core/server/data/schema/default-settings.json


# blog mail configuration using Amazon SES

Ghost is a blogging platform written in nodejs.
Edit the config.js file at the ghost root directory

```
mail: {
   from: 'from@email.com',
   transport: 'SMTP',
   options: {
     host: "your-amazon-host",
     port: 465,
     service: "SES",
     auth: {
       user: "your-amazon-user",
       pass: "your-amazon-password"
     }
   }
}
```

Amazon SES credential can be generated from amazon control panel.
From address must be registered and verified as sender.

# favicon.ico

    cp /home/ubuntu/favicon.ico /var/www/ghost/versions/1.18.2/core/server/public/
