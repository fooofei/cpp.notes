
* ͬ���麯���ĳ���˳��
ͬһ�����У�ͬ�����麯������˳��
��������һ�������ڲ�����Ŀ����ʱ���ڼ��нӿ�������ͬ����������

���Խ��
```	
	class Test
	{
		public :
		virtual void func1(void *) {}
		virtual void func1(int ){}

	}

```
Vistual studio 2012, 2015 �汾��֤: ���麯�����У��� `void func1(int)` �� `void func1(void *)` ��ǰ�档
�����ǵ��򣬵��� gcc �в��������ġ�

* �����ַ

```
struct IA
{
    virtual void show_a() = 0;
};

struct  IB
{
    virtual void show_b() = 0;
};

struct A : public IA, public IB
{
    A()
    {
        printf("A\n");
    }
    ~A()
    {
        printf("~A\n");
    }
    void show_a()
    {
        printf("A:show_a\n");
    }
    void show_b()
    {
        printf("A:show_b\n");
    }
};
int main(int argc, const TCHAR ** argv)
{
   
    A * p  = new A;
    IB * pb = p;
    IA * pa = p;
    ((IB*)pa)->show_b();
    reinterpret_cast<IB*>(pa)->show_b();
    dynamic_cast<IB*>(pa)->show_b();
    // output
    // A:show_a
    // A:show_a
    // A:show_b
    delete p;
    return 0;
}
```
dynamic_cast ������`��1`ָ��ת��`��2`ָ�롣
pa pb ��ַ��� 4 �� �� x86 platform.
��ˣ���ʵ�� `QueryInterface()` ʱ��Ӧ��ʹ�� *pv = static_cast<����ָ��>(����ָ��-this));