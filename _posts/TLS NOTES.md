check server.pem isssued X509v3 Subject Alternative Name
```
openssl x509 -in server.pem -text |grep DNS
```
