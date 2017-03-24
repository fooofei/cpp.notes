
# C++ �������غ��������ڼ̳�ʱ�ı���

��������Ĵ���Ƭ�Σ�(Ϊ��д��㣬`class` �ؼ���һ��ʹ�� `struct` )

```cpp
struct Base
{
    virtual void error(int )
    {
        std::cout<<"Base::error(int)"<<endl;
    }
};

struct Derived : public Base
{
    void error()
    {
        std::cout<<"Derived::error()"<<endl;
    }
};

int main()
{
    Derived d;
    d.error(); // Derived::error()
    d.error(1); // ����
    return 0;
}

```
��
```cpp
struct Base
{
    virtual void error() // �Ƿ��� virtual ���һ��
    {
        std::cout<<"Base::error()"<<endl;
    }

    virtual void error(int )
    {
        std::cout<<"Base::error(int)"<<endl;
    }
};

struct Derived : public Base
{
    void error()
    {
        std::cout<<"Derived::error()"<<endl;
    }
};

int main()
{
    Derived d;
    d.error(); // Derived::error()
    //d.error(1); // ����
    return 0;
}

```
ע�⵽ Base �ǻ��࣬��ͬ���ķ��������������أ�ͬʱ��Ϊ����� Derived �����˻���� Base::error() ����, ���Ǹ������һ������ Base::error(int ) ȴû�м̳�������

������ Derived �����޷��� <Derived����>.error(1) ����ʽ���á�

���ҳ����һ�����ͣ�

http://stackoverflow.com/questions/1628768/why-does-an-overridden-function-in-the-derived-class-hide-other-overloads-of-the

������˵����������´��룺
```cpp
struct Base
{
    
    void foo(void *)
    {
       
    }
};

struct Derived : public Base
{
    
    void foo(int )
    {

    }
};
```
���ʹ�� foo(NULL)����Ϊ NULL ����ΪΪ 0�� �������֪�������ĸ����������壬���ԣ� C++ ��ȡ "name hiding"���������أ�

����Ϊ��ô����̫ǣǿ�ˡ�ͬһ������ͬ������Ҳ���п��ܶ���ġ�

# �ƽ�

��������ʹ�ø����ͬ������
```cpp
struct Base
{
    virtual void error() // �Ƿ��� virtual ���һ��
    {
        std::cout<<"Base::error()"<<endl;
    }

    virtual void error(int )
    {
        std::cout<<"Base::error(int)"<<endl;
    }
};

struct Derived : public Base
{

    using Base::error; //ע�����

    void error()
    {
        std::cout<<"Derived::error()"<<endl;
    }
};

int main()
{
    Derived d;
    d.error(); // Derived::error()
    d.error(1); // ͨ�� Base::error(int)
    return 0;
}
```
