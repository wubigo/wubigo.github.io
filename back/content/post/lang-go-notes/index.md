+++
title = "GO NOTES"
date = 2017-02-11T20:24:49+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["LANG", "GO"]
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

## 虚拟包版本

Untagged revisions can be referred to using a "pseudo-version" like v0.0.0-yyyymmddhhmmss-abcdefabcdef, where the time is the commit time in UTC and the final suffix is the prefix of the commit has

```
go get github.com/vladimirvivien/go4vl@40b41ba
go get: upgraded github.com/vladimirvivien/go4vl v0.0.1 => v0.0.2-0.20211216162907-40b41ba86c5c
```




## 类型转换操作

>For every type T, there is a corresponding conversion operation T(x) that converts the value x to >type T. A conversion from one type to another is allowed if both have the same underlying type, or >if both are unnamed pointer types that point to variables of the same underlying type; these >conversions change the type but not the representation of the value. If x is assignable to T, a >conversion is permitted but is usually redundant. 


## blank identifier

To ignore one of the values, assign it to the blank identifier :

```
links, _ := findLinks(url) // errors ignored


for _, url := range os.Args[1:] {
```


## import

```
ImportDeclaration = "import" ImportSpec
ImportSpec        = [ "." | "_" | Identifier ] ImportPath
```

According to language spec it depends on the implementation how 

import path (string) is   interpreted but in real life it’s path 

relative package’s vendor directory or `go env GOPATH`/src

- 定制的包名

```
# github.com/mlowicki/main.go
package main
import (
    "fmt"
    "github.com/mlowicki/b"
)
func main() {
    fmt.Println(c.B)
}
# github.com/mlowicki/b/b.go
package c
var B = "b"
```

- 初始化

```
import _ "math"
```

doesn’t require to use package math in importing file but init function(s) from imported package will be executed anyway (package and it dependencies will be initialized). It’s useful if we’re interested only in bootstrapping work done by imported package but we don’t reference any exported identifiers from it.



## How to check if a map contains a key

```
func TestMap(t *testing.T){
	attended := map[string]string{
		"Ann": "t",
		"Joe": "r",
	}
	val, ok := attended["mm"]
	fmt.Print(val, ok)
}

```

if statements in Go can include both a condition and an initialization statement. The example above uses both:

- initializes two variables - val will receive either the value of "foo" from the map or a "zero value" (in this case the empty string) and ok will receive a bool that will be set to true if "foo" was actually present in the map

- evaluates ok, which will be true if "foo" was in the map



## Constructors

two accepted best practices:

- Make the zero value of your struct a sensible default. (While this looks strange to most people coming from "traditional" oop it often works and is really convenient).
- Provide a function func New() YourTyp or if you have several such types in your package functions func NewYourType1() YourType1 and so on.

