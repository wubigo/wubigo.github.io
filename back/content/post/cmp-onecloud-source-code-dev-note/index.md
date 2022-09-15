+++
title = "Onecloud Source Code Dev Note"
date = 2018-06-10T11:13:09+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["CMP"]
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

## 删除

```
systemctl list-unit-files --all | grep yunion
systemctl disable yunion-executor
systemctl disable yunion-registry
systemctl disable kubelet
rm -rf /opt/yunion
systemctl disable libvirtd.service
ip link set virbr0 down
brctl delbr virbr0
```


##  operator

```
kubectl logs -n onecloud default-region- -c init
```

```
kubectl edit deployments. -n onecloud onecloud-operator

  containers:
      - command:
        - /bin/onecloud-controller-manager
        - -sync-user


```

onecloud-operator，加上‘-sync-user' 会自动修改用户密码，
然后再 kubectl delete deployments -n onecloud default-region 等待重建再试试

## WEB

前端代码是很多 git 仓库组成的，需要用 'yarn sync release/3.1' 统一切分支，

依赖 bash 执行脚本

```
yarn sync release/3.1
```

```
C:\code>node -v
v10.21.0
```

```
kubectl logs -f -n onecloud default-apigateway-
```


```
kubectl get svc -n onecloud
```


```
git clone https://github.com/yunionio/dashboard.git
yarn setup:dev
yarn install
修改 vue.config.js 里面api 后端 server 为: target: 'https://x.x.x.x:30300'
然后切换分支使用：yarn sync release/3.1
yarn run serve
```

## climc




```
export KUBECONFIG=/etc/kubernetes/admin.conf
source <(kubectl completion bash)
source <(ocadm cluster rcadmin)


ocadm cluster rcadmin
export OS_AUTH_URL=https://10.8.3.231:30500/v3
export OS_USERNAME=sysadmin
export OS_PASSWORD=kHJ8RUv9ZnXM8dB3
export OS_PROJECT_NAME=system
export YUNION_INSECURE=true
export OS_REGION_NAME=region0
export OS_ENDPOINT_TYPE=publicURL


 climc service-list --limit 30
+----------------------------------+------------------+------------------+
|                ID                |       Name       |       Type       |
+----------------------------------+------------------+------------------+
| e3542d1d411342128a27d768f0ee2355 | monitor          | monitor          |
| 78d193ba157c4f5e894c6ba562a4bf46 | notify           | notify           |
| 6d0f8ba57a2b4f95834aabf35b2b60ee | log              | log              |
| 7b81c471a8174a7181e966e9c240031a | cloudevent       | cloudevent       |
| 45a984fa8cde426a8aff471a5235c6fa | devtool          | devtool          |
| 3b8a28d49abb43238d5d70743cc82073 | k8s              | k8s              |
| aa92817f666b468f858e12e24543a50a | autoupdate       | autoupdate       |
| 69c977c7a1d348738ebb4afa4004c1a0 | yunionconf       | yunionconf       |
| 5aa6bef960c84fcd8b0befd9433eac13 | cloudnet         | cloudnet         |
| 44540d5bee304eca8df2afa6db245c07 | baremetal        | baremetal        |
| 757fc06c274d4898882c8454d21e9f38 | webconsole       | webconsole       |
| 6a489082b899415a8ebb7ff36549372a | s3gateway        | s3gateway        |
| 0433e9da686940428e270da2726d1999 | influxdb         | influxdb         |
| 2ba92f93d97c423c898181ee01553bbf | host             | host             |
| d1ac196db62c4dfb8ae89386fa9adbe4 | meter            | meter            |
| 5f032e88f8c143178396de326e132880 | websocket        | websocket        |
| 18f7844be9f343d48dccf09c0ccf2d22 | yunionapi        | yunionapi        |
| 8286d967b6a543368a003af964ea7d8f | ansible          | ansible          |
| 2598d51c504241cf87816946471918e5 | yunionagent      | yunionagent      |
| a8bdb942b5d94ec7820908fca06024ed | glance           | image            |
| 80f40414f0bb43d88f4d7d3c7c0c0102 | scheduler        | scheduler        |
| e5ec699df47046cc8cfc886f6f1d43ef | region2          | compute_v2       |
| c889bded7d1240088d4a6319a0ffc59d | keystone         | identity         |
| 62be59b2ff3f433e8eef225558759dd9 | offlinecloudmeta | offlinecloudmeta |
| 5e6c21fe140045538b6defbc51c4ac76 | torrent-tracker  | torrent-tracker  |
| 59c52837183d4e6488baa87a17136c64 | cloudmeta        | cloudmeta        |
| 57238806433146da81540364d4699e78 | common           | common           |
| 0107fd19803c41c58eadfb5920908ab3 | external-service | external-service |
+----------------------------------+------------------+------------------+
***  Total: 28 Pages: 1 Limit: 30 Offset: 0 Page: 1  ***



climc user-list  ----system --limit 50
+----------------------------------+-----------------+-----------+---------+-------------------+-------------------+------------+
|                ID                |      Name       | Domain_Id | Enabled | is_system_account | allow_web_console | enable_mfa |
+----------------------------------+-----------------+-----------+---------+-------------------
| 785bed264dd743ae8195a6b04251c091 | autoupdate      | default   | true    | true              | true              | true       |
| 4d2f62971c484785813a646d7c359ce3 | webconsole      | default   | true    | true              | true              | true       |
| 2bdab8e377e043fd83ba0e6609a4e171 | devtooladmin    | default   | true    | true              | true              | true       |
| 782c97e3f957473884911e5de6133f68 | kubeserver      | default   | true    | true              | true              | true       |
| da0cd74578ef4a2d8977fb2b2d42fffa | cloudeventadmin | default   | true    | true              | true              | true       |
| 5cdd64e1a5d0406784f0b9cd3c8e8810 | monitoradmin    | default   | true    | true              | true              | true       |
| 2f7b52ef757c4e91867c8142ea929e69 | cloudnetadmin   | default   | true    | true              | true              | true       |
| a052a6ef82864cbf8ed3b93b41fb5f61 | loggeradmin     | default   | true    | true              | true              | true       |
| b60f1f9e647549f288f88cabc46d22e9 | notify          | default   | true    | true              | true              | true       |
| e26576d1d6b944eb8b49f0f5fa51d8d1 | yunionconf      | default   | true    | true              | true              | true       |
| 07e79ecc86de401f8d044852ffeb78ea | s3gatewayadm    | default   | true    | true              | true              | true       |
| 05d3dce5930a423d89c0d7949d7f47d1 | hostadmin       | default   | true    | true              | true              | true       |
| f43807f7d2d14f4386a54969882da1b9 | baremetal       | default   | true    | true              | true              | true       |
| 78baf2c80c6e43d78de3154b807036f8 | vpcagentadmin   | default   | true    | true              | true              | true       |
| 31d80c3b895d42f78742992c5a979bc4 | esxiagent       | default   | true    | true              | true              | true       |
| 92f048c9992d49c68c1fa74c464bf392 | meterdocker     | default   | true    | true              | true              | true       |
| 74fbc304ab9b4b8a8ac61f68f5d3207d | yunionapi       | default   | true    | true              | true              | true       |
| 942ad02a2bd64fae82f6c60a7b436bf8 | ansibleadmin    | default   | true    | true              | true              | true       |
| 6f35945d01614e2381909b9f1f106966 | yunionagent     | default   | true    | true              | true              | true       |
| f11f9af9a9e5429c83becc7e8f18a174 | glance          | default   | true    | true              | true              | true       |
| 6e112d6d6453411f850c5dc6bcd0ab9f | regionadmin     | default   | true    | true              | true              | true       |
| 7d3ede40910a4ab9812b7f8d5a9ddd6d | sysadmin        | default   | true    | true              | false             | false      |
+----------------------------------+-----------------+-----------+---------+-------------------+-------------------+------------+

climc user-update --password demo123 demo

climc session-show
```


