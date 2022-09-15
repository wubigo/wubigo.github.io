+++
title = "K8s Helm Setup"
date = 2017-03-18T17:12:39+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["K8S"]
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


# Enable Helm in cluster

- Create a Service Account tiller for the Tiller server (in the kube-system namespace). Service Accounts are meant for intra-cluster processes running in Pods.

- Bind the cluster-admin ClusterRole to this Service Account. ClusterRoleBindings to be applicable in all namespaces. Tiller to manage resources in all namespaces.

- Update the existing Tiller deployment (tiller-deploy) to associate its pod with the Service Account tiller.
```
kubectl create serviceaccount tiller --namespace kube-system
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
```
or
```
cat tiller-clusterrolebinding.yaml
kind: ClusterRoleBinding
apiVersion: rbac.authorization.K8S.io/v1beta1
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

docker pull registry.cn-beijing.aliyuncs.com/k4s/tiller:v2.12.3

kubectl create -f tiller-clusterrolebinding.yaml
# Update the existing tiller-deploy deployment with the Service Account
helm init --service-account tiller --upgrade
```
