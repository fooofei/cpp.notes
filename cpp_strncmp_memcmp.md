
~~~c++

if (0==strncmp("hello","world",0x10000))
{

}

if (0==memcmp("hello","world",0x10000))
{

}         
~~~

Visual Studio : ���ж����������û���⡣ memcmp ����������Ϊ�Ƚ�û��β����
gcc-6 asan ��⣺���Լ�⵽ memcmp ���⡣

~~~c++
if (0==strncmp("hello","hello",0x10000))
{
    printf("nocrash\n");
}


if (0==memcmp("hello","hello",0x10000))
{

}
~~~
Visual Studio : memcmp ����
gcc-6 asan ��⣺���Լ�⵽ memcmp ���⡣