+++
title = "GO NOTES"
date = 2018-02-11T20:24:49+08:00
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

