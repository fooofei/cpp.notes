
~~~c++

if (0==strncmp("hello","world",0x10000))
{

}

if (0==memcmp("hello","world",0x10000))
{

}         
~~~

Visual Studio : 运行都不会崩溃，没问题。 memcmp 不崩溃是因为比较没到尾部。
gcc-6 asan 检测：可以检测到 memcmp 问题。

~~~c++
if (0==strncmp("hello","hello",0x10000))
{
    printf("nocrash\n");
}


if (0==memcmp("hello","hello",0x10000))
{

}
~~~
Visual Studio : memcmp 崩溃
gcc-6 asan 检测：可以检测到 memcmp 问题。