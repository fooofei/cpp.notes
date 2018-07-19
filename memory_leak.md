
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



## linux Address Sanitizer


### 一些链接

https://github.com/google/sanitizers

https://github.com/google/sanitizers/wiki/AddressSanitizer

### 支持哪些编译器

支持版本  Clang (3.3+) and GCC (4.8+). 还是 gcc6 更好，建议升级到最新版本。

### 单二进制

你的程序仅仅是一个二进制（可执行程序），比如最简单的 `g++ 1.c` ,
~~~
那么就在编译的时候加 `-fsanitize=address`, 最终为 `g++ -fsanitize=address  1.c`.
~~~


### 二进制 + 动态库(.so)

程序运行模式是 二进制（可执行程序）+动态库 .so ，我们想要分析动态库 so 文件。
~~~
那么 

  a. 在编译 so 文件时，加如下参数
  
  `CXXFLAGS+= -O1 -g -DNDEBUG  -fsanitize=address`
  gcc-6: `-fsanitize-recover=address` 定位到 1 个问题后可以不停止运行，继续运行当前程序
  
	
  b. 链接 .o 文件为 .so 文件的时候，加 
  
  `-g -fno-omit-frame-pointer -fsanitize=address -fsanitize-recover=address -lasan`
  
   链接后要使用 `ldd -r [.so path]` 查看生成的 so 文件是否有符号未链接，如果有asan的，要回到 a， 重新编译，加前缀
	 
   `export  LD_LIBRARY_PATH=/usr/lib/clang/3.8.0/lib/linux & make -j8`
	 
  c. 运行时加前缀 
  `SAN_OPTIONS=halt_on_error=0` 抛出问题后不停止运行
  
  gcc-5:`LD_PRELOAD=/usr/lib/gcc/x86_64-linux-gnu/5/libasan.so` ，
  gcc-6:`LD_PRELOAD=/usr/lib/gcc/x86_64-linux-gnu/6/libasan.so` / `LD_PRELOAD=/usr/lib/gcc/x86_64-linux-gnu/6.2.0/libasan.so` ，
  
  这个 so 的路劲要自己找。
    
	出现异常时，看不到出现异常的代码文件和行号，则运行时，继续增加前缀 
	
    `ASAN_SYMBOLIZER_PATH=/usr/bin/llvm-symbolizer-3.8 ASAN_OPTIONS=symbolize=1`
~~~

### 缺陷
~~~c++
无法检测栈空间越界

int x[4];
x[4]=9;

以上代码  gcc-5(5.4)检测不到, gcc-6 可以检测到。
~~~

### /usr/bin/ld: cannot find /usr/lib64/libasan.so.0.0.0

使用的是 GCC 4.8.5，去 /usr/lib64/libasan.so.0.0.0 找这个文件，的确不存在，但是存在 /usr/lib/libasan.so.0.0.0 。

用 file 查看，也是 32 bit ELF文件， yum search all asan 只见到了 libasan.i686 : The Address Sanitizer runtime library

预期我们使用的应该是 libasan.x86_64 。所以还是不能用。 


## valgrind 

valgrind --trace-children=yes --leak-check=full --log-file=$PWD/valgrind.log --tool=memcheck --verbose

```c

/* The file is to test valgrind, the parent process has memory leak, 

 and the forked child process also have memory leak. 

To compile it gcc -g valgrind_test.c -o valgrind_test


==93002== 4 bytes in 1 blocks are definitely lost in loss record 1 of 2
==93002==    at 0x4C29BBD: malloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==93002==    by 0x4005A9: main (valgrind_test.c:31)
==93002== 
==93002== 8 bytes in 1 blocks are definitely lost in loss record 2 of 2
==93002==    at 0x4C29BBD: malloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==93002==    by 0x400591: run_in_fork_child (valgrind_test.c:25)
==93002==    by 0x4005C2: main (valgrind_test.c:35)
==92524== 
 
 */
#include <stdio.h>
#include <stdlib.h>

void run_in_fork_child()
{
    int * b = malloc(8);
    (void)b;
}

int main()
{
    int * a = malloc(4);
    (void)a;
    switch(fork())
    {
        case 0: run_in_fork_child(); break;
        default: break;
    }
    
    return 0;
}
```
