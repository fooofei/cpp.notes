
https://github.com/google/sanitizers

模式 1、你的程序仅仅是一个二进制（可执行程序），比如最简单的 `g++ 1.c` ,

那么就在编译的时候加 `-fsanitize=address`, 最终为 `g++ -fsanitize=address  1.c`.


模式 2、程序运行模式是 二进制（可执行程序）+动态库 .so ，我们想要分析动态库 so 文件。

那么 

  a. 在编译 so 文件时，加如下参数
  
  `CXXFLAGS+= -O1 -g -DNDEBUG  -fsanitize=address`
	
  b. 链接 .o 文件为 .so 文件的时候，加 
  
  `-g -fno-omit-frame-pointer -fsanitize=address -fsanitize-recover=address -lasan`
  
   链接后要使用 `ldd -r [.so path]` 查看生成的 so 文件是否有符号未链接，如果有asan的，要回到 a， 重新编译，加前缀
	 
   `export  LD_LIBRARY_PATH=/usr/lib/clang/3.8.0/lib/linux & make -j8`
	 
  c. 运行时加前缀 `LD_PRELOAD=/usr/lib/gcc/x86_64-linux-gnu/5/libasan.so` ，这个 so 的路劲要自己找。
    
	出现异常时，看不到出现异常的代码文件和行号，则运行时，继续增加前缀 
	
    `ASAN_SYMBOLIZER_PATH=/usr/bin/llvm-symbolizer-3.8 ASAN_OPTIONS=symbolize=1`

* 缺陷
~~~c++
无法检测栈空间越界
int x[4];
x[4]=9;
以上代码检测不到
~~~