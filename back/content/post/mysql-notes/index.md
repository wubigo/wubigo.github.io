+++
title = "Mysql Notes"
date = 2012-06-04T07:34:02+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["MYSQL", "DBMS"]
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

# 查看表状态

```
show table status FROM redis_db like 'point_value';

+-------------+--------+---------+------------+-----------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+-----------------+----------+----------------+---------+
| Name        | Engine | Version | Row_format | Rows      | Avg_row_length | Data_length | Max_data_length | Index_length | Data_free | Auto_increment | Create_time         | Update_time         | Check_time | Collation       | Checksum | Create_options | Comment |
+-------------+--------+---------+------------+-----------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+-----------------+----------+----------------+---------+
| point_value | InnoDB |      10 | Dynamic    | 316755485 |            143 | 45420118016 |               0 |            0 |   3145728 |           NULL | 2022-01-30 18:55:44 | 2022-02-06 18:17:56 | NULL       | utf8_general_ci |     NULL |                |         |
+-------------+--------+---------+------------+-----------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+-----------------+----------+----------------+---------+
1 row in set (0.00 sec)

```

或者

```
 select TABLE_NAME,TABLE_ROWS, AVG_ROW_LENGTH,DATA_LENGTH,INDEX_LENGTH,DATA_FREE from  information_schema.TABLES WHERE TABLES.TABLE_SCHEMA ='redis_db';
+--------------------+------------+----------------+-------------+--------------+-----------+
| TABLE_NAME         | TABLE_ROWS | AVG_ROW_LENGTH | DATA_LENGTH | INDEX_LENGTH | DATA_FREE |
+--------------------+------------+----------------+-------------+--------------+-----------+
| EFPointValues      |   18948888 |            223 |  4229955584 |            0 |         0 |
| checksums          |          2 |           8192 |       16384 |            0 |         0 |
| point_value        |  321024285 |            141 | 45420118016 |            0 |   3145728 |
| point_value_source |    9398127 |            146 |  1376780288 |            0 |   5242880 |
| stream             |          2 |           8192 |       16384 |            0 |         0 |
+--------------------+------------+----------------+-------------+--------------+-----------+
```

# 数据优化

https://docs.oracle.com/cd/E17952_01/mysql-5.6-en/data-size.html

# 错误日志时间戳


```
[mysqld]
log_timestamps = SYSTEM
```


# innodb_file_per_table

```
[mysqld]
datadir         = /data/mysql
```

ibdata1 是InnoDB 系统表空间， 使用innodb_file_per_table = 1 
用户创建的表和索引按数据库单独存放。 假设用户创建了device数据库
和point表

```
CREATE DATABASE device
CREATE TABLE device.point (...) ENGINE=InnoDB
```

`/data/mysql/device/point.ibd`
`/data/mysql/device/point.frm`


# showing current configuration

```
mysql>SHOW VARIABLES;
```

```
    mysqldump -u root -h 192.168.76.62 -pgld --all-databases > dump.sql
    mysqldump -u root -h db -pgld --all-databases > dump.sql
```

then import data in mysql shell

mysql>source dump.sql


update the database if  directly upgrade from 5.0 to 5.5


mysql_upgrade -u root -p

service mysql restart


A typical mysqldump command to move data from an external database to an Amazon RDS DB instance looks similar to the following:

mysqldump -u <local_user> \
    --databases <database_name> \
    --single-transaction \
    --compress \
    --order-by-primary  \
    -p<local_password> | mysql -u <RDS_user> \
        --port=<port_number> \
        --host=<host_name> \
        -p<RDS_password>


--single-transaction – Use to ensure that all of the data loaded from the local database is consistent with a single point in time. If there are other processes changing the data while mysqldump is reading it, using this option helps maintain data integrity.
--compress – Use to reduce network bandwidth consumption by compressing the data from the local database before sending it to Amazon RDS.
--order-by-primary – Use to reduce load time by sorting each table's data by its primary key.

You must create any stored procedures, triggers, functions, or events manually in your Amazon RDS database. If you have any of these objects in the database that you are copying, then exclude them when you run mysqldump by including the following arguments with your mysqldump command: --routines=0 --triggers=0 --events=0.



how to remove mysql  completely

sudo apt-get remove --purge mysql-server mysql-client mysql-common
sudo apt-get autoremove
sudo apt-get autoclean
then try to install it again.

sudo apt-get install mysql-server
if you installing with dpkg command and if it show any dependency on other package then run command :

sudo apt-get install -f





What is disabled by default is remote root access. If you want to enable that, run this SQL command locally:

 GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '<password>' WITH GRANT OPTION;
 FLUSH PRIVILEGES;

# Enable remote connection

mysql 5.7

mysqld config `/etc/mysql/mysql.conf.d`
mysql client config `/etc/mysql/conf.d`



And then find the following line and comment it out in your my.cnf file, which usually lives on /etc/mysql/my.cnf on Unix/OSX systems. 

If it's a Windows system, you can find it in the MySQL installation directory, usually something like C:\Program Files\MySQL\MySQL Server 5.5\ and the filename will be my.ini.

Change line
```
 bind-address = 127.0.0.1
```
to
```
 #bind-address = 127.0.0.1
```
And restart the MySQL server for the changes to take effect.




sudo apt-get install mysql-server

update t_supplier_subproject set attachInfo='';commit;

update t_supplier set email='gin_369@163.Cnn' where supplierID=7;

 select * from t_supplier where userid='6156354693465407499' and email='gin_369@163.COM';

 ALTER TABLE t_quoted_adopt4tbq MODIFY adoptRemark VARCHAR(255);

查询分包商数量
SELECT count(*) FROM etender.t_supplier;





ALTER TABLE `etender`.`t_supplier`
CHANGE COLUMN `email` `email` VARCHAR(40) NULL DEFAULT '' COMMENT '供应商邮箱';

# 新增列   询价类型

alter table t_project_query add column  inquiryType varchar(255) DEFAULT '2' COMMENT '询价类型';

alter table t_quoted_billitem4tbq add column  itemType varchar(255) DEFAULT '1' COMMENT '清单类型';


SELECT COUNT(*),t2.email AS '总包邮箱', t1.userID FROM  etender.t_user t2 LEFT JOIN etender.t_supplier t1 ON t1.userID = t2.userID  WHERE  t1.logicDelete !=1 GROUP BY t2.userID ;


# Making a Copy of a Database
```
$mysqldump -u root -pg1d etender > dump.sql
$mysqladmin -u root -pg1d create hongq
$mysql -u root -pg1d hongq < dump.sql
```


# export to csv
```
SELECT b.email,a.name supplierName,a.email supplierEmail,a.telephone,a.trade,a.level,a.address,a.contacts FROM t_supplier a LEFT JOIN t_user b ON a.userID = b.userid and a.logicDelete !=1  ORDER BY a.userID limit 1000,1000 INTO OUTFILE '/var/lib/mysql-files/subcon1000.csv' FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
```
# Creating SSH Tunnel From Linux for mysql
$ ssh -L 3306:rdb:3306 ubuntu@ec2

use ip instead of hostname to avoid channel X on ubuntu 16
 "channel X: open failed: administratively prohibited"