Document if a zero value of your type is usable or not (in which case it has to be set up by one of the New... functions


## empty interface (interface{} is an empty interface)

```
An interface is two things:

it is a set of methods,
but it is also a type
```

The interface{} type, the empty interface is the interface that has no methods.

Since there is no implements keyword, all types implement at least zero methods, and satisfying an interface is done automatically,all types satisfy the empty interface.

That means that if you write a function that takes an interface{} value as a parameter, you can supply that function with any value.

# Method's receiver

- go don't user special name like( this or self ) for the receiver

```
func (p Point) MoveBy(factor float){
	p.X += factor  //->  this.X += factor
}
```

- Pointer receiver


# project-layout Internal app/pkg Directory Clarification

Using /internal/pkg is about consistency if you use the /pkg pattern. The public shared code goes in '/pkg' and the private shared code goes in /internal/pkg

https://github.com/golang-standards/project-layout/issues/9


# vendor package

```
go help gopath

find . -name grpc | xargs rm -rf

/go/pkg/mod/google.golang.org$ ls

genproto@v0.0.0-20180817151627-c66870c02cf8  genproto@v0.0.0-20190127191240-7cdc0b958d75  grpc@v1.19.0  grpc@v1.19.1



```

Vendor directories do not affect the placement of new repositories
being checked out for the first time by 'go get': those are always
placed in the main GOPATH, never in a vendor subtree


# remove installed package

```
go clean -i -n google.golang.org/grpc...

cd /home/bigo/go/src/google.golang.org/grpc
rm -f grpc.test grpc.test.exe
rm -f /home/bigo/go/pkg/linux_amd64/google.golang.org/grpc.a
cd /home/bigo/go/src/google.golang.org/grpc/balancer
rm -f balancer.test balancer.test.exe
rm -f /home/bigo/go/pkg/linux_amd64/google.golang.org/grpc/balancer.a
cd /home/bigo/go/src/google.golang.org/grpc/balancer/base
rm -f base.test base.test.exe
rm -f /home/bigo/go/pkg/linux_amd64/google.golang.org/grpc/balancer/base.a
cd /home/bigo/go/src/google.golang.org/grpc/balancer/grpclb
rm -f grpclb.test grpclb.test.exe

```


# identifier export

In Go, a simple rule governs which identifiers are exported and which are not: exported identifiers start with an upper-case letter

Package-level names like the types and constants declared in one file of a package are visible to all the other files of the package, as if the source code were all in a single file

# CSP

“Another lineage among Go’s ancestors, and one that makes Go distinctive among recent programming languages,
is a sequence of little-known research languages developed at Bell Labs, all inspired by the concept of
communicating sequential processes (CSP) from Tony Hoare’s seminal 1978 paper on the foundations of concurrency. In CSP, a program is a parallel composition of processes that have no shared state; the processes communicate and synchronize using channels.”

# hindsight
“As a recent high-level language, Go has the benefit of hindsight, and the basics are done well: it has garbage collection, a package system, first-class functions, lexical scope, a system call interface, and immutable strings in which text is generally encoded in UTF-8. But it has comparatively few features and is unlikely to add more. For instance, it has no implicit numeric conversions, no constructors or destructors, no operator overloading, no default parameter values, no inheritance, no generics, no exceptions, no macros, no function annotations, and no thread-local storage”

# gofmt
Go does not require semicolons at the ends of statements or declarations, except where two or more appear on the same line. In effect, newlines following certain tokens are converted into semicolons, so where newlines are placed matters to proper parsing of Go code. For instance, the opening brace { of the function must be on the same line as the end of the func declaration, not on a line by itself, and in the expression x + y, a newline is permitted after but not before the + operator.

# point var
* “The variable to which p points is written *p. The expression *p yields the value of that variable, an int, but since *p denotes a variable, it may also appear on the left-hand side of an assignment, in which case the assignment updates the variable.”
* “Expressions that denote variables are the only expressions to which the address-of operator & may be applied.”
* “Each time we take the address of a variable or copy a pointer, we create new aliases or ways to identify the same variable. For example, *p is an alias for v.”

# Function Values have types
declare a var with function value as type 
* func(int) int -> type 
```
var f func(int) int
```

# nil pointer dereference

```
package main

import "fmt"

var f func(int) int

func main() {
	//fmt.Println(f(2))
	fmt.Println(f(2))
	f = func(i int) int {
		if i == 0 {
			return 1
		}
		return i * f(i-1)
	}
	fmt.Println(f(2))
}



panic: runtime error: invalid memory address or nil pointer dereference[signal SIGSEGV: segmentation violation code=0x1 addr=0x0 pc=0x4850f0]goroutine 1 [running]:main.main()	/home/bigo/go/src/github.com/gopl.io/ch5/t2/main.go:9 +0x30exit status 2Process exiting with code: 1
```

![nil pointer dereference](/img/post/nil_pointer_dereference.png)




# Capturing Iteration Variables


***“The problem of iteration variable capture is most often encountered when using the go statement or with defer since both may delay the execution of a function value until after the loop has finished. But the problem is not inherent to go or defer.”***

```
var s1 [3]int = [3]int{1, 2, 3}
var fs []func()

func main() {
	for _, v := range s1 {
		//fmt.Printf("%d\n", v)
		fs = append(fs, func() {
			fmt.Printf("%d\n", v) //v is caputed and shared
		})
	}

	for _, f := range fs {
		f()
	}

	fs = nil
	for _, v := range s1 {
		i := v
		fs = append(fs, func() {
			fmt.Printf("%d\n", i)
		})
	}

	for _, f := range fs {
		f()
	}

}

```
The reason is a consequence of the scope rules for loop variables. In the program immediately above, the for loop introduces a new lexical block in which the variable dir is declared. All function values created by this loop “capture” and share the same variable—an addressable storage location, not its value at that particular moment. The value of dir is updated in successive iterations, so by the time the cleanup functions are called, the dir variable has been updated several times by the now-completed for loop.

# expression in go/defer must be function call

* express anonymous function as function call() 

```
var s1 [3]string = [3]string{"go", "func", "value"}

func f(s string) {
	fmt.Println(s)
}

func main() {
	fmt.Println("s escapsed")
	for _, s := range s1 {
		defer func() { fmt.Println(s) }()
	}

	fmt.Println("work expected")

	for _, s := range s1 {
		defer func(s string) { fmt.Println(s) }(s)
	}

	for _, s := range s1 {
		defer f(s)
	}

	for _, s := range s1 {
		go func(s string) {
			fmt.Println("h %s", s)
		}(s)
	}

	for _, s := range s1 {
		go f(s)
	}

}
```



# install go-1.10

***vscode will report go-runtime read-only error which has been installed via snap
```
sudo add-apt-repository ppa:gophers/archive
sudo apt-get update
sudo apt-get install golang-1.10-go
export GOROOT="/usr/lib/go-1.10"
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin:$GOROOT/bin/"
go version
```

# GOPATH directory

```
cd $GOPATH
ls
src     bin    pkg
```
DIR | |
:---|:---
pkg | 存放编译过的包
bin | 存放可执行程序(package main)

# import path两个功能

```
go help importpath
```

- 在本地文件系统$GOPATH/pkg/$GOOS_$GOARCH/<import_path>查找

```
import "github.com/google/go-github/github"

...
go/src/wubigo.com/cloud/github_client/main.go:7:2: cannot find package "github.com/google/go-github/github" in any of:
	/usr/lib/go-1.11/src/github.com/google/go-github/github (from $GOROOT)
	/home/bigo/go/src/github.com/google/go-github/github (from $GOPATH)
Process exiting with code: 1
...
```
- 如果没找到，需要go get通过<import_path>安装

```
go get github.com/google/go-github/github
```

- import path custom domain name
  

```
curl golang.org/x/tools/cmd/rename
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="go-import" content="golang.org/x/tools git https://go.googlesource.com/tools">
<meta name="go-source" content="golang.org/x/tools https://github.com/golang/tools/ https://github.com/golang/tools/tree/master{/dir} https://github.com/golang/tools/blob/master{/dir}/{file}#L{line}">
<meta http-equiv="refresh" content="0; url=https://godoc.org/golang.org/x/tools/cmd/rename">
</head>
<body>
Nothing to see here; <a href="https://godoc.org/golang.org/x/tools/cmd/rename">move along</a>.
</body>
```


>Canonical import paths

The syntax is simple: put an identifying comment on the package line

https://github.com/golang/tools/blob/master/cmd/gorename/main.go

```
package main // import "golang.org/x/tools/cmd/gorename"
```


# struct tags

- List of well-known struct tags

Tag |	Documentation
:---|:---
xml |	https://godoc.org/encoding/xml
json |	https://godoc.org/encoding/json
asn1 |	https://godoc.org/encoding/asn1
reform| 	https://godoc.org/gopkg.in/reform.v1
bigquery| 	https://godoc.org/cloud.google.com/go/bigquery
datastore| 	https://godoc.org/cloud.google.com/go/datastore
spanner |	https://godoc.org/cloud.google.com/go/spanner
bson |	https://godoc.org/labix.org/v2/mgo/bson
gorm |	https://godoc.org/github.com/jinzhu/gorm
yaml |	https://godoc.org/gopkg.in/yaml.v2


## field tags


A field tag is a string of metadata
associated at compile time with the field of a struct:
```
Year int `json:"released"`
Color bool `json:"color,omitempty"`
```
A field tag may be any literal string , but it is conventionally interpreted as a space-separated
list of key:"value" pairs; since they contain double quotation marks, field tags are usually
written with raw string literals. The json key control s the behavior of the encoding/json
package, and other encoding/... packages follow this convention. The first part of the json
field tag specifies an alternative JSON name for the Go field