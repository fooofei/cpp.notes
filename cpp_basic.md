
��������δ���������ȷ�ԡ�

# ����֪ʶ

1.����һ�����࣬�磺

```
class EmptyClass{};      
```    
��Ȼ��û�������κκ��������Ǳ��������Զ�Ϊ���ṩ�������ĸ�������

```
class CEmptyClass
{
public:
	CEmptyClass(); // ���캯��
	CEmptyClass(const CEmptyClass &rhs);// �������캯��
	~CEmptyClass(); // �������� 
	CEmptyClass& operator = (const CEmptyClass& rhs);// ��ֵ����
};      
```

�������ĸ��������κ�һ������������û����������ô�������ͻ��Զ�Ϊ���Ӧ���ṩһ��Ĭ�ϵġ����ڡ�C++ primer���У�����������Զ��ṩ�İ汾������**�ϳɵ�**\*\*\*��������ϳɵĸ��ƹ��캯������Ȼ�������ʽ�����ˣ��������Ͳ������ṩ��Ӧ�ķ�����

2.�ϳɵ�Ĭ�Ϲ��캯��ִ�����ݣ�����и��࣬���ȵ��ø����Ĭ�Ϲ��캯����

3.�ϳɵĸ��ƹ��캯��ִ�����ݣ�ʹ�ò����еĶ��󣬹����һ���µĶ���

4.�ϳɵĸ�ֵ������ִ�����ݣ�ʹ�ò����еĶ���ʹ�ò�������ķ�static��Ա���ζ�Ŀ�����ĳ�Ա��ֵ��ע�⣺�ڸ�ֵ������ִ��֮ǰ��Ŀ������Ѿ����ڡ�

5.�ڼ̳���ϵ�У�Ҫ�����ࣨ���Ϊ���ࣩ����������������Ϊvirtual���������麯������

6.�����а�������ĳ�Ա��������������������ɣ����ಿ�ֺ������Լ�����Ĳ��֡�

7.�������������ʽ���ø���Ĺ��캯����ֻ���ڹ��캯���ĳ�ʼ���б��е��ã�����ֻ�ܵ�����ֱ�Ӹ���ġ�

8.�ڶ��ؼ̳�ʱ�����ջ���̳��б���������˳���ʼ�����ࡣ

9.����̳��У������ĳ�ʼ�� ���� ������࣬������������ʼ������ࣨע�⣺����಻һ���������ֱ�Ӹ��ࣩ��

10.�ڵ�һ�ļ̳��У��� OverWrite ���麯�����麯�����еõ��˸��¡�

11.���Կ����Ĳ��� http://blog.csdn.net/haoel/article/details/1948051


# ���캯��

1.�ڹ�������֮ǰһ��ִ�и���ġ�һ�������캯����

2.���캯����˳��:

&ensp;&ensp;��ֱ�Ӹ��ࣻ
  
&ensp;&ensp;�� �Լ� ����ֱ�Ӹ��໹�и��࣬��ôֱ�Ӹ���ĸ������ֱ�Ӹ���֮ǰ���졣
  
  �������Ϊ����һ���ݹ�Ĺ��̣�ֱ������һ��û�и�������ֹͣ��
  
&ensp;&ensp;2.1 ���û��**��ʽ����**�Լ��Ĺ��캯������ϳɵ�Ĭ�Ϲ��캯�����Զ�����ֱ�Ӹ����Ĭ�Ϲ��캯����Ȼ����ñ�����Ϊ�Լ����ɵĺϳ�Ĭ�Ϲ��캯����

&ensp;&ensp;2.2 ���**��ʽ����**���Լ��Ĺ��캯��

&ensp;&ensp;&ensp;&ensp;2.2.1 ���û��**��ʽ����**ֱ�Ӹ��������һ�����캯������ô�ͺϳɵ�Ĭ�Ϲ��캯��һ���������Զ�����ֱ�Ӹ����Ĭ�Ϲ��캯����Ȼ������Լ��Ĺ��캯����

&ensp;&ensp;&ensp;&ensp;2.2.2 ���**��ʽ����**��ֱ�Ӹ��������һ�����캯������ô���ȵ���ֱ�Ӹ���Ĺ��캯����Ȼ������Լ��Ĺ��캯����

3.���������빹�캯��˳���෴��

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

	Test b();// ���ǲ��Ե� �ᱻʶ��Ϊ��������
	b.fun();
	return 0;
}
```

# �������캯����explicit�������ǳ����

1.����һ���ѳ�ʼ�����˵��Զ��������Ͷ���ȥ��ʼ����һ���¹���Ķ����ʱ�򣬿������캯���ͻᱻ�Զ����á�Ҳ����˵������Ķ�����Ҫ����ʱ���������캯�����ᱻ���á�

2.�������캯������������Ҫʹ�����ã��� const ���£�

```
TestA(const TestA &a) // дA �Ͳ���,һ��Ҫȡ��ַ��
```

3.�������������ÿ������캯����

&ensp;&ensp;��1��һ��������ֵ���ݵķ�ʽ���뺯���� 

&ensp;&ensp;��2��һ��������ֵ���ݵķ�ʽ�Ӻ������� 

&ensp;&ensp;��3��һ��������Ҫͨ������һ��������г�ʼ����

4.���������û����ʽ������һ���������캯������ô�������������Զ�����һ��Ĭ�ϵĿ������캯�����ù��캯����ɶ���֮���λ������λ�����ֳ�ǳ���������潫����˵����

5.�Զ��忽�����캯����һ�����õı�̷����������ֹ�������γ�Ĭ�ϵĿ������캯�������Դ��Ч�ʡ�

6.����һ�ο������캯���͵���һ������������

7.���� = �����ʱ�Ĵ����Ż���ʩ��

8.explicit ��Ҫ���ڷ�ֹ��ʽת�����������ι��캯�������ƹ��캯����
������� http://www.programlife.net/cpp-explicit-keyword.html

9.ǳ���������
��ĳЩ״���£����ڳ�Ա������Ҫ��̬���ٶ��ڴ棬���ʵ��λ������Ҳ���ǰѶ������ֵ��ȫ���Ƹ���һ��������A=B����ʱ�����B����һ����Ա����ָ���Ѿ��������ڴ棬��A�е��Ǹ���Ա����Ҳָ��ͬһ���ڴ档��ͳ��������⣺��B���ڴ��ͷ��ˣ��磺����������ʱA�ڵ�ָ�����Ұָ���ˣ��������д���������֤���������3. �����ǳ�������Լ����Ϊ�����һ����ӵ����Դ���������Ķ��������ƹ��̵�ʱ����Դ���·��䣬������̾����������֮��û�����·�����Դ������ǳ������

# ��������������������

������Ķ���(����ָ��ָ���������)���ڴ��г���ʱ�ȵ������������������Ȼ���ٵ��û������������.

## ��1 ��������������

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
	CSonClass son; // ���� CSonClass* pSon = new CSonClass(); delete pSon; ��û������
    // ���� CFatherClass *pFather = new CFatherClass(); delete pFather; ��Ҳû������
	return 0;
}
���н��
CFatherClass Construct!
CSonClass Construct!
CSonClass DeConstruct!
CFatherClass  DeConstruct!
```

## ��2 �������������飬���Ҿ��ж�̬

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
���н��
CFatherClass Construct!
CSonClass Construct!
CFatherClass  DeConstruct!
�밴���������. . .
���û�е��������������������Ͳ����ˡ�
```

## ��3 �������������飨ֻ��Ҫ�����������������ģ������Ҿ��ж�̬

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
���н��
CFatherClass Construct!
CSonClass Construct!
CSonClass DeConstruct!
CFatherClass  DeConstruct!
�밴���������. . .
```

# ��̳С������

1.����̳��У����캯�����ȵ��������Ĺ��캯����Ȼ����Ǹ���Ĺ��캯����Ȼ���������Ĺ��캯����ע����������һ���ݹ��Ҹ���Ĺ��̡��������ڸ��࣬���ǻ��ȹ��츸�࣬�������ȹ��쵱ǰ���������ȥ���츸�ࡣ

2.������̳еĶ�̳������麯��������⣬�뿴��¼�Ĳ��͡�

3.�����ĳ�ʼ��Ҫ���ڷ�����࣬����ֻ�������������г�ʼ����


## ����ָ����������������һ������ָ�����������δ���Ǹ�����麯��

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
// ��ӡ���
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

    // ����ָ�����������δ���Ǹ���ĳ�Ա�����ķ��� ����
    // ͨ��ָ��ķ�ʽ�����麯�������ﵽΥ��C++�������Ϊ
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


## ����ָ�������������������ͨ��������ʸ���˽���麯��

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
    // 1.(int*)(&d) ��ȡvptr ��ַ �õ�ַ�洢����ָ��vtbl��ָ��
    // 2.(int*)* (int*)(&d) ��ȡvtbl�ĵ�ַ �õ�ַ�洢�����麯��������
    func(); // Base:f()
    // 3.(pFunc) *((int*)* (int*)(&d)+0) ȡvtbl�����һ��Ԫ�ؼ�Base�е�һ���麯��f�ĵ�ַ 
    // 3.(pFunc) *((int*)* (int*)(&d)+1) ȡvtbl����ڶ���Ԫ�ؼ�Base�еڶ����麯��g�ĵ�ַ 
    func = (pFunc)*((int*)*(int*)(&d)+1);
    func(); // Base:g()
    return 0;
}

```