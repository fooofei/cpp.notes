

# UDP

## 使用纯 linux 命令收发 UDP 报文

```shell
exec 3<>/dev/udp/127.0.0.1/5678
echo "hello" >&3
cat <&3
```

`netcat` 是更好的工具，但是需要 `yum -y install nc` 来安装。

# Disk

## Back disk space when deleted file

[Why is space not being freed from disk after deleting a file in Red Hat Enterprise Linux?] https://access.redhat.com/solutions/2316



## Mount New Drive


## Delete File

有一个奇怪的文件名 `-slow_read_stats.csv` ,

`rm`  `ll` 命令都输出无效.

```shell
# rm -f "-slow_read_stats.*"
rm: invalid option -- 's'
Try 'rm --help' for more information.

# ll *slow_read*
ls: invalid line width: _read_stats.csv

```

删除这个文件的办法：
```shell
rm -f -- -slow_*
```


## Disk Space

`ncdu`



# Print each command after executed

```shell
sh -x xxxx
```





# Docker

The new docker name is `Docker CE`, old name is `Docker` or `Docker Engine`.

[CentOS 安装 Docker CE] https://yeasy.gitbooks.io/docker_practice/content/install/centos.html


# SS (netstat)

Linux Tool `ss` is the new version of `netstat`.

[ss command: Display Linux TCP / UDP Network/Socket Information] https://www.cyberciti.biz/tips/linux-investigate-sockets-network-connections.html

`ss -ltpn` for show IPv4 TCP Listen addres


# TCP/IP Stack

[mTCP] https://github.com/mtcp-stack/mtcp

[How to receive a million packets per second] https://blog.cloudflare.com/how-to-receive-a-million-packets/?utm_source=hackernewsletter&utm_medium=email&utm_term=code

[DPDK-ANS] https://github.com/ansyun/dpdk-ans

[IP Header Validation] https://www.freesoft.org/CIE/RFC/1812/94.htm

[F-Stack] https://github.com/F-Stack/f-stack

[Jupiter] https://github.com/tiglabs/jupiter

[Ethr] https://github.com/Microsoft/ethr

# Rsync

Local => Remote

```shell
rsync -avR <local directory/local file>  <user>@<IP>:<remote path>
```

`-a` is all

`-R` is recursive, make the remote directory structure same as local.

# LinuxBrew

https://github.com/Linuxbrew/brew/wiki/CentOS6#install-linuxbrew-on-centos-6-without-sudo


# `ldd`

`ldd` is a script, not a ELF file.



# `nm`

```shell
nm -a

nm -D
```

# Force Make Libc Static link

[在Linux下，如何强制让GCC静态链接?]  https://www.zhihu.com/question/22940048/answer/222625910


# Affinity

线程：
```c
int pthread_setaffinity_np(pthread_t thread, size_t cpusetsize，
const cpu_set_t *cpuset);

int pthread_getaffinity_np(pthread_t thread, size_t cpusetsize,
cpu_set_t *cpuset);

int sched_setaffinity(pid_t pid, size_t cpusetsize,
cpu_set_t *mask);

int sched_getaffinity(pid_t pid, size_t cpusetsize,
cpu_set_t *mask);
```

`taskset` 命令行


一个设想： 2 个线程，操作 1 个全局变量，如果设置 2 个线程的亲和性都到一个 CPU 上，是不是用不到加锁了？

要加锁，因为不是原子执行。


# Nat / Port Map


A 与 B 互通， B 与 C 互通， A 无法与 C 互通。

使用 NAT 方式能解决 A C 互通问题。

若要 做到 A 能访问 C ，如访问为 IP-C:PORT-c 要在 B 中增加映射 IP-B:PORT-B -> IP-C:PORT-C
且在 A 中要更改访问为 IP-B:PORT-B , PORT-B 为在 B 中增加的端口。

## ssh tunnel

我能直接访问机器 A ，A能访问机器B

我想做到在我的机器上直接 ssh 访问机器B，需要打隧道

出现错误
```
[root@localhost ~]# channel 3: open failed: administratively prohibited: open failed
```
修改 `/etc/ssh/sshd_config`
```
AllowTcpForwarding yes
PermitTunnel yes
```
都无效

需要机器 A B 都打开 `AllowTcpForwarding yes`


https://unix.stackexchange.com/questions/115897/whats-ssh-port-forwarding-and-whats-the-difference-between-ssh-local-and-remot
这个图画的很好看，就是没看懂

## rinetd tunnel

ssh 复杂 ，试试 `rinetd`
https://centos.pkgs.org/7/nux-misc-x86_64/rinetd-0.62-9.el7.nux.x86_64.rpm.html

```
vim /etc/rinetd.conf
0.0.0.0 33  <目标机器> 22
systemctl restart rinetd
```

# Can Use `memcpy` on `pthread_mutex_t` ?

