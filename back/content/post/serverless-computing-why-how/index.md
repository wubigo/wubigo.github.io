+++
title = "Serverless Computing why & how"
date = 2019-03-03T08:45:55+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["SERVERLESS"]
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


```
kubectl -n openfaas get svc -o wide |grep external
gateway-external   NodePort    10.105.222.28    <none>        8080:31112/TCP   91m   app=gateway

export OPENFAAS_URL=http://<pod-node-ip>:31112
curl OPENFAAS_URL
USERNAME=$(kubectl get secrets basic-auth -n openfaas -o yaml | grep basic-auth-user)
PASSWD=$(kubectl get secrets basic-auth -n openfaas -o yaml | grep basic-auth-password)
PASSWD=$(echo '$PASSWD' | base64 --decode)

```


install client

```
curl -sSL https://cli.openfaas.com | sh
echo -n $PASSWORD | faas-cli login -g $OPENFAAS_URL -u admin --password-stdin
```


Removing the OpenFaaS
All control plane components can be cleaned up with helm:


```
helm delete --purge openfaas
kubectl delete namespace/openfaas
kubectl delete namespace/openfaas-fn
```

