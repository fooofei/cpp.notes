
# 执行顺序

autoheader 

aclocal

autoconf

automake

sh ./configure


# ignore deps 

如果已经编译过，把工程目录移动到其他目录，会发生编译错误。

因为 dep 的目录不正确。

解决

$ autoconf --force
  -f, --force               consider all files obsole 考虑所有文件过时
无效

$ automake --ignore-deps
有效
.deps 目录里文件没重新生成 但是也不再使用它了