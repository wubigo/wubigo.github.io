# Generate self-signed certificates

```
mkdir ~/bin
curl -s -L -o ~/bin/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
curl -s -L -o ~/bin/cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
chmod +x ~/bin/{cfssl,cfssljson}
```




check server.pem isssued X509v3 Subject Alternative Name
```
openssl x509 -in server.pem -text |grep DNS
```
