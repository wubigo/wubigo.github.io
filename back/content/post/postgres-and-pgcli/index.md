+++
title = "Postgres and Pgcli"
date = 2022-07-02T08:43:54+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["PSQL"]
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


# START PG

```
version: '2'

services:
  postgresql:
    container_name: pg
    image: postgres:12
    ports:
      - '5432:5432'
    volumes:
      - 'postgresql_data:/var/lib/postgresql/data'
    environment:
      - 'POSTGRES_PASSWORD=!Qsx4rgb'
      - 'PGDATA=/var/lib/postgresql/data/pgdata'

  # adminer:
  #   image: adminer
  #   restart: always
  #   ports:
  #     - 8080:8080

volumes:
  postgresql_data:
    driver: local

```


#  安装pgcli

```
sudo apt install libpq-dev
pip install -U pgcli
export PATH=$PATH:/home/ubuntu/.local/bin
pgcli -U postgres -h localhost

```

# 更改配置

```
postgres@localhost> alter system set autovacuum = off;
postgres@localhost> SELECT pg_reload_conf();
postgres@localhost> show autovacuum;
```