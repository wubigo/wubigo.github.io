+++
title = "K8s Kubelet"
date = 2017-03-30T07:41:36+08:00
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


# PodUID

```
kubectl get pod <PID_NAME> -o=jsonpath='{.metadata.uid}'
```

# POD on disk 


`/var/lib/kubelet/pods/<PodUID>/`

`/var/log/pods/<PodUID>/<container_name>`

```
ls -l /var/log/pods/<PodUID>/<container_name>/
lrwxrwxrwx 1 root root 165 3月  30 06:52 0.log -> /var/lib/docker/containers/e74eafc4b3f0cfe2e4e0462c93101244414eb3048732f409c29cc54527b4a021/e74eafc4b3f0cfe2e4e0462c93101244414eb3048732f409c29cc54527b4a021-json.log
```


In a production cluster, logs are usually collected, aggregated, and shipped to a remote store where advanced analysis/search/archiving functions are supported. In kubernetes, the default cluster-addons includes a per-node log collection daemon, fluentd. To facilitate the log collection, kubelet creates symbolic links to all the docker containers logs under /var/log/containers with pod and container metadata embedded in the filename.

/var/log/containers/<pod_name>_<pod_namespace>_<container_name>-<container_id>.log`


`/var/log/containers/`

```
ls -l 
```