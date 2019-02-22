---
layout: post
title: nginx-proxy-rewrite
date: 2015-07-03
tag: Iaas
---

# NGINX 1.12 ON UBUNTU 16
[https://launchpad.net/~nginx/+archive/ubuntu/stable](https://launchpad.net/~nginx/+archive/ubuntu/stable)

```
ubuntu@ip-192-168-133-137:/etc/nginx$ nginx -V
nginx version: nginx/1.12.1
built with OpenSSL 1.0.2g  1 Mar 2016
TLS SNI support enabled
configure arguments: --with-cc-opt='-g -O2 -fPIE -fstack-protector-strong -Wformat -Werror=format-security -fPIC -Wdate-time -D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-Bsymbolic-functions -fPIE -pie -Wl,-z,relro -Wl,-z,now -fPIC' --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --modules-path=/usr/lib/nginx/modules --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-debug --with-pcre-jit --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_v2_module --with-http_dav_module --with-http_slice_module --with-threads --with-http_addition_module --with-http_geoip_module=dynamic --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module=dynamic --with-http_sub_module --with-http_xslt_module=dynamic --with-stream=dynamic --with-stream_ssl_module --with-stream_ssl_preread_module --with-mail=dynamic --with-mail_ssl_module --add-dynamic-module=/build/nginx-aqArPM/nginx-1.12.1/debian/modules/nginx-auth-pam --add-dynamic-module=/build/nginx-aqArPM/nginx-1.12.1/debian/modules/nginx-dav-ext-module --add-dynamic-module=/build/nginx-aqArPM/nginx-1.12.1/debian/modules/nginx-echo --add-dynamic-module=/build/nginx-aqArPM/nginx-1.12.1/debian/modules/nginx-upstream-fair --add-dynamic-module=/build/nginx-aqArPM/nginx-1.12.1/debian/modules/ngx_http_substitutions_filter_module
```



[nginxproxy.md](https://gist.github.com/soheilhy/8b94347ff8336d971ad0)

Step 3 -- Configure /

Let say we want to configure nginx to route requests for /, /blog, and /mail, respectively onto localhost:8080, localhost:8181, and localhost:8282.

```

                  +--- host --------> node.js on localhost:8080
                  |
users --> nginx --|--- host/blog ---> node.js on localhost:8181
                  |
                  +--- host/mail ---> node.js on localhost:8282
```
To route /, you need to edit your nginx config file.

In the config file, find the server section:
```
server {
    listen       80;
    ...
    location / {
       ...
    }
    ...
}
```
This section is simply telling nginx how it should serve HTTP requests.

Now, change the location section to this snippet:
```
server {
    listen       ...;
    ...
    location / {
        proxy_pass http://127.0.0.1:8080;
    }
    ...
}
```
proxy_pass simply tells nginx to forward requests to / to the server listening on http://127.0.0.1:8080.

Step 4 -- Reload nginx's Configuration

To reload nginx's configuration run: nginx -s reload on your machine.

Referesh your browser. Do you see the output from your node.js application? If yes, you are all set. If no, there is a problem with your config.

Step 5 -- Add /blog and /mail

To redirect /mail and /blog, you simply need to add new entries the location section in the config file:
```
server {
    listen       ...;
    ...
    location / {
        proxy_pass http://127.0.0.1:8080;
    }

    location /blog {
        proxy_pass http://127.0.0.1:8181;
    }

    location /mail {
        proxy_pass http://127.0.0.1:8282;
    }
    ...
}
```

Step 6 -- Reload Your nginx Configuration

Run nginx -s reload on your machine.

Log onto localhost:$PORT/blog in your browser. Do you see the output from your second node.js application?

Then log onto localhost:$PORT/mail. Do you see the output from your third node.js application?

If yes & yes, you are all set. If no, there is a problem with your config.

Step 7 -- Rewriting Requests

Now as you might have noticed in Step 6, nginx sends the same HTTP request to your node.js web apps which results into a 404 error. Why? Because, your node.js web application serves requests from / not from /blog and /mail. But, nginx is sending requests to /blog and /mail.

To fix this issue, we need rewrite the URL so that it matches the URL you can serve on your node.js applications.

To correctly rewrite URLs change your config file to match the following snippet:
```
server {
    listen       ...;
    ...
    location / {
        proxy_pass http://127.0.0.1:8080;
    }

    location /blog {
        rewrite ^/blog(.*) /$1 break;
        proxy_pass http://127.0.0.1:8181;
    }

    location /mail {
        rewrite ^/mail(.*) /$1 break;
        proxy_pass http://127.0.0.1:8282;
    }
    ...
}
```

This rewrite commands are simple regular expressions that transform strings like /blogWHAT_EVER and /mailWHAT_EVER to /WHAT_EVER in the HTTP requests.

Step 8 -- Reload and Test.

All set?

Exercise 1

Configure your nginx to redirect URLs from /google to http://www.google.com

Step 9 (optional) -- Redirecting Based on Host Name

Let say you want to host example1.com, example2.com, and example3.com on your machine, respectively to localhost:8080, localhost:8181, and localhost:8282.

Note: Since you don't have access to a DNS server, you should add domain name entries to your /etc/hosts (you can't do this on CDF machines):

...
127.0.0.1 example1.com example2.com example3.com
...
To proxy eaxmple1.com we can't use the location part of the default server. Instead we need to add another server section with a server_name set to our virtual host (e.g., example1.com, ...), and then a simple location section that tells nginx how to proxy the requests:
```
server {
    listen       80;
    server_name  example1.com;

    location / {
        proxy_pass http://127.0.0.1:8080;
    }
}

server {
    listen       80;
    server_name  example2.com;

    location / {
        proxy_pass http://127.0.0.1:8181;
    }
}

server {
    listen       80;
    server_name  example3.com;

    location / {
        proxy_pass http://127.0.0.1:8282;
    }
}
```
