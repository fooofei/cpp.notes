
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