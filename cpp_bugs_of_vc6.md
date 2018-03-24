# 运算符重载的限制
---
```  
  ．　　．*　　：：　　?：　　sizeof    (这5种运算符不允许重载)
1>     不能改变优先级和结合性 也不能改变操作对象的数目
2>     不能使用默认参数 必须明确每个操作对象
3>     必须作用于自定义类型, (且显式的使用)至少有一个是用户定义类型
4>     重载运算符()  []  ->  = 重载函数必须声明为类的成员函数
  ```

  ## 1谭浩强书上的例子
  ```cpp
  #include <iostream>
  using namespace std;
  //class Complex;
  //Complex operator + (Complex& c1,Complex& c2);//  贱人上面这两句书上没有 编译器报错经查询是编译器的问题微软说vc6.0 SP6已经修复但是我的Visual 6.0还是报错
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
    friend  Complex operator + (Complex& c1,Complex& c2);//擦怎么声明为友元函数就不行了呢
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
    d =  c1+2.5;  //一个double 型数据与Complex类数据相加
    cout<<d<<endl;
    //cout<<c1<<endl;
    c3 = c1 + c2;
    //cout<<c3<<endl;
    return 0;
  }
  ```

  ## 2 重载+、<<运算符
  ```cpp
  // 声明：这段代码放到Visual 6.0 里会编译错误
  // 以下代码在Visual 2008 中测试通过
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
      friend CPoint operator+(CPoint &p1, CPoint &p2);    // 两个对象相加
      friend CPoint operator+(int value, CPoint &p1);    // 对象和值的相加
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
    // 这样写代码就比上面少调用一次拷贝，效率更高
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

  ## 3 重载<<、>> IO流

  ```cpp
  放到Visual 6.0 会报错的哦
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
     // 利用初始化列表来初始化成员对象
    CTest():m_name(""),m_id(0),m_prefix(0),m_value(0){}
      CTest(string n, int a, int p, int nm):m_name(n), m_id(a), m_prefix(p), m_value(nm){}  
    // 操作符被定义为非成员函数时，要将其定义为所操作类的友员函数
      friend ostream &operator<<(ostream &stream, CTest o);        
      friend istream &operator>>(istream &stream, CTest &o);    
  };
   
  //在类里面和类外面的重载的区别在于第二个参数的有无
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
      cin>>a;        // 相当于operator>>(cin, a)
      cout<<a;                // 相当于operator<<(cout, a)
      return 0;
  }

  输入输出样例
  Enter name: hu
  Enter id: 1
  Enter prefix: 12
  Enter value: 1
  ```

  ## 4 重载前置自增、后置自增、前置自减、后置自减

  ```cpp
  放到Visual 6.0 会报错的哦
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
    //前置操作符重载
    CInt& operator++()
    {	
      ++m_value;
      return *this;
    }
    //前置操作符重载
    CInt& operator--()
    {	
      --m_value;
      return *this;
    }
    //后置操作符重载
    CInt operator++(int){	return CInt(m_value++);}
    //后置操作符重载
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

  输出结果
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