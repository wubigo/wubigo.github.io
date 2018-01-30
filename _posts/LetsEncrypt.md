# certbot
- Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/et.com/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/et.com/privkey.pem
   Your cert will expire on 2018-02-19. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot again
   with the "certonly" option. To non-interactively renew *all* of
   your certificates, run "certbot renew"
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le

   
   
# Nginx configuration to enable ACME Challenge support
```
   #Rule for legitimate ACME Challenge requests (like /.well-known/acme-challenge/xxxxxxxxx)
   #We use ^~ here, so that we don't check other regexes (for speed-up). We actually MUST cancel
   #other regex checks, because in our other config files have regex rule that denies access to files with dotted names. location ^~ /.well-    known/acme-challenge/ {

    #Set correct content type. According to this:
    #https://community.letsencrypt.org/t/using-the-webroot-domain-verification-method/1445/29
    #Current specification requires "text/plain" or no content header at all.
    #It seems that "text/plain" is a safe option.
    default_type "text/plain";

    #This directory must be the same as in /etc/letsencrypt/cli.ini
    #as "webroot-path" parameter. Also don't forget to set "authenticator" parameter
    #there to "webroot".
    #Do NOT use alias, use root! Target directory is located here:
    #/var/www/common/letsencrypt/.well-known/acme-challenge/
    root         /var/www/letsencrypt;
}

#Hide /acme-challenge subdirectory and return 404 on all requests.
#It is somewhat more secure than letting Nginx return 403.
#Ending slash is important!

  location = /.well-known/acme-challenge/ {
      return 404;
   }    
```

# nginx need restart after certbot  renew to avoid sec_error_expired_certificate
