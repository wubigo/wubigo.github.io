+++
title = "CUDA内存不足"
date = 2024-03-19T00:02:59+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = []
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


运行GLM报错

```
RuntimeError: CUDA out of memory. Tried to allocate 30.00 MiB (GPU 0; 7.43 GiB
total capacity; 6.58 GiB already allocated; 30.94 MiB free; 6.79 GiB reserved in 
total by PyTorch)
```

# 检查GPU内存使用情况

```
nvidia-smi
Mon Mar 18 23:59:31 2024
+---------------------------------------------------------------------------------------+
| NVIDIA-SMI 535.161.07             Driver Version: 535.161.07   CUDA Version: 12.2     |
|-----------------------------------------+----------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |         Memory-Usage | GPU-Util  Compute M. |
|                                         |                      |               MIG M. |
|=========================================+======================+======================|
|   0  NVIDIA GeForce RTX 3090        Off | 00000000:3B:00.0 Off |                  N/A |
|  0%   39C    P8              24W / 350W |  12288MiB / 24576MiB |      0%      Default |
|                                         |                      |                  N/A |
+-----------------------------------------+----------------------+----------------------+

+---------------------------------------------------------------------------------------+
| Processes:                                                                            |
|  GPU   GI   CI        PID   Type   Process name                            GPU Memory |
|        ID   ID                                                             Usage      |
|=======================================================================================|
|    0   N/A  N/A     32326      C   /usr/bin/python3                          12276MiB |
+---------------------------------------------------------------------------------------+

```

## 查找进程


```
pstree -s -p -a 32326

systemd,1 splash
  └─containerd-shim,31855 -namespace moby -id ac4d7b87c5f8d8ce59ff8b57d816ad118aa393bd1a75e1a2c59d9b13f024261d -address/run/con
      └─bash,31876
          └─python3,32085 startup.py -a
              └─python3,32326 -c from multiprocessing.spawn import spawn_main; spawn_main(tracker_fd=17, pipe_handle=24) 
```

可以看到该进程是从容器启动

### 查找该容器ID

```
systemd-cgls

Control group /:
-.slice
├─1692 bpfilter_umh
├─docker
│ ├─8c7291a66fc7b1300d984dcc902fcd0c309d1e2c9da5607f52ab05ea1d3fdeae
│ │ ├─41064 /bin/bash /home/aisp-cloud-release/run.sh
│ │ └─41087 java -Dloader.path=.,config,lib -Xms2g -Xmx2g -jar aisp-auth-0.0.1-SNAPSHOT.jar --spring.config.location=./config/applicat>
│ ├─ac4d7b87c5f8d8ce59ff8b57d816ad118aa393bd1a75e1a2c59d9b13f024261d
│ │ ├─31876 /bin/bash
│ │ ├─32085 python3 startup.py -a
│ │ ├─32135 /usr/bin/python3 -c from multiprocessing.resource_tracker import main;main(16)
│ │ ├─32136 /usr/bin/python3 -c from multiprocessing.spawn import spawn_main; spawn_main(tracker_fd=17, pipe_handle=19) --multiprocess>
│ │ ├─32237 /usr/bin/python3 -c from multiprocessing.spawn import spawn_main; spawn_main(tracker_fd=17, pipe_handle=18) --multiprocess>
│ │ ├─32325 /usr/bin/python3 -c from multiprocessing.spawn import spawn_main; spawn_main(tracker_fd=17, pipe_handle=22) --multiprocess>
│ │ ├─32326 /usr/bin/python3 -c from multiprocessing.spawn import spawn_main; spawn_main(tracker_fd=17, pipe_handle=24) --multiprocess>
│ │ ├─32327 /usr/bin/python3 -c from multiprocessing.spawn import spawn_main; spawn_main(tracker_fd=17, pipe_handle=26) --multiprocess>
│ │ ├─32611 /usr/bin/python3 -c from multiprocessing.spawn import spawn_main; spawn_main(tracker_fd=17, pipe_handle=28) --multiprocess>
│ │ ├─32737 /usr/bin/python3 -c from multiprocessing.spawn import spawn_main; spawn_main(tracker_fd=17, pipe_handle=30) --multiprocess>
│ │ └─32819 /usr/bin/python3 /usr/local/bin/streamlit run webui.py --server.address 0.0.0.0 --server.port 8501 --theme.base light --th>
│ ├─f339cff950b499ecdeb0b6f51758cc734253feb523f366a0b44178571e173316

```

```
docker ps |grep ac4d7b
ac4d7b87c5f8   45d060720b46     "/opt/nvidia/nvidia_…"   12 days ago    Up              chat_v1
```


### 查找容器的启动命名

```
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock:ro \
    assaflavie/runlike   <container-id>
```