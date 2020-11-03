---
layout: post
title: kubectl cheat sheet
date: 2018-01-11
tags: ["K8S"]
---

# Set namespace preference

```
kubectl config set-context $(kubectl config current-context) --namespace=<bigo>
```

# watch pod

```
kubectl get pods pod1 --watch
```

# Check Performance

```
kubectl top node
kubectl top pod
```

# copy file between pod and local

```
kubectl cp  ~/f1 <namespace>/<pod-name>:/tmp/
kubectl cp <namespace>/<pod-name>:/tmp/ ~/
```

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
apiVersion: rbac.authorization.K8S.io/v1beta1
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



```
helm install --name prometheus stable/prometheus

helm install --name prometheus1  stable/prometheus --set server.persistentVolume.storageClass=local-hdd,alertmanager.enabled=false,
```


# PVC using local PV

- create PVC

```
cat storage-class-hdd.yaml 
apiVersion: storage.K8S.io/v1
kind: StorageClass
metadata:
 name: local-hdd
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
```

**v1.18.3**

```
apiVersion: storage.k8s.io/v1
```


>kubectl apply -f  storage-class-hdd.yaml

- create local PV

```
cat local_volume.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: local-hdd
spec:
  capacity:
    storage: 8Gi
  volumeMode: Filesystem
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Delete
  storageClassName: local-hdd
  local:
    path: /mnt/pv/
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - bigo-vm4
```

>kubectl apply -f local_volume.yaml

PersistentVolume nodeAffinity is required when using local volumes. It enables the Kubernetes scheduler to correctly schedule Pods using local volumes to the correct node.

PersistentVolume volumeMode can now be set to “Block” (instead of the default value “Filesystem”) to expose the local volume as a raw block device. The volumeMode field requires BlockVolume Alpha feature gate to be enabled.

When using local volumes, it is recommended to create a StorageClass with volumeBindingMode set to WaitForFirstConsumer. See the example. Delaying volume binding ensures that the PersistentVolumeClaim binding decision will also be evaluated with any other node constraints the Pod may have, such as node resource requirements, node selectors, Pod affinity, and Pod anti-affinity

- 

https://www.nebulaworks.com/blog/2019/08/27/leveraging-aws-ebs-for-kubernetes-persistent-volumes/


# Port Forwarding a local port to a port on K8S
```
kubectl port-forward <podname> 9090:9090
or
kubectl port-forward pods/<podname> 9090:9090
or
kubectl port-forward deployment/prometheus  9090:9090
or
kubectl port-forward svc/prometheus  9090:9090
or
kubectl port-forward rs/prometheus  9090:9090
```