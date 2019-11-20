+++
title = "无服务器计算环境OPENFAAS搭建"
date = 2017-03-03T08:45:55+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["SERVERLESS", "FAAS"]
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

# 准备

- 创建角色和授权

```
kubectl create clusterrolebinding "cluster-admin-faas" \
  --clusterrole=cluster-admin \
  --user="cluster-admin-faas"
```

- 分别为FAAS核心服务和函数创建名字空间

```
kubectl apply -f https://raw.githubusercontent.com/openfaas/faas-netes/master/namespaces.yml
```

- 创建凭证

```
# generate a random password
PASSWORD=$(head -c 12 /dev/urandom | shasum| cut -d' ' -f1)

kubectl -n openfaas create secret generic basic-auth \
--from-literal=basic-auth-user=admin \
--from-literal=basic-auth-password="$PASSWORD"
```

- 在本地helm仓库增加openfaas

```
helm repo add openfaas https://openfaas.github.io/faas-netes/
"openfaas" has been added to your repositories
```

# 开始安装

```
helm repo update \
 && helm upgrade openfaas --install openfaas/openfaas \
    --namespace openfaas  \
    --set basic_auth=true \
    --set functionNamespace=openfaas-fn
```
默认通过NodePorts方式访问openfaas控制台

```
kubectl -n openfaas get svc -o wide |grep external
gateway-external   NodePort    10.105.222.28    <none>        8080:31112/TCP   91m   app=gateway

export OPENFAAS_URL=http://<pod-node-ip>:31112
curl OPENFAAS_URL
USERNAME=$(kubectl get secrets basic-auth -n openfaas -o yaml | grep basic-auth-user)
PASSWD=$(kubectl get secrets basic-auth -n openfaas -o yaml | grep basic-auth-password)
PASSWD=$(echo '$PASSWD' | base64 --decode)

```

# 验证安装结果

- 通过浏览器访问openfaas

```
curl http://<pod-node-ip>:31112
```
输入上面的用户名和密码进入openfaas控制台


- 安装openfaas客户端

```
curl -sSL https://cli.openfaas.com | sh
echo -n $PASSWORD | faas-cli login -g $OPENFAAS_URL -u admin --password-stdin
```


# Removing the OpenFaaS

All control plane components can be cleaned up with helm:

```
helm delete --purge openfaas
kubectl delete namespace/openfaas
kubectl delete namespace/openfaas-fn
```

