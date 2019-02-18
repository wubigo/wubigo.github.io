# Generate self-signed certificates

* Download cfssl
```
mkdir ~/bin
curl -s -L -o ~/bin/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
curl -s -L -o ~/bin/cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
chmod +x ~/bin/{cfssl,cfssljson}
```

* Initialize a certificate authority
```
mkdir ~/cfssl
cd ~/cfssl
cfssl print-defaults config > ca-config.json
cfssl print-defaults csr > ca-csr.json
```

* Certificate types which are used inside Container Linux

    - client certificate is used to authenticate client by server. .
    - server certificate is used by server and verified by client for server identity.
    - peer certificate is used by cluster as members communicate with each other in both ways.




# check server.pem isssued X509v3 Subject Alternative Name
```
openssl x509 -in server.pem -text |grep DNS
```