`
# Dynamic library path / Rpath

ld.so.cache
有时候疑惑，写的项目里没有写过那个 path，但是 ldd -r <elf> 能看到引用那个 path 下的一个 .so 文件。

后来找到原因，是因为在 /etc/ld.so.conf.d目录下，存在一个 xxx.conf文件记录了这个 path。所以会从这个 path 下寻找 .so文件。

验证：

当我删除 /etc/ld.so.conf.d 下的那个 xxx.conf 文件后，运行 ldconfig ( 修改完 /etc/ld.so.conf.d，要运行这个命令，是为了更新缓存文件 /etc/ld.so.cache，而 /etc/ld.so.cache 才是 ELF 文件使用的。 )，
再次运行 ldd -r <ELF> 验证不再去那个 path 目录下寻找 .so 文件了。

ELF 会依据这个目录中文件的指引去加载 .so ，这些步骤都是手动的，与 ELF文件所在的项目无关，不是修改项目 makefile 做到的。

ld 这个命令就是去 /etc/ld.so.conf.d 目录找的。

```shell
$ ldconfig -p
344 libs found in cache `/etc/ld.so.cache'
```

makefile 中写了 -L 能解决项目编译生成过程中的 undefined reference 或者 undefined symbol ，

但是拿着我们的二进制到其他机器运行的时候，就可能找不到某个 .so，这时候可以在 makefile 中使用

-Wl,rpath=<your_lib_dir> 指定一个存放运行使用到的众多 .so 目录，在运行的时候，会去这个目录找。

使用 `readelf -d <ELF>` 能看到这个目录。

## `-l` in Makefile
比如我们的项目里用到了 curl，
我们 `yum -y install libcurl-devel` 肯定是没问题的，`include` 文件和 `/usr/lib64/libcurl.so` 都会有。

但是我不想做这一步。

我发现我的机器上本来就有 
```
$ ll /usr/lib64/libcurl.so*
lrwxrwxrwx. 1 root root   16 3月  12 14:11 /usr/lib64/libcurl.so.4 -> libcurl.so.4.3.0
-rwxr-xr-x. 1 root root 425K 2月   2 12:49 /usr/lib64/libcurl.so.4.3.0

```
只是缺少 `ln -s /usr/lib64/libcurl.so.4.3.0 /usr/lib64/libcurl.so` 。

这一步显然我们是不能多做的，不然拿到我们代码的人，都要这么操作一遍。
如何从我们的项目入手呢？

这里说在 makefile 里写 `-l:<full name>` 
https://stackoverflow.com/questions/828053/how-do-you-link-to-a-specific-version-of-a-shared-library-in-gcc
我试了下，还真行。

这里没有解释 
https://gcc.gnu.org/onlinedocs/gcc-4.6.4/gcc/Link-Options.html

这里有解释
https://sourceware.org/binutils/docs-2.18/ld/Options.html
```
-lnamespec
--library=namespec
```
节，`If namespec is of the form :filename, ld will search the library path for a file called filename, otherise it will search the library path for a file called libnamespec.a.`

遇到的问题：
编译链接通过， 但是 ldd -r  有的能自动找到 `/usr/lib64 ` `/usr/local/lib` 目录的文件，挺好，有的找不到，还把自己的全路径写进去了.
```
$ readelf -d <>
Dynamic section at offset 0x27bd08 contains 38 entries:
  Tag        Type                         Name/Value
 0x0000000000000001 (NEEDED)             Shared library: [librt.so.1]
 0x0000000000000001 (NEEDED)             Shared library: [libm.so.6]
 0x0000000000000001 (NEEDED)             Shared library: [libdl.so.2]
 0x0000000000000001 (NEEDED)             Shared library: [libanl.so.1]
 0x0000000000000001 (NEEDED)             Shared library: [libnsl.so.1]
 0x0000000000000001 (NEEDED)             Shared library: [libcurl.so.4]
 0x0000000000000001 (NEEDED)             Shared library: [libmysqlclient.so.18]
 0x0000000000000001 (NEEDED)             Shared library: [/docker_host/xxx/src/lib/cjson/libcjson.so.1.5.5]
 0x0000000000000001 (NEEDED)             Shared library: [/docker_host/xxx/src/lib/cjson/libcjson_utils.so.1.5.5]
 0x0000000000000001 (NEEDED)             Shared library: [libz.so.1]
 0x0000000000000001 (NEEDED)             Shared library: [libzmq.so.5]
 0x0000000000000001 (NEEDED)             Shared library: [libpthread.so.0]
 0x0000000000000001 (NEEDED)             Shared library: [libgcc_s.so.1]
 0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
 0x000000000000000f (RPATH)              Library rpath: [/usr/lib64/mysql:/data/lib:/usr/local/lib]

```



# xx_LDADD vs xx_LDFLAGS

What is the difference between 
```makefile
xy_LDFLAGS = -lz
```
and 
```makefile
xy_LDADD = libz.la
```

有人说 LDADD 在 LDFLAGS 之后 起作用 https://stackoverflow.com/questions/13610572/correcting-the-gcc-command-line-ordering-using-automake
