类实现放在哪里的问题

```
#if 0
class classa
{
public:

    void funca()
    {
         printf("in classa\n");
    }
};
#else
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