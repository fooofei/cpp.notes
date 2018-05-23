
find the program's memory leak

## Windows - AppVerify

Open AppVerify, add the to seed program to the list, and just run program.

If use AppVerify, program not use multi-thread.


## Windows gflags

It was awful. gflags command line use not return any word. 

if set a program use gflags, we cannot found what program we set.

passed a few days, when we normally use the program, the program's alloc free

will cause exception, and we don't why this occur, it will waste my time.


## Windows _CrtSetDbgFlag

https://github.com/fooofei/cpp_common/blob/master/detectmemleak.h

## posix - AddressSanitizer(ASan)


## Static code analyse

PVS-Studio, Dr.Memory



## Linux

一个想法: strace 能追踪进程执行过程中的 syscall (系统调用)， malloc free 是其中的一部分，

但是输出的结果只有地址，没有文件行号，我们追踪 malloc 还是要对应到行号的，有说法是可以用

addr2line 解决这个问题，比如这里 https://stackoverflow.com/questions/6806037/line-number-info-in-ltrace-and-strace-tools

我试了，没成功， addr2line 输出总是 ?? ，即便我是 -g 不带 -O0/-O2 编译代码，也不行。


但是 mtrace 这个工具倒是值得一试，对于服务端性质的进程，即无明显 exit 的进程也是适用的。

如果没有 mtrace 这个命令，要使用 # yum -y install glibc-utils 安装。

C 代码例子和运行要点见 http://man7.org/linux/man-pages/man3/mtrace.3.html

运行进程前要设置 MALLOC_TRACE 环境变量，接下来是运行进程，运行过程中的  malloc alloc free 都会记入 MALLOC_TRACE 变量中的值中，

它是一个文件，因为进程可能是服务端程序，无法确定 exit 时间，所以自己判断时机合适就可以了，然后使用 mtrace 命令把刚才的文件作为输入，

它会扫描一遍这个文件，找出那些地址的内存还没得到释放，并且给出该内存申请的代码文件和行号。


还尝试了 strace-plus https://github.com/pgbovine/strace-plus 不会用，它说它的功能已经放到了 strace 里，

Version>4.9 上，选项为 -k 我用了这个版本，但是没有 -k 选项。只能放弃了。


## Linux 查看内存方法

`# cat /proc/<pid>/status `

RSS/VmRSS - Resident Set Size 实际使用物理内存（包含共享库占用的内存）

PSS - Proportional Set Size 实际使用的物理内存（比例分配共享库占用的内存）

USS - Unique Set Size 进程独自占用的物理内存（不包含共享库占用的内存）

VmHWM:    表示进程所占用物理内存的峰值
VmData 是数据占用内存

调试跟踪发现: 1 malloc 内存，未使用，大小增长到 VmData , VmRSS 保持不变

2 memset(ptr, 1, size) 之后接着就增长到 VmRSS 上， ptr[0]=0; 不会增长到 VmRSS 上。
memset(ptr, 0, size) 会增长到 VmRSS 上。
增长到 VmRSS 上后， VmHWM 也会增长，就是说峰值变了。

3 calloc(1, size) 不会增长到 VmRSS 上，这很意外，理论上， malloc + memset = calloc

但是 VmRSS 上的表现不这么说。
