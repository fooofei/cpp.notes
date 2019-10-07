
### 类实现放在哪里的问题

默认的，我们在 .h 里声明函数或者定义类
在 .cpp 中定义（实现）函数或者实现类。
有时候有下面两种使用情况，都把工作放到 .h 文件中。
  
```cpp
class classa
{
public:

    void funca()
    {
        printf("in classa\n");
    }
};

class classa
{
public:

    void funca();
};
void classa::funca()
{
    printf("in classa\n");
}
#endif
```
如果是前者，则可以在多个文件中使用该类，如果是后者只能在一个文件中 使用该类，破解方法是在函数实现前加 `inline` (函数声明时不用加)
