+++
title = "Redis Install Ubuntu"
date = 2013-04-28T17:08:07+08:00
tags = ["REDIS", "MYSQL"]
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



# install 

```
curl -O http://download.redis.io/redis-stable.tar.gz
tar xzvf redis-stable.tar.gz
cd redis-stable
make
make test
sudo make install

```

# config

```
sudo mkdir /etc/redis
sudo cp redis-stable/redis.conf /etc/redis
sudo adduser --system --group --no-create-home redis
sudo mkdir /var/lib/redis
sudo chown redis:redis /var/lib/redis
sudo chmod 770 /var/lib/redis
```


`/etc/redis/redis.conf`

```
supervised systemd
dir /var/lib/redis
# bind localhost
```


# start 

```
redis-server /etc/redis/redis.conf
```

# shutdown

```
redis-cli shutdown

redis-cli
127.0.0.1:6379> shutdown
```



# run in docker

```
docker run --name redis -network host -v /var/lib/redis:/data  /etc/redis/redis.conf:/etc/redis/redis.conf -d redis:5.0-alpine3.9  redis-server /etc/redis/redis.conf --appendonly yes
```






https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-redis-on-ubuntu-16-04