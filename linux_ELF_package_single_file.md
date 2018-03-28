
### Linux 二进制文件打包尝试

使用的工具 http://www.magicermine.com/trial/ErmineLightTrial.x86_64/ErmineLightTrial.x86_64/ErmineLightTrial.x86_64.html

我们编译了一个二进制文件 test ，x86_x64 架构的，通过 C 代码编译的，编译的时候找的动态库都是本机 （叫 A）目录的

如 `/lib64/` `/usr/local/lib/` 的。

如果 test 要放到 B 机器运行，那么要附带拷贝它依赖的那些动态库一起到机器 B，这样繁杂。

使用一个工具，把 test 及其依赖的库打包为 1 个文件，可执行，分发这 1 个文件到机器 B 就可以了。

工具使用：下载后

```shell
$ chmod +x ErmineLightTrial.x86_64
./ErmineLightTrial.x86_64 test --output test_single
```

分发 test_single 就行了

20180328 实测可行。


### 笨办法 打包所有依赖

拷贝一个 可执行 ELF 文件依赖的库的几种方案

http://www.metashock.de/2012/11/export-binary-with-lib-dependencies/
ldd fpath/fpath | cut -d'>' -f2 | awk '{print $1}'


http://www.commandlinefu.com/commands/view/10238/copy-all-shared-libraries-for-a-binary-to-directory
ldd fpath/fpath | grep "=> /" | awk '{print $3}'



https://h3manth.com/content/copying-shared-library-dependencies
ldd fpath/fpath | awk 'BEGIN{ORS=" "}fpath/fpath~/^\//{print fpath/fpath}$3~/^\//{print $3}' | sed 's/,$/\n/'
太复杂了 运行失败
awk: cmd. line:1: (FILENAME=- FNR=1) fatal: division by zero attempted
