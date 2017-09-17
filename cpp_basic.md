
备忘，还未审查内容正确性。

# 基本知识

1.对于一个空类，如：

```
class EmptyClass{};      
```    
虽然你没有声明任何函数，但是编译器会自动为你提供上面这四个方法。

```
class CEmptyClass
{
public:
	CEmptyClass(); // 构造函数
	CEmptyClass(const CEmptyClass &rhs);// 拷贝构造函数
	~CEmptyClass(); // 析构函数 
	CEmptyClass& operator = (const CEmptyClass& rhs);// 赋值函数
};      
```

对于这四个方法的任何一个，你的类如果没有声明，那么编译器就会自动为你对应的提供一个默认的。（在《C++ primer》中，这个编译器自动提供的版本叫做“**合成的**\*\*\*”，例如合成的复制构造函数）当然如果你显式声明了，编译器就不会再提供相应的方法。

2.合成的默认构造函数执行内容：如果有父类，就先调用父类的默认构造函数。

3.合成的复制构造函数执行内容：使用参数中的对象，构造出一个新的对象。

4.合成的赋值操作符执行内容：使用参数中的对象，使用参数对象的非static成员依次对目标对象的成员赋值。注意：在赋值操作符执行之前，目标对象已经存在。

5.在继承体系中，要将基类（或称为父类）的析构函数，声明为virtual方法（即虚函数）。

6.子类中包含父类的成员。即子类有两个部分组成，父类部分和子类自己定义的部分。

7.如果在子类中显式调用父类的构造函数，只能在构造函数的初始化列表中调用，并且只能调用其直接父类的。

8.在多重继承时，按照基类继承列表中声明的顺序初始化父类。

9.在虚继承中，虚基类的初始化 早于 非虚基类，并且子类来初始化虚基类（注意：虚基类不一定是子类的直接父类）。

10.在单一的继承中，被 OverWrite 的虚函数在虚函数表中得到了更新。

11.可以看陈皓的博客 http://blog.csdn.net/haoel/article/details/1948051


# 构造函数

1.在构造子类之前一定执行父类的、一个、构造函数。

2.构造函数的顺序:

&ensp;&ensp;①直接父类；
  
&ensp;&ensp;② 自己 ，若直接父类还有父类，那么直接父类的父类会在直接父类之前构造。
  
  可以理解为这是一个递归的过程，直到出现一个没有父类的类才停止。
  
&ensp;&ensp;2.1 如果没有**显式定义**自己的构造函数，则合成的默认构造函数会自动调用直接父类的默认构造函数，然后调用编译器为自己生成的合成默认构造函数。

&ensp;&ensp;2.2 如果**显式定义**了自己的构造函数

&ensp;&ensp;&ensp;&ensp;2.2.1 如果没有**显式调用**直接父类的任意一个构造函数，那么和合成的默认构造函数一样，会先自动调用直接父类的默认构造函数，然后调用自己的构造函数。

&ensp;&ensp;&ensp;&ensp;2.2.2 如果**显式调用**了直接父类的任意一个构造函数，那么会先调用直接父类的构造函数，然后调用自己的构造函数。

3.析构函数与构造函数顺序相反。

```cpp
#include <stdio.h>
class Test
{
public:
	Test(int) {}
	Test(void) {}
	void fun() {}
};

int main()
{

	Test a(1);
	a.fun();

	Test b();// 这是不对的 会被识别为函数声明
	b.fun();
	return 0;
}
```

# 拷贝构造函数、explicit、深拷贝与浅拷贝

1.当用一个已初始化过了的自定义类类型对象去初始化另一个新构造的对象的时候，拷贝构造函数就会被自动调用。也就是说，当类的对象需要拷贝时，拷贝构造函数将会被调用。

2.拷贝构造函数，参数声明要使用引用，带 const 如下：

```
TestA(const TestA &a) // 写A 就不对,一定要取地址。
```

3.以下情况都会调用拷贝构造函数：

&ensp;&ensp;（1）一个对象以值传递的方式传入函数体 

&ensp;&ensp;（2）一个对象以值传递的方式从函数返回 

&ensp;&ensp;（3）一个对象需要通过另外一个对象进行初始化。

4.如果在类中没有显式地声明一个拷贝构造函数，那么，编译器将会自动生成一个默认的拷贝构造函数，该构造函数完成对象之间的位拷贝。位拷贝又称浅拷贝，后面将进行说明。

