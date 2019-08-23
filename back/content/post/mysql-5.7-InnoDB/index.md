+++
title = "Mysql 5.7 InnoDB"
date = 2013-04-22T17:08:07+08:00
tags = ["SHELL", "MYSQL"]
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



# index buffer


Depends on Storage Engine

MyISAM (Caches Index Pages From .MYI files)

```
SELECT FLOOR(SUM(index_length)/POWER(1024,2)) IndexSizesMB
FROM information_schema.tables WHERE engine='MyISAM' AND
table_schema NOT IN ('information_schema','performance_schema','mysql');
```
Subtract that from key_buffer_size. 

InnoDB (Caches Data and Index Pages)
```
SELECT FLOOR(SUM(data_length+index_length)/POWER(1024,2)) InnoDBSizeMB
FROM information_schema.tables WHERE engine='InnoDB';
```
Subtract that from innodb_buffer_pool_size. 



# convert all tables from InnoDB  into MyISAM


```
SET @DATABASE_NAME = 'guowang';

SELECT  CONCAT('ALTER TABLE `', table_name, '` ENGINE=MyISAM;') AS sql_statements
FROM    information_schema.tables AS tb
WHERE   table_schema = @DATABASE_NAME
AND     `ENGINE` = 'InnoDB'
AND     `TABLE_TYPE` = 'BASE TABLE'
ORDER BY table_name DESC;
```



```
 mysql>show full processlist;
 mysql>Select concat('KILL ',id,';') from information_schema.processlist where user='root';
```

```
SHOW ENGINE INNODB STATUS
```


# a method to find  the best prefix length for a given column

```
SELECT
 ROUND(SUM(LENGTH(`sno`)<10)*100/COUNT(`sno`),2) AS pct_length_10,
 ROUND(SUM(LENGTH(`sno`)<20)*100/COUNT(`sno`),2) AS pct_length_20,
 ROUND(SUM(LENGTH(`sno`)<50)*100/COUNT(`sno`),2) AS pct_length_50,
 ROUND(SUM(LENGTH(`sno`)<100)*100/COUNT(`sno`),2) AS pct_length_100
FROM `bs`;
```


# show to file 
```
mysql --table -e "sELECT
  nbiot_create_time
 		,metric
   , totalTime
FROM v_sel_g550 g  
WHERE 
 g.nbiot_create_time >  '2019-04-04'" -u root -p123456 guowang > guowang-status.txt
```

sELECT
  nbiot_create_time
 		,metric
   , totalTime
FROM v_sel_g550 g  
WHERE 
 g.nbiot_create_time >  '2019-04-04'

```
CREATE TABLE ` v_sel_g550`  (
`id` int(32) NOT NULL AUTO_INCREMENT,
`nbiot_create_time` timestamp,
`metric`  varchar(50),
`totalTime` int,
PRIMARY KEY (`id`) USING BTREE,
) ENGINE = InnoDB
```