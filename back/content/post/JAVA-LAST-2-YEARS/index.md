+++
title = "JAVA这两年"
date = 2019-10-29T10:17:03+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["JAVA", "GRAAL"]
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


JAVA 这两年最重要的项目就是GRAAL的正式版发布。


GRAAL能做什么？

- 让解释性程序例如JAVA, JS 运行的更快: AOT编译为宿主二进制可执行文件,

  启动时间小于100ms， 像C, GO, ERLANG一样的执行速度

- 更低的内存占用：只占用传统的JVM应用20%的内存  

听起来是不是该项目为函数计算做准备的？

是，但不完全是。

GRAAL的官方目标是提供一个统一的虚拟机执行平台，支持如下运行环境：

- JavaScrip
- Python
- Ruby
- R
- JVM 语言（Java, Scala, Groovy, Kotlin, Clojure）
- LLVM语言 (C , C++)

**而且不同语言之间零成本互相调用**




# 安装

```
wget https://github.com/oracle/graal/releases/download/vm-19.2.1/graalvm-ce-linux-amd64-19.2.1.tar.gz

tar zxvf graalvm-ce-linux-amd64-19.2.1.tar.gz
export PATH=$PATH:$GRAAL_HOME/bin
```


- 检查

```
js --version
GraalVM JavaScript (GraalVM CE Native 19.2.1)
```

- 安装native-image

```
gu install native-image
```

```
gu available
Downloading: Component catalog from www.graalvm.org
ComponentId              Version             Component name      Origin
--------------------------------------------------------------------------------
llvm-toolchain           19.2.1              LLVM.org toolchain  github.com
native-image             19.2.1              Native Image        github.com
python                   19.2.1              Graal.Python        github.com
R                        19.2.1              FastR               github.com
ruby                     19.2.1              TruffleRuby         github.com
```



# 使用Polyglot Shell

```
polyglot --jvm --shell
```

# 创建JAVA编写的可执行二进制文件

- 安装glibc-devel, zlib-devel (头文件C库 and zlib) 和 gcc

```
sudo apt-get install libz-dev
```

`HelloWorld.java`

```
public class HelloWorld {
   public static void main(String... args) {
      System.out.println("Hello World");
   }
}
```

- 编译

```
javac HelloWorld.java
native-image -cp . HelloWorld

Build on Server(pid: 20375, port: 45977)
[helloworld:20375]    classlist:     199.03 ms
[helloworld:20375]        (cap):   1,866.60 ms
[helloworld:20375]        setup:   5,938.57 ms
[helloworld:20375]   (typeflow):  17,532.76 ms
[helloworld:20375]    (objects):   8,477.10 ms
[helloworld:20375]   (features):   2,365.65 ms
[helloworld:20375]     analysis:  28,469.52 ms
[helloworld:20375]     (clinit):     861.90 ms
[helloworld:20375]     universe:   2,785.89 ms
[helloworld:20375]      (parse):   9,430.36 ms
[helloworld:20375]     (inline):   1,623.19 ms
[helloworld:20375]    (compile):  11,158.60 ms
[helloworld:20375]      compile:  22,588.75 ms
[helloworld:20375]        image:     687.25 ms
[helloworld:20375]        write:   1,153.04 ms
[helloworld:20375]      [total]:  62,321.01 ms

```

- 执行

```
./helloworld
Hello World
```

# 部署到容器

# 微服务

http://sparkjava.com/

https://quarkus.io/get-started/

https://github.com/spring-projects/spring-framework/wiki/GraalVM-native-image-support


# 参考

https://royvanrijn.com/blog/2018/09/part-2-native-microservice-in-graalvm/
