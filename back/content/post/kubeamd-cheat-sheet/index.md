+++
title = "kubeamd cheat sheet"
date = 2019-02-11T11:38:27+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["K8S"]
categories = ["IT"]

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++


**version notes**

some only works on 1.13

```
kubeadm version: &version.Info{Major:"1", Minor:"13", GitVersion:"v1.13.3",
GitCommit:"721bfa751924da8d1680787490c54b9179b1fed0", GitTreeState:"clean", BuildDate:"2019-02-16T15:29:34Z", 
GoVersion:"go1.11.5", Compiler:"gc", Platform:"linux/amd64"}
```

Starting with Kubernetes 1.12, the K8S.gcr.io/kube-${ARCH}, K8S.gcr.io/etcd and K8S.gcr.io/pause images don’t require an -**${ARCH}** suffix


- get all Pending pods 

```
kubectl get pods --field-selector=status.phase=Pending
```

- images list

```
kubeadm config images list -v 4
I0217 07:28:13.305268   14495 interface.go:384] Looking for default routes with IPv4 addresses
I0217 07:28:13.307275   14495 interface.go:389] Default route transits interface "enp0s3"
I0217 07:28:13.308349   14495 interface.go:196] Interface enp0s3 is up
I0217 07:28:13.309611   14495 interface.go:244] Interface "enp0s3" has 2 addresses :[192.168.1.9/24 fe80::a00:27ff:fe75:f493/64].
I0217 07:28:13.310328   14495 interface.go:211] Checking addr  192.168.1.9/24.
I0217 07:28:13.311219   14495 interface.go:218] IP found 192.168.1.9
I0217 07:28:13.311961   14495 interface.go:250] Found valid IPv4 address 192.168.1.9 for interface "enp0s3".
I0217 07:28:13.312688   14495 interface.go:395] Found active IP 192.168.1.9 
I0217 07:28:13.313427   14495 version.go:163] fetching Kubernetes version from URL: https://dl.K8S.io/release/stable-1.txt
I0217 07:28:23.320683   14495 version.go:94] could not fetch a Kubernetes version from the internet: unable to get URL "https://dl.K8S.io/release/stable-1.txt": Get https://storage.googleapis.com/kubernetes-release/release/stable-1.txt: net/http: request canceled (Client.Timeout exceeded while awaiting headers)
I0217 07:28:23.321520   14495 version.go:95] falling back to the local client version: v1.13.3
I0217 07:28:23.330622   14495 feature_gate.go:206] feature gates: &{map[]}
K8S.gcr.io/kube-apiserver:v1.13.3
K8S.gcr.io/kube-controller-manager:v1.13.3
K8S.gcr.io/kube-scheduler:v1.13.3
K8S.gcr.io/kube-proxy:v1.13.3
K8S.gcr.io/pause:3.1
K8S.gcr.io/etcd:3.2.24
K8S.gcr.io/coredns:1.2.6
```
- pull images beforehand

```
kubeadm config images pull -v 4
```

# init phase
```
kubeadm config print init-defaults >adm.defaults.yaml
git diff adm.defaults.yaml
-imageRepository: K8S.gcr.io
+imageRepository: mirrorgooglecontainers
sudo kubeadm init phase preflight --config=./adm.defaults.yaml -v 4
```


# Self-hosting the Kubernetes control plane
As of 1.8, you can experimentally create a self-hosted Kubernetes control plane. This means that key components such as the API server, controller manager, and scheduler run as DaemonSet pods configured via the Kubernetes API instead of static pods configured in the kubelet via static files.
To create a self-hosted cluster, pass the flag --feature-gates=SelfHosting=true to kubeadm init.
```

```

https://kubernetes.io/docs/setup/independent/setup-ha-etcd-with-kubeadm/
https://discuss.kubernetes.io/t/question-about-etcd-cluster-with-kubeadm-in-1-11/1228



```
kubectl get configmaps --all-namespaces
kubectl describe configmaps kubeadm-config -n kube-system

kubectl -n kube-system get deployment coredns -o yaml | \
  sed 's/allowPrivilegeEscalation: false/allowPrivilegeEscalation: true/g' | \
  kubectl apply -f -
  
kubectl scale --current-replicas=2 --replicas=1 deployments.apps/nginx1-14
kubectl logs calico-node-4mb5z -n kube-system
```  