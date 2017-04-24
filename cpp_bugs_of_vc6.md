# ��������ص�����
```  
  ��������*������������?������sizeof    (��5�����������������)
1>     ���ܸı����ȼ��ͽ���� Ҳ���ܸı�����������Ŀ
2>     ����ʹ��Ĭ�ϲ��� ������ȷÿ����������
3>     �����������Զ�������, (����ʽ��ʹ��)������һ�����û���������
4>     ���������()  []  ->  = ���غ�����������Ϊ��ĳ�Ա����
```

## 1̷��ǿ���ϵ�����
```cpp
#include <iostream>
using namespace std;
//class Complex;
//Complex operator + (Complex& c1,Complex& c2);//  ������������������û�� ������������ѯ�Ǳ�����������΢��˵vc6.0 SP6�Ѿ��޸������ҵ�Visual 6.0���Ǳ���
//http://support.microsoft.com/kb/890892/zh-cn  
class Complex
{
public:
	Complex()
	{
		real = 0;
		imag = 0;
	}
	Complex(double r ,double i)
	{
		real = r;
		imag = i;
	}
	operator double ()  {return real;}
	friend  Complex operator + (Complex& c1,Complex& c2);//����ô����Ϊ��Ԫ�����Ͳ�������
private:
	double real;
	double imag;
};
Complex operator + (Complex& c1,Complex& c2)
{
	return Complex(c1.real + c2.real ,c1.imag + c2.imag);
}
int main()
{
	Complex c1(3,4), c2(5,-19),c3;
	double d;
	d =  c1+2.5;  //һ��double ��������Complex���������
	cout<<d<<endl;
	//cout<<c1<<endl;
	c3 = c1 + c2;
	//cout<<c3<<endl;
	return 0;
}
```

## 2 ����+��<<�����
```cpp
// ��������δ���ŵ�Visual 6.0 ���������
// ���´�����Visual 2008 �в���ͨ��
#include <iostream>
#include <string>
using namespace std;
class CPoint
{
public:
    CPoint(){printf("Constructor called\n");};
    CPoint(int x_, int y_):m_x(x_),m_y(y_){printf("Constructor called\n");};
    CPoint(const CPoint &p)
	{
        this->m_x = p.m_x;
        this->m_y = p.m_y;
		printf("Copy constructor called\n");
    };
    ~CPoint(){printf("Destructor called\n");};
    friend CPoint operator+(CPoint &p1, CPoint &p2);    // �����������
    friend CPoint operator+(int value, CPoint &p1);    // �����ֵ�����
    friend ostream &operator<<(ostream &os, CPoint &p1);
private:
    int m_x;
    int m_y;
};
int main()
{
    CPoint p1(1,2);
    CPoint p2(3,4);
    cout << p1 + p2;
    cout << 5 + p1;
    return 0;
}
CPoint operator+(CPoint &p1, CPoint &p2)
{	
	//printf("---------Enter operator + ------------\n");
	//CPoint temp;
	//temp.m_x = p1.m_x+p2.m_x;
	//temp.m_y = p1.m_y+p2.m_y;
	//printf("---------Leave operator + ------------\n");
	//return temp;
	
	return CPoint(p1.m_x+p2.m_x,p1.m_y+p2.m_y);
	// ����д����ͱ������ٵ���һ�ο�����Ч�ʸ���
}
 
CPoint operator+(int value, CPoint &p1)
{
	return CPoint(p1.m_x+value, p1.m_y+value);
}
 
ostream &operator<<(ostream &os, CPoint &p1)
{
    os << p1.m_x << " " << p1.m_y << endl;
    return os;
}
```

## 3 ����<<��>> IO��

```cpp
�ŵ�Visual 6.0 �ᱨ���Ŷ
#include <iostream>
#include <string>
using namespace std;
class CTest {
private:
    string m_name;
    int m_id;
    int m_prefix;
    int m_value;
public:
	 // ���ó�ʼ���б�����ʼ����Ա����
	CTest():m_name(""),m_id(0),m_prefix(0),m_value(0){}
    CTest(string n, int a, int p, int nm):m_name(n), m_id(a), m_prefix(p), m_value(nm){}  
	// ������������Ϊ�ǳ�Ա����ʱ��Ҫ���䶨��Ϊ�����������Ա����
    friend ostream &operator<<(ostream &stream, CTest o);        
    friend istream &operator>>(istream &stream, CTest &o);    
};
 
//�������������������ص��������ڵڶ�������������
ostream &operator<<(ostream &stream, CTest o)
{
    stream << o.m_name << " ";
    stream << "(" << o.m_id << ") ";
    stream << o.m_prefix << "-" << o.m_value << "\n";
    return stream; 
}
 
istream &operator>>(istream &stream, CTest &o)
{
    cout << "Enter name: ";
    stream >> o.m_name;
    cout << "Enter id: ";
    stream >> o.m_id;
    cout << "Enter prefix: ";
    stream >> o.m_prefix;
    cout << "Enter value: ";
    stream >> o.m_value;
    cout << endl;
    return stream;
}
 
int main()
{
    CTest a;
    cin>>a;        // �൱��operator>>(cin, a)
    cout<<a;                // �൱��operator<<(cout, a)
    return 0;
}

�����������
Enter name: hu
Enter id: 1
Enter prefix: 12
Enter value: 1
```

## 4 ����ǰ������������������ǰ���Լ��������Լ�

```cpp
�ŵ�Visual 6.0 �ᱨ���Ŷ
#include <iostream>
#include <algorithm>
#include <iterator>
#include <vector>
using namespace std;

class CInt
{
	friend ostream& operator<<(ostream& os, const CInt& i);
	friend istream& operator>>(istream& is, CInt& i);
	friend bool operator<(const CInt& a, const CInt& b);
private:
	int m_value;
public:
	CInt():m_value(0){printf("Constructor called\n");}
	CInt(int val):m_value(val){printf("Constructor called\n");}
	CInt(const CInt& i):m_value(i.m_value){printf("Copu constructor called\n");}
	CInt& operator=(const CInt& i)
	{
		m_value = i.m_value;
		return *this;
	}
	//ǰ�ò���������
	CInt& operator++()
	{	
		++m_value;
		return *this;
	}
	//ǰ�ò���������
	CInt& operator--()
	{	
		--m_value;
		return *this;
	}
	//���ò���������
	CInt operator++(int){	return CInt(m_value++);}
	//���ò���������
	CInt operator--(int){ 	return CInt(m_value--);}
};
ostream& operator<<(ostream& os, const CInt& i)
{
	os << i.m_value;
	return os;
}

istream& operator>>(istream& is, CInt& i)
{
	is >> i.m_value;
	return is;
}

bool operator<(const CInt& a, const CInt& b)
{
	return a.m_value < b.m_value;
}
int main()
{
	CInt x = 10;
	cout <<"++x="<< ++x << endl;
	cout <<"x="<< x << endl;
	cout <<"x++="<< x++ << endl;
	cout <<"x="<< x << endl;
	cout<<"--x="<<--x<<endl;
	cout <<"x="<< x << endl;
	cout<<"x--="<<x--<<endl;
	cout <<"x="<< x << endl;
	return 0;
}

������
Constructor called
++x=11
x=11
Constructor called
x++=11
x=12
--x=11
x=11
Constructor called
x--=11
x=10
```