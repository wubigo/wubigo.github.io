+++
title = "Vue Deployed in Non-Root Nginx Location"
date = 2019-06-12T19:13:09+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["NGINX", "PROXY", "HTTP", "WEB"]
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



deploy VUE app under myweb context path


```
server {
		
		listen 80;
		server_name 127.0.0.1;

		#listen      443 ssl;
		

		location /ibms/api/ {
		   proxy_pass http://127.0.0.1:8080/;
		   #proxy_set_header Host $http_host;
		   add_header Cache-Control no-cache;
		   add_header Pragma no-cache;
		   add_header Expires 0;
		   proxy_connect_timeout 200s;
		   proxy_send_timeout 200s;
		   proxy_read_timeout 200s;
		   proxy_set_header X-Real-IP $remote_addr;
		   proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		   proxy_set_header sn $http_sn;
		   #405 重新代理
		   error_page 405 =200 http://$host$request_uri;
		
    }

 
		location /ibms {
      root /var/www/html;
			add_header Cache-Control no-cache;
			add_header Pragma no-cache;
			add_header Expires 0;
			#try_files $uri $uri/ @router;
			try_files $uri $uri/ /ibms/index.html;
			index index.html index.htm;
		}

    location / {
                        root /var/www/html;
                        add_header Cache-Control no-cache;
                        add_header Pragma no-cache;
                        add_header Expires 0;
                        try_files $uri $uri/ @router;
                        index index.html index.htm;
                }
    location @router {
                        rewrite ^.*$ /index.html last;
    }


    }

```