## keystone


```
git clone https://github.com/yunionio/onecloud.git --branch=v3.1.8
```

`\etc\yunion\keystone.conf`

- 初始化

```
auto_sync_table: true
```

自动创建表，创建完后关闭


```
kubectl describe cm -n onecloud default-keystone
```


## climc

```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [

        {
            "name": "Launch",
            "type": "go",
            "request": "launch",
            "mode": "auto",
            "program": "${fileDirname}/../cmd/climc/main.go",
            "env": {"OS_AUTH_URL": "https://192.168.137.176:30500/v3",
                    "OS_USERNAME": "sysadmin",
                    "OS_PASSWORD": "tNZKXrk3SggGBtm9",
                    "OS_PROJECT_NAME": "system",
                    "YUNION_CERT_FILE": "/etc/yunion/pki/service.crt",
                    "YUNION_KEY_FILE": "/etc/yunion/pki/service.key",
                    "YUNION_INSECURE": "true",
                    },
            "args": []
        }
    ]
}

```

## 本地开发测试

https://docs.yunion.io/docs/contribute/contrib/#本地开发调试


## onecloud-operator

`pkg/apis/onecloud/v1alpha1/register.go`

```
func init() {
	localSchemeBuilder.Register(addKownTypes, addDefaultingFuncs)
}
```

完成服务组件用户创建工作


- 测试代码

`onecloud-operator\pkg\util\k8s\marshal_test.go`


```
TestMarshalToYamlForCodecs
```

## 服务暂停

```
kubectl scale --replicas=0 deployment -n onecloud onecloud-operator
kubectl get deployments. -n onecloud | grep default | awk '{print $1}' | xargs kubectl delete deployments. -n onecloud
```

- 恢复

```
kubectl scale --replicas=1 deployment -n onecloud onecloud-operator
```