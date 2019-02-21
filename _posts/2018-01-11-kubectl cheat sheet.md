---
layout: post
title: kubectl cheat sheet
date: 2018-01-11
tags: [k8s, kubectl]
---

# enable RBAC
```
 kube-apiserver
    - --authorization-mode=RBAC
```

# User CRUD
```
openssl genrsa -out bigo.key 2048
openssl req -new -key bigo.key -out bigo.csr -subj "/CN=wubigo/O=bigo LLC"
sudo openssl x509 -req -in bigo.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out bigo.crt -days 500
kubectl config set-credentials bigo --client-certificate=./bigo.crt --client-key=./bigo.key
kubectl config set-context bigo-context --cluster=kubernetes --namespace=bigo-NS --user=bigo
kubectl config get-contexts 
...
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
          bigo-context                  kubernetes   bigo               bigo
*         kubernetes-admin@kubernetes   kubernetes   kubernetes-admin
...
```

# USER, GROUP, ROLE , ROLEBIND, RBAC
- list all users
```
kubectl config view
...
users:
- name: kubernetes-admin
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
...
```