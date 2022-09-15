+++
title = "Postgres Notes"
date = 2013-04-06T15:46:07+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["DB", "SQL"]
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

# postgres in docker

https://github.com/wubigo/docker-compose/blob/main/docker-compose-psql.yml

## 启用pg_stat_statements

```
docker volume inspect root_postgresql_data |grep "Mountpoint"
echo "shared_preload_libraries = 'pg_stat_statements'" > /var/lib/docker/volumes/root_postgresql_data/_data/pgdata/postgresql.conf


```



## INSTALL

```
sudo apt-get install -y postgresql-client
psql --version  
```

## TEST

```
psql -h cmp.clv6a9yh.ap-northeast-1.rds.amazonaws.com -U postgres

postgres=> \list
                                  List of databases
   Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
-----------+----------+----------+-------------+-------------+-----------------------
 postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 rdsadmin  | rdsadmin | UTF8     | en_US.UTF-8 | en_US.UTF-8 | rdsadmin=CTc/rdsadmin
 template0 | rdsadmin | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/rdsadmin          +
           |          |          |             |             | rdsadmin=CTc/rdsadmin
 template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
(4 rows)

```


## SSH tunnelling to an RDS instance

```
ssh -L 5432:mydb.myrdsinstance.eu-west-1.rds.amazonaws.com:5432 aws
```

