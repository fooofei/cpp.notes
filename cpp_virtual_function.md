
* 同名虚函数的出现顺序。
同一个类中，同名的虚函数出现顺序。
此问题由一个新手在参与项目开发时，在即有接口中增加同名函数引起。

测试结果
```	
	class Test
	{
		public :
		virtual void func1(void *) {}
		virtual void func1(int ){}

	}

```
Vistual studio 2012, 2015 版本验证: 在虚函数表中，是 `void func1(int)` 在 `void func1(void *)` 的前面。
甚至是倒序，但在 gcc 中不是这样的。

* 父类地址

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
dynamic_cast 可用于`父1`指针转到`父2`指针。
pa pb 地址相差 4 ， 在 x86 platform.
因此，在实现 `QueryInterface()` 时，应该使用 *pv = static_cast<父类指针>(子类指针-this));