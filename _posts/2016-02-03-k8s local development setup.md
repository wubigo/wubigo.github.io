---
layout: post
title: k8s local development setup
date: 2016-02-03
tag: [Paas, k8s]
---


* build v1.11.7

```
git clone -b v1.11.7 https://github.com/wubigo/kubernetes.git
cd kubernetes
git remote add upstream https://github.com/kubernetes/kubernetes.git
git remote set-url --push upstream no_push
git fetch upstream
git tag|grep v1.11.7
git checkout tags/v1.11.7 -b <branch_name>
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-cross:v1.11.4-1
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-cross:v1.11.4-1 k8s.gcr.io/kube-cross:v1.11.4-1
./build/run.sh make quick-release
./_output/dockerized/bin/linux/amd64/kubeadm version| grep v1.11.7
```
* disable swap



Coverage is disabled.
# k8s.io/
runtime.largeAlloc(0x66b802a, 0x450101, 0x7f79fe6c3d80)
	/usr/local/go/src/runtime/malloc.go:1019 +0x97
runtime.mallocgc.func1()
	/usr/local/go/src/runtime/malloc.go:914 +0x46
runtime.systemstack(0x0)
	/usr/local/go/src/runtime/asm_amd64.s:351 +0x66
runtime.mstart()
	/usr/local/go/src/runtime/proc.go:1229

goroutine 1 [running]:
runtime.systemstack_switch()
	/usr/local/go/src/runtime/asm_amd64.s:311 fp=0xc000664810 sp=0xc000664808 pc=0x454d20
runtime.mallocgc(0x66b802a, 0x5ff720, 0x101, 0x335bf3d)
	/usr/local/go/src/runtime/malloc.go:913 +0x896 fp=0xc0006648b0 sp=0xc000664810 pc=0x40bb56
runtime.makeslice(0x5ff720, 0x66b802a, 0x66b802a, 0xc647c25af55e97b6, 0xc000664970, 0x411556)
	/usr/local/go/src/runtime/slice.go:70 +0x77 fp=0xc0006648e0 sp=0xc0006648b0 pc=0x440237
cmd/link/internal/sym.(*Symbol).Grow(0xc071324ee0, 0x335c014)
	/usr/local/go/src/cmd/link/internal/sym/symbol.go:82 +0x89 fp=0xc000664950 sp=0xc0006648e0 pc=0x4e85c9
cmd/link/internal/ld.ftabaddstring(0xc00051c000, 0xc071324ee0, 0xc013bbc140, 0x4a, 0x7fdba0)
	/usr/local/go/src/cmd/link/internal/ld/pcln.go:109 +0x53 fp=0xc000664980 sp=0xc000664950 pc=0x586123
cmd/link/internal/ld.(*Link).pclntab.func1(0xc013bbc140, 0x4a, 0x335bf70)
	/usr/local/go/src/cmd/link/internal/ld/pcln.go:241 +0xb0 fp=0xc0006649e0 sp=0xc000664980 pc=0x597710
cmd/link/internal/ld.(*Link).pclntab(0xc00051c000)
	/usr/local/go/src/cmd/link/internal/ld/pcln.go:304 +0x729 fp=0xc000664ce8 sp=0xc0006649e0 pc=0x586cf9
cmd/link/internal/ld.Main(0x7d2c20, 0x10, 0x20, 0x1, 0x7, 0x10, 0x64fdf0, 0x1b, 0x64cf34, 0x14, ...)
	/usr/local/go/src/cmd/link/internal/ld/main.go:228 +0xb09 fp=0xc000664e80 sp=0xc000664ce8 pc=0x5843b9
main.main()
	/usr/local/go/src/cmd/link/main.go:65 +0x227 fp=0xc000665f98 sp=0xc000664e80 pc=0x5dc917
runtime.main()
	/usr/local/go/src/runtime/proc.go:201 +0x207 fp=0xc000665fe0 sp=0xc000665f98 pc=0x42bb87
runtime.goexit()
	/usr/local/go/src/runtime/asm_amd64.s:1333 +0x1 fp=0xc000665fe8 sp=0xc000665fe0 pc=0x456c81
!!! [0123 13:01:01] Call tree:
!!! [0123 13:01:01]  1: /go/src/k8s.io/kubernetes/hack/lib/golang.sh:624 kube::golang::build_some_binaries(...)
!!! [0123 13:01:01]  2: /go/src/k8s.io/kubernetes/hack/lib/golang.sh:758 kube::golang::build_binaries_for_platform(...)
!!! [0123 13:01:01]  3: hack/make-rules/build.sh:27 kube::golang::build_binaries(...)
!!! Error in /go/src/k8s.io/kubernetes/hack/lib/golang.sh:582
  Error in /go/src/k8s.io/kubernetes/hack/lib/golang.sh:582. '((i<5-1))' exited with status 2
Call stack:
  1: /go/src/k8s.io/kubernetes/hack/lib/golang.sh:582 kube::golang::build_some_binaries(...)
  2: /go/src/k8s.io/kubernetes/hack/lib/golang.sh:624 kube::golang::build_binaries_for_platform(...)
  3: /go/src/k8s.io/kubernetes/hack/lib/golang.sh:758 kube::golang::build_binaries(...)
  4: hack/make-rules/build.sh:27 main(...)
Exiting with status 1
!!! [0123 13:01:01] Call tree:
!!! [0123 13:01:01]  1: hack/make-rules/build.sh:27 kube::golang::build_binaries(...)
!!! Error in /go/src/k8s.io/kubernetes/hack/lib/golang.sh:754
  Error in /go/src/k8s.io/kubernetes/hack/lib/golang.sh:754. '((i<3-1))' exited with status 1
Call stack:
  1: /go/src/k8s.io/kubernetes/hack/lib/golang.sh:754 kube::golang::build_binaries(...)
  2: hack/make-rules/build.sh:27 main(...)
Exiting with status 1
!!! [0123 13:01:01] Call tree:
!!! [0123 13:01:01]  1: hack/make-rules/build.sh:27 kube::golang::build_binaries(...)
!!! Error in /go/src/k8s.io/kubernetes/hack/lib/golang.sh:678
  Error in /go/src/k8s.io/kubernetes/hack/lib/golang.sh:678. '((i<3-1))' exited with status 1
Call stack:
  1: /go/src/k8s.io/kubernetes/hack/lib/golang.sh:678 kube::golang::build_binaries(.