5.自定义拷贝构造函数是一种良好的编程风格，它可以阻止编译器形成默认的拷贝构造函数，提高源码效率。

6.调用一次拷贝构造函数就调用一次析构函数；

7.重载 = 运算符时的传参优化措施；

8.explicit 主要用于防止隐式转换，用于修饰构造函数、复制构造函数；
代码疯子 http://www.programlife.net/cpp-explicit-keyword.html

9.浅拷贝和深拷贝
在某些状况下，类内成员变量需要动态开辟堆内存，如果实行位拷贝，也就是把对象里的值完全复制给另一个对象，如A=B。这时，如果B中有一个成员变量指针已经申请了内存，那A中的那个成员变量也指向同一块内存。这就出现了问题：当B把内存释放了（如：析构），这时A内的指针就是野指针了，出现运行错误。正好验证了下面的例3. 深拷贝和浅拷贝可以简单理解为：如果一个类拥有资源，当这个类的对象发生复制过程的时候，资源重新分配，这个过程就是深拷贝，反之，没有重新分配资源，就是浅拷贝。

# 析构函数、虚析构函数

派生类的对象(父类指针指向子类对象)从内存中撤销时先调用派生类的析构函数然后再调用基类的析构函数.

## 例1 析构函数不是虚

```cpp
#include <iostream>
using namespace std;
class CFatherClass
{
	int a;
public:
	CFatherClass()
	{
		cout<<"CFatherClass Construct!"<<endl;
	}
	~CFatherClass()
	{
		cout<<"CFatherClass  DeConstruct!"<<endl;
	}
};

class CSonClass : public CFatherClass
{
public:
	CSonClass()
	{
		cout<<"CSonClass Construct!"<<endl;
	}
	~CSonClass()
	{
		cout<<"CSonClass DeConstruct!"<<endl;
	}
};
int main()
{
	CSonClass son; // 或者 CSonClass* pSon = new CSonClass(); delete pSon; 都没有问题
    // 或者 CFatherClass *pFather = new CFatherClass(); delete pFather; 这也没有问题
	return 0;
}
运行结果
CFatherClass Construct!
CSonClass Construct!
CSonClass DeConstruct!
CFatherClass  DeConstruct!
```

## 例2 析构函数不是虚，并且具有多态

```cpp
#include <iostream>
using namespace std;
class CFatherClass
{
	int a;
public:
	CFatherClass()
	{
		cout<<"CFatherClass Construct!"<<endl;
	}
	~CFatherClass()
	{
		cout<<"CFatherClass  DeConstruct!"<<endl;
	}
};
class CSonClass : public CFatherClass
{
public:
	CSonClass()
	{
		cout<<"CSonClass Construct!"<<endl;
	}
	~CSonClass()
	{
		cout<<"CSonClass DeConstruct!"<<endl;
	}
};
int main()
{
	CFatherClass* pPoly = new CSonClass;
	delete pPoly;
	return 0;
}
运行结果
CFatherClass Construct!
CSonClass Construct!
CFatherClass  DeConstruct!
请按任意键继续. . .
结果没有调用子类的析构函数，这就不对了。
```

## 例3 析构函数不是虚（只需要基类的析构函数是虚的），并且具有多态

```cpp
#include <iostream>
using namespace std;
class CFatherClass
{
	int a;
public:
	CFatherClass()
	{
		cout<<"CFatherClass Construct!"<<endl;
	}
	virtual ~CFatherClass()
	{
		cout<<"CFatherClass  DeConstruct!"<<endl;
	}
};
class CSonClass : public CFatherClass
{
public:
	CSonClass()
	{
		cout<<"CSonClass Construct!"<<endl;
	}
	~CSonClass()
	{
		cout<<"CSonClass DeConstruct!"<<endl;
	}
};
int main()
{
	CFatherClass* pPoly = new CSonClass;
	delete pPoly;
	return 0;
}
运行结果
CFatherClass Construct!
CSonClass Construct!
CSonClass DeConstruct!
CFatherClass  DeConstruct!
请按任意键继续. . .
```

# 虚继承、虚基类

1.在虚继承中，构造函数优先调用虚基类的构造函数，然后才是父类的构造函数，然后才是子类的构造函数，注意这其中有一个递归找父类的过程。虚基类存在父类，还是会先构造父类，并不会先构造当前的虚基类再去构造父类。

2.还有虚继承的多继承中中虚函数表的问题，请看附录的博客。

3.虚基类的初始化要早于非虚基类，并且只能由子类对其进行初始化。


## 利用指针特性做出格事情一：父类指针调用子类中未覆盖父类的虚函数

```cpp
class Base1
{
public:
    virtual void f(){printf("Base1:f()\n");}
    virtual void g(){printf("Base1:g()\n");}
    virtual void h(){printf("Base1:h()\n");}
};
class Base2
{
public:
    virtual void f(){printf("Base2:f()\n");}
    virtual void g(){printf("Base2:g()\n");}
    virtual void h(){printf("Base2:h()\n");}
};
class Base3
{
public:
    virtual void f(){printf("Base3:f()\n");}
    virtual void g(){printf("Base3:g()\n");}
    virtual void h(){printf("Base3:h()\n");}
};
class Derived:public Base1,public Base2,public Base3
{
public:
    virtual void f(){printf("Derived:f()\n");}
    virtual void g1(){printf("Derived:g1()\n");}

};
typedef void (*pFunc)(void);
// 打印虚表
void PrintVTable(int *p)
{
    while (*p != NULL)
    {
        printf("func_addr:%p func_call:",*p);
        ((pFunc)*p)();
        p = (int*)p +1;
    }
    printf("\n");
}

int vtable_info()
{
    Derived d;
    Base1* b1 = &d;
    Base2* b2 = &d;
    Base3* b3 = &d;

    printf("b1=%p,b2=%p,b3=%p\n",b1,b2,b3); //b1=002CF7D0,b2=002CF7D4,b3=002CF7D8
    
    printf("b1 vtable:\n");
    PrintVTable((*(int**)b1)); // or  (int*)(*(int*)b1)

    printf("b2 vtable\n");
    PrintVTable((*(int**)b2));

    printf("b3 vtable\n");
    PrintVTable((*(int**)b3));

    /*
    b1=0042FD7C,b2=0042FD80,b3=0042FD84
    b1 vtable:
    func_addr:0116127B func_call:Derived:f()
    func_addr:0116125D func_call:Base1:g()
    func_addr:0116137F func_call:Base1:h()
    func_addr:01161037 func_call:Derived:g1()

    b2 vtable
    func_addr:01161131 func_call:Derived:f()
    func_addr:01161258 func_call:Base2:g()
    func_addr:0116137A func_call:Base2:h()

    b3 vtable
    func_addr:011610F5 func_call:Derived:f()
    func_addr:0116115E func_call:Base3:g()
    func_addr:01161262 func_call:Base3:h()
    */

    return 0;
}

int func1()
{
    Derived d;
    Base1* b1 = &d;
    Base2* b2 = &d;
    Base3* b3 = &d;

    // 父类指针调用子类中未覆盖父类的成员函数的方法 如下
    // 通过指针的方式访问虚函数表来达到违反C++语义的行为
    pFunc func = (pFunc)*((int*)(*((int*)b1+0))+3);	
    func(); // Derived:g1()
    return 0;
}

int main()
{
    vtable_info();
    func1();
    return 0;
}

```

![vtable](https://cloud.githubusercontent.com/assets/7028946/25371367/18a8d430-29c3-11e7-8107-a91f51dc6800.png)


## 利用指针特性做出格事情二：通过子类访问父类私有虚函数

```cpp
class Base
{
private:
    virtual void f()
    {printf("Base:f\n");}
    virtual void g()
    {printf("Base:g\n");}
};
class Derived : public Base{};

typedef void (*pFunc)(void);

int main()
{
    Derived d;
    pFunc func = (pFunc)*((int*)*(int*)(&d)+0);
    // 1.(int*)(&d) 是取vptr 地址 该地址存储的是指向vtbl的指针
    // 2.(int*)* (int*)(&d) 是取vtbl的地址 该地址存储的是虚函数表数组
    func(); // Base:f()
    // 3.(pFunc) *((int*)* (int*)(&d)+0) 取vtbl数组第一个元素即Base中第一个虚函数f的地址 
    // 3.(pFunc) *((int*)* (int*)(&d)+1) 取vtbl数组第二个元素即Base中第二个虚函数g的地址 
    func = (pFunc)*((int*)*(int*)(&d)+1);
    func(); // Base:g()
    return 0;
}

```