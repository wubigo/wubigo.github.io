+++
title = "K8s Private Registry"
date = 2017-03-17T06:44:46+08:00
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


# Configuring Nodes to Authenticate to a Private Registry

>Note: Kubernetes as of now only supports the auths and HttpHeaders section of docker config. This means credential helpers (credHelpers or credsStore) are not supported.

Docker stores keys for private registries in the $HOME/.dockercfg or $HOME/.docker/config.json file. If there are files in the search paths list below, kubelet uses it as the credential provider when pulling images.

  + {--root-dir:-/var/lib/kubelet}/config.json
  + {cwd of kubelet}/config.json
  + ${HOME}/.docker/config.json
  + /.docker/config.json
  + {--root-dir:-/var/lib/kubelet}/.dockercfg
  + {cwd of kubelet}/.dockercfg
  + ${HOME}/.dockercfg
  + /.dockercfg


`~/.docker/config.json`

```
"auths": {		
		"registry.cn-hangzhou.aliyuncs.com": {
			"auth": "d3ViaWdvOjEyMzEyMwo="
		}
	},
	"HttpHeaders": {
		"User-Agent": "Docker-Client/17.03.3-ce (linux)"
	}
```

- convert the base64-encoded auth data to a readable format

```
echo "d3ViaWdvOjEyMzEyMwo=" | base64 --decode 
```


```
nodes=$(kubectl get nodes -o jsonpath='{range.items[*].metadata}{.name} {end}')
for n in $nodes; do scp ~/.docker/config.json root@$n:/var/lib/kubelet/config.json; done
```



https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/



https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/