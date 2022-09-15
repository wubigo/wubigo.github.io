---
layout: post
title: ETCD notes
date: 2011-02-01
tag: ["K8S"]
---



# Verify etcd CA data
```shell
sudo openssl x509 -in /etc/kubernetes/pki/etcd/server.crt -text
...
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage: 
                TLS Web Server Authentication, TLS Web Client Authentication
            X509v3 Subject Alternative Name: 
                DNS:bigo-vm3, DNS:localhost, IP Address:192.168.1.11, IP Address:127.0.0.1, IP Address:0:0:0:0:0:0:0:1
...
```
> server.crt is signed for DNS names [bigo-vm3 localhost] and IPs [192.168.1.11 127.0.0.1 ::1]


# etcd config

```
$kubeadm init phase etcd local -v 4
[etcd] wrote Static Pod manifest for a local etcd member to "/etc/kubernetes/manifests/etcd.yaml"
$cat /etc/kubernetes/manifests/etcd.yaml


- etcd
    - --advertise-client-urls=https://192.168.1.11:2379
    - --cert-file=/etc/kubernetes/pki/etcd/server.crt
    - --client-cert-auth=true
    - --data-dir=/var/lib/etcd
    - --initial-advertise-peer-urls=https://192.168.1.11:2380
    - --initial-cluster=bigo-vm1=https://192.168.1.11:2380
    - --key-file=/etc/kubernetes/pki/etcd/server.key
    - --listen-client-urls=https://127.0.0.1:2379,https://192.168.1.11:2379
    - --listen-peer-urls=https://192.168.1.11:2380
    - --name=bigo-vm1
    - --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
    - --peer-client-cert-auth=true
    - --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
    - --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    - --snapshot-count=10000
    - --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    image: K8S.gcr.io/etcd:3.2.24
    imagePullPolicy: IfNotPresent
    livenessProbe:
      exec:
        command:
        - /bin/sh
        - -ec
        - ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt
          --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt --key=/etc/kubernetes/pki/etcd/healthcheck-client.key
          get foo



```

# check  kube apiserver access of etcd with curl
```
sudo curl -L -v https://192.168.1.11:2379/v3/keys --cacert /etc/kubernetes/pki/etcd/ca.crt  --cert /etc/kubernetes/pki/apiserver-etcd-client.crt  --key /etc/kubernetes/pki/apiserver-etcd-client.key
*   Trying 192.168.1.11...
* Connected to 192.168.1.11 (192.168.1.11) port 2379 (#0)
* found 1 certificates in /etc/kubernetes/pki/etcd/ca.crt
* found 597 certificates in /etc/ssl/certs
* ALPN, offering http/1.1
* SSL connection using TLS1.2 / ECDHE_RSA_AES_128_GCM_SHA256
* 	 server certificate verification OK
* 	 server certificate status verification SKIPPED
* 	 common name: bigo-vm3 (matched)
* 	 server certificate expiration date OK
* 	 server certificate activation date OK
* 	 certificate public key: RSA
* 	 certificate version: #3
* 	 subject: CN=bigo-vm3
* 	 start date: Sun, 17 Feb 2019 14:15:39 GMT
* 	 expire date: Mon, 17 Feb 2020 14:15:40 GMT
* 	 issuer: CN=etcd-ca
* 	 compression: NULL
* ALPN, server did not agree to a protocol
> GET /v3/keys HTTP/1.1
> Host: 192.168.1.11:2379
> User-Agent: curl/7.47.0
> Accept: */*
> 
< HTTP/1.1 404 Not Found
< Content-Type: text/plain; charset=utf-8
< X-Content-Type-Options: nosniff
< Date: Mon, 18 Feb 2019 02:56:03 GMT
< Content-Length: 19
< 
404 page not found
* Connection #0 to host 192.168.1.11 left intact
```
