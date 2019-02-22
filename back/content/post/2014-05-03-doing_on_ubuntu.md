---
layout: post
title: doing_on_ubuntu
date: 2014-05-03
tag: Iaas
---

# TZ
```sh
$ export TZ=:/etc/localtime

locale
 /etc/environment:
LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
```

1: set TZ=:/etc/localtime
                https://blog.packagecloud.io/eng/2017/02/21/set-environment-variable-save-thousands-of-system-calls/

# mysql utf8

For the recent version of MySQL,

default-character-set = utf8
causes a problem. It's deprecated I think.

As Justin Ball says in "Upgrade to MySQL 5.5.12 and now MySQL won’t start, you should:

Remove that directive and you should be good.
Then your configuration file ('/etc/my.cnf' for example) should look like that:
[mysqld]
collation-server = utf8_unicode_ci
init-connect='SET NAMES utf8'
character-set-server = utf8
Restart MySQL.
For making sure, your MySQL is UTF-8, run the following queries in your MySQL prompt:
First query:

 mysql> show variables like 'char%';

# tomcat deploy for dev
```
conf/Catalina/localhost/ROOT.xml

<?xml version="1.0" encoding="UTF-8"?>
<Context
  docBase="/opt/etender"
  path=""
/>




$TOMCAT_HOME/conf/server.xml
       <!--   
	    <Context path="/etender" docBase="c:/WebRoot">
        </Context>
        -->
	  </Host>
    </Engine>
  </Service>
</Server>
```




# show the last queries executed on MySQL temporarily

If you prefer to output to a file:
```
SET GLOBAL log_output = "FILE"; which is set by default.
#set absolute path will report error,mysql.log=/var/lib/mysql/mysql.log
SET GLOBAL general_log_file = "mysql.log";
SET GLOBAL general_log = 'ON';

tail -f /var/lib/mysql/mysql.log
```

# Optimize Your Tomcat Installation on Ubuntu 14.04

hange JVM Heap Setting (-Xms -Xmx) of Tomcat – Configure setenv.sh file

default no setenv.sh file under /bin directory. Have to create one with below parameters.

Xms=Xmx=1/2RAM( avoid having the costly memory allocation process running because the size of
                the allocated memory will be constant all the time)
MaxPermSize=1/2mx

$cat setenv.sh
export CATALINA_OPTS="$CATALINA_OPTS -Xms512m"
export CATALINA_OPTS="$CATALINA_OPTS -Xmx8192m"
export CATALINA_OPTS="$CATALINA_OPTS -XX:MaxPermSize=256m"

catalina.out to verify the setting in effect
catalina.startup.VersionLoggerListener.log Command line argument: -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager
org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djdk.tls.ephemeralDHKeySize=2048
catalina.startup.VersionLoggerListener.log Command line argument: -Djava.protocol.handler.pkgs=org.apache.catalina.webresources
org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Xms4192m
org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Xmx4192m
org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -XX:MaxPermSize=2000m

# optimize mysql

showing current configuration variables
mysql>SHOW VARIABLES LIKE '%max%';  


innodb_file_per_table = ON
innodb_stats_on_metadata = OFF
innodb_buffer_pool_instances = 8
innodb_buffer_pool_size = 1G
query_cache_type = 0
query_cache_size = 0
innodb_log_file_size = 5242880
innodb_flush_log_at_trx_commit = 1 # may change to 2 or 0
innodb_flush_method = O_DIRECT



# tomcat upstat on ubuntu14.04
/etc/init/tomcat.conf
description "Tomcat Server"

  start on runlevel [2345]
  stop on runlevel [!2345]
  respawn
  respawn limit 10 5

  setuid tomcat
  setgid tomcat

  env JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre
  env CATALINA_HOME=/opt/tomcat

  # Modify these options as needed
  env JAVA_OPTS="-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"
  env CATALINA_OPTS="-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

  exec $CATALINA_HOME/bin/catalina.sh run

  # cleanup temp directory after stop
  post-stop script
    rm -rf $CATALINA_HOME/temp/*
  end script

  sudo initctl reload-configuration
Tomcat is ready to be run. Start it with this command:
sudo initctl start tomcat


sudo sh -c 'echo manual >> /etc/init/tomcat.override'


# deploy web app as the root context in tomcat
   in the $CATALINA_BASE/conf/[enginename]/[hostname]/ROOT.XML
   <?xml version="1.0" encoding="UTF-8"?>
   <Context
      docBase="/opt/WebRoot"
      path=""    
   />


# authbind tomcat
sudo apt install authbind
sudo touch /etc/authbind/byport/{443,80}
sudo chmod 500 /etc/authbind/byport/{443,80}
sudo chown tomcat:tomcat /etc/authbind/byport/{443,80}
# Configure Tomcat
sudo sed -i 's/8080/80/g' /home/tomcat/apache-tomcat-8.0.35/conf/server.xml
sudo sed -i 's/8443/443/g' /home/tomcat/apache-tomcat-8.0.35/conf/server.xml
#TOMCAT_HOME/bin/setenv.sh
export CATALINA_OPTS="-Djava.net.preferIPv4Stack=true"
#startup.sh:
exec authbind --deep "$PRGDIR"/"$EXECUTABLE" start "$@"

#  upload big files with Nginx (Reverse proxy+SSL negotiation) and Tomcat
solution 1: config nginx
$TOMCAT_HOME/bin/server.xml  
disableUploadTimeout=false
In nginx.conf add:
http {
     # at the END of this segment!
     client_max_body_size 1000m;
}

solution 2 : config tomcat
maxSwallowSize	     The maximum number of request body bytes (excluding transfer encoding overhead) that will be
                     swallowed by Tomcat for an aborted upload. An aborted upload is when Tomcat knows that
		     the request body is going to be ignored but the client still sends it.
		     If Tomcat does not swallow the body the client is unlikely to see the response.
		     If not specified the default of 2097152 (2 megabytes) will be used.
		     A value of less than zero indicates that no limit should be enforced.

# MySql - changing innodb_file_per_table for a live db
solution 1:
mysql>set global innodb_file_per_table = 1 (set value to on doesn't effect for mysql 5.5 )

# Cross Origin Resource Sharing (CORS) with nginx

     location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                # try_files $uri $uri/ =404;
                # Uncomment to enable naxsi on this location
                # include /etc/nginx/naxsi.rules
                add_header 'Access-Control-Allow-Origin' '*';
                add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS, PUT, DELETE';



# remove Nginx Server Signature(reset server header in response)

    /etc/nginx/nginx.conf
    server_tokens off;

 # 跨域的常见解决方法
   目前来讲没有不依靠服务器端来跨域请求资源的技术
　　1.jsonp 需要目标服务器配合一个callback函数。
　　2.window.name+iframe 需要目标服务器响应window.name。
　　3.window.location.hash+iframe 同样需要目标服务器作处理。
　　4.html5的 postMessage+ifrme 这个也是需要目标服务器或者说是目标页面写一个postMessage，主要侧重于前端通讯。
　　5.CORS 需要服务器设置header ：Access-Control-Allow-Origin。
　　6.nginx反向代理 这个方法一般很少有人提及，但是他可以不用目标服务器配合，不过需要你搭建一个中转nginx服务器，用于转发请求。   

    location / {
            #alias D:\\develop\\project1dir\\appDist\\;  #此文件夹可以是项目打包后的上线代码文件，也可以是第二个项目源代码文件
            # Frontend Server
            proxy_pass http://localhost:8002/;  #前端服务器地址，比如gulp+browser-sync开启的服务器，能看到代码实时更新效果
        }

        location /api/ {
            rewrite ^/api/(.*)$ /$1 break;  #所有对后端的请求加一个api前缀方便区分，真正访问的时候移除这个前缀
            # API Server
            proxy_pass http://serverB.com;  #将真正的请求代理到serverB,即真实的服务器地址，ajax的url为/api/user/1的请求将会访问http://www.serverB.com/user/1
        }

#  update time
```
	sudo ntpdate ntp.ubuntu.com
```
        https://help.ubuntu.com/lts/serverguide/NTP.html
