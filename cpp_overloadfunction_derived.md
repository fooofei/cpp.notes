
# C++ 具有重载函数的类在继承时的表现

考虑下面的代码片段：(为书写简便，`class` 关键字一律使用 `struct` )

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
    d.error(1); // 错误
    return 0;
}

```
或
```cpp
struct Base
{
    virtual void error() // 是否是 virtual 结果一样
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
    //d.error(1); // 错误
    return 0;
}

```
注意到 Base 是基类，有同名的方法，这是在重载，同时作为子类的 Derived 覆盖了基类的 Base::error() 方法, 但是父类的另一个方法 Base::error(int ) 却没有继承下来，

我们在 Derived 类中无法以 <Derived对象>.error(1) 的形式调用。

这个页面有一个解释：

http://stackoverflow.com/questions/1628768/why-does-an-overridden-function-in-the-derived-class-hide-other-overloads-of-the

他解释说，如果有以下代码：
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
如果使用 foo(NULL)，因为 NULL 被定为为 0， 会产生不知道调用哪个方法的歧义，所以， C++ 采取 "name hiding"（名字隐藏）

我认为这么解释太牵强了。同一个类中同名方法也是有可能定义的。

# 破解

可以这样使用父类的同名方法
```cpp
struct Base
{
    virtual void error() // 是否是 virtual 结果一样
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
    <font color="red">using Base::error;</font>
    void error()
    {
        std::cout<<"Derived::error()"<<endl;
    }
};

int main()
{
    Derived d;
    d.error(); // Derived::error()
    d.error(1); // 通过 Base::error(int)
    return 0;
}
```
