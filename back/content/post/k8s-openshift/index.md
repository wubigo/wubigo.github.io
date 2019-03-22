+++
title = "K8s Openshift"
date = 2018-03-20T18:47:37+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["K8S", "PAAS"]
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

**v3.11.0->k8s 1.11**

# openshift all-in-one

```
curl https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
tar zxf openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
cd openshift
export PATH="$(pwd)":$PATH
sudo ./openshift start master
```

# oc setup

```
export KUBECONFIG="$(pwd)"/openshift.local.config/master/admin.kubeconfig
export CURL_CA_BUNDLE="$(pwd)"/openshift.local.config/master/ca.crt
sudo chmod +r "$(pwd)"/openshift.local.config/master/admin.kubeconfig
openshift complition bash > /usr/share/bash-completion/completions/openshift.complition.sh

```


# master and node configuration after installation

`/etc/origin/master/master-config.yaml`

```
identityProviders:
  - name: my_allow_provider 
    challenge: true 
    login: true 
    provider:
      apiVersion: v1
      kind: AllowAllPasswordIdentityProvider
corsAllowedOrigins
```


# Identity Providers

The OpenShift master includes a built-in OAuth server
the Deny All identity provider is used by default, which denies access for all user names and passwords. To allow access, you must choose a different identity provider and configure the master configuration file appropriately (located at /etc/openshift/master/master-config.yaml by default).


```
oc login -u system:admin
```