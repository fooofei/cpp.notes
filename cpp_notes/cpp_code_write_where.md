��ʵ�ַ������������

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
�����ǰ�ߣ�������ڶ���ļ���ʹ�ø��࣬����Ǻ���ֻ����һ���ļ��� ʹ�ø��࣬�ƽⷽ�����ں���ʵ��ǰ�� `inline` (��������ʱ���ü�)