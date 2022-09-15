# Configuring Piwik accessed via an Nginx reverse proxy

public Nginx server configured as
```
location ^~ /piwik/ {
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Host $host;
                proxy_pass http://192.168.79.4/piwik/;

}
```


config.ini.php config on piwi nginx site
```
[General]
proxy_client_headers[] = "HTTP_X_FORWARDED_FOR"
proxy_client_headers[] = "X-Real-IP"
proxy_host_headers[] = "HTTP_X_FORWARDED_HOST"
proxy_ips[] = "192.168.79.4"
trusted_hosts[] = "192.168.79.4"
trusted_hosts[] = "<public-domain-server>"
```

# Configure GeoIP (PECL) With Piwik

check php version 

```
curl http://localhost/info.php
    PHP Version 7.0.17
    Loaded Configuration File	     /etc/php/7.0/fpm/php.ini
sudo apt-get install php-geoip php-dev libgeoip-dev
sudo pecl install geoip      
sudo nano /etc/php/7.0/fpm/php.ini

[PHP]
;AFTER THE PHP SECTION NOT BEFORE
extension=geoip.so

[gd]
;AFTER THE gd SECTION NOT BEFORE
geoip.custom_directory=/usr/share/nginx/html/piwik/misc

cd /usr/share/nginx/html/piwik/misc
sudo wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
sudo gunzip GeoLiteCity.dat.gz

PECL extension won't recognize the database if it's named GeoLiteCity.dat so make sure it is named GeoIPCity.dat:

sudo mv GeoLiteCity.dat GeoIPCity.dat
Restart the Apache Web Server:

sudo service nginx restart

Step Five - Configure Piwik to use GeoIP PECL
Open your browser and login into your Piwik page, go to settings, Geolocation, and choose GeoIP (PECL) as your location provider.


Updating Previous Visits and Updating the GeoIP Database
 sudo apt-get install php-mysql
 sudo php /usr/share/nginx/html/piwik/console usercountry:attribute 2017-01-01,2017-08-10
```

```
nginx

http {

        geoip_country  /usr/share/nginx/html/piwik/misc/GeoIP.dat;
        geoip_city    /usr/share/nginx/html/piwik/misc/GeoIPCity.dat;
```
