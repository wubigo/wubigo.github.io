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

# binding role to user
```
cat rolebinding-bigo-access.yaml
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: access-manager-binding
  namespace: bigo-NS
subjects:
- kind: User
  name: bigo
  apiGroup: ""
roleRef:
  kind: Role
  name: access-role
  apiGroup: ""
kubectl create -f rolebinding-bigo-access.yaml

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


# Enable Helm in cluster

- Create a Service Account tiller for the Tiller server (in the kube-system namespace). Service Accounts are meant for intra-cluster processes running in Pods.

- Bind the cluster-admin ClusterRole to this Service Account. ClusterRoleBindings to be applicable in all namespaces. Tiller to manage resources in all namespaces.

- Update the existing Tiller deployment (tiller-deploy) to associate its pod with the Service Account tiller.
```
kubectl create serviceaccount tiller --namespace kube-system
cat tiller-clusterrolebinding.yaml
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: tiller-clusterrolebinding
subjects:
- kind: ServiceAccount
  name: tiller
  namespace: kube-system
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: ""

kubectl create -f tiller-clusterrolebinding.yaml
# Update the existing tiller-deploy deployment with the Service Account
helm init --service-account tiller --upgrade

```