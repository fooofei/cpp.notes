
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

![vtable](data:image/png;base64,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)


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