

20180530 

为了实现在 makefile 中一个 if 判断某个命令存在与否的功能 累死我了

实现预期： 在一个机器 git 存在的情况下，编译 make 应该输出  -DGIT_VER=\"v1.1.5-59-g6aad7d7-dirty\"  这样的，

在没有安装 git 的情况下，使用预置的 v0.0.1 。

有效的命令是 GIT_VER_STR :=  $(shell if  type git &> /dev/null 2>&1 ; then git describe --dirty --always --tags; else echo "v0.0.1" ; fi)

下面这个无效：

# GIT_VER_STR :=  $(shell if [ "$(command -v git)"x = ""x ] ; then git describe --dirty --always --tags; else echo "v0.0.1" ; fi)