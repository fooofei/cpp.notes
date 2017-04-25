
# 指针

先声明几个指针放着做例子： 

```
例一： 
(1)int*ptr; 
(2)char*ptr; 
(3)int**ptr; 
(4)int(*ptr)[3]; 
(5)int*(*ptr)[4]; 
```


## 指针类型

从语法的角度看，你只要把指针声明语句里的指针名字去掉，剩下的部分就是这个指针的类型。这是指针本身所具有的类型。让我们看看例一中各个指针的类型： 

```
(1)int*ptr;//指针的类型是int* 
(2)char*ptr;//指针的类型是char* 
(3)int**ptr;//指针的类型是int** 
(4)int(*ptr)[3];//指针的类型是int(*)[3] 
(5)int*(*ptr)[4];//指针的类型是int*(*)[4] 
```


## 指针所指的类型

当你通过指针来访问指针所指向的内存区时，指针所指向的类型决定了编译器将把那片内存区里的内容当做什么来看待。 

从语法上看，你只须把指针声明语句中的指针名字和名字左边的指针声明符*去掉，剩下的就是指针所指向的类型。例如： 
```
(1)int*ptr;//指针所指向的类型是int 
(2)char*ptr;//指针所指向的的类型是char 
(3)int**ptr;//指针所指向的的类型是int* 
(4)int(*ptr)[3];//指针所指向的的类型是int()[3] 
(5)int*(*ptr)[4];//指针所指向的的类型是int*()[4] 
```

## 指针的值

指针的值是指针本身存储的数值，这个值将被编译器当作一个地址，而不是一个一般的数值。在32位程序里，所有类型的指针的值都是一个32位整数，因为32位程序里内存地址全都是32位长。 指针所指向的内存区就是从指针的值所代表的那个内存地址开始，长度为si zeof(指针所指向的类型)的一片内存区。以后，我们说一个指针的值是XX，就相当于说该指针指向了以XX为首地址的一片内存区域；我们说一个指针指向了某块内存区域，就相当于说该指针的值是这块内存区域的首地址。 


## 指针本身占据的内存区

一个指针ptrold加上一个整数n后，结果是一个新的指针ptrnew，ptrnew的类型和ptrold的类型相同，ptrnew所指向的类型和ptrold所指向的类型也相同。ptrnew的值将比ptrold的值增加了n乘sizeof(ptrold所指向的类型)个字节。就是说，ptrnew所指向的内存区将比ptrold所指向的内存区向高地址方向移动了n乘sizeof(ptrold所指向的类型)个字节。 

一个指针ptrold减去一个整数n后，结果是一个新的指针ptrnew，ptrnew的类型和ptrold的类型相同，ptrnew所指向的类型和ptrold所指向的类型也相同。ptrnew的值将比ptrold的值减少了n乘sizeof(ptrold所指向的类型)个字节，就是说，ptrnew所指向的内存区将比ptrold所指向的内存区向低地址方向移动了n乘sizeof(ptrold所指向的类型)个字节。 




# 指针例题一 CONTAINING_RECORD 和offsetof 的区别

```cpp
1 CONTAINING_RECORD是由结构体中的某一个部分得到本结构体的起始地址；
2 offsetof是由结构体的起始地址得到某一部分的地址；
3 两个刚好相反；
#include <stdio.h>
#include <stddef.h>
#include <windows.h>
#include <tchar.h>
#include <assert.h>
typedef struct tagNODE
{
	_TCHAR ch;
	int i;
	short sh;
}NODE,*PNODE;
int main()
{
	// CONTAINING_RECORD
	NODE node = {_T('A'),11,22};
	PNODE pNode = &node;
	// 然后就是测试我们的地址是否相同相同那么就说明宏是正确的
	// 我们使用assert 函数测试
	// 需要注意的是我们的第一个参数是个地址
	PNODE pNodeNew = CONTAINING_RECORD(&pNode->ch , NODE, ch) ;
	assert ( CONTAINING_RECORD(&pNode->ch , NODE, ch) == pNode);
	assert ( CONTAINING_RECORD(&pNode->i , NODE, i) == pNode);
	assert ( CONTAINING_RECORD(&pNode->sh , NODE, sh) == pNode);
	// 继续解释我们的offsetof
	BYTE* pBase = (BYTE*)&node;
	_tprintf(_T("ch=%c,i=%d,sh=%d.\n"),
		*(_TCHAR*)(pBase+offsetof(NODE,ch)),
		*(int*)(pBase + offsetof(NODE, i)),
		*(short*)(pBase + offsetof(NODE, sh)));
	return 0;
}

输出
ch=A,i=11,sh=22.
Press any key to continue

```

# 指针例题二 大(小)型指针访问小(大)型数据

```cpp
1.大型指针的访问能力过强,我们要缩小访问能力或者扩大我们的数据范围，防止访问出错;
2.小型指针就相反；
如：
#include<stdio.h>
int main()
{
	char a=65;
	//int* p = (int*)&a;
	int* p = (int*)(&a+1);//a是char类型的，使用int*类型的指针来访问
	// 就会有内存错误
	// a的内存分布是 65 _ _ _  _ _ _ _
	//解决方法是把 ，65之后的四个字节全部置为0
	// 这样做的结果会影响下一四个字节的前一个字节
	
	//int* p = (int*)(&a+1) 等于 int* p = (int*)(&a+(sizeof(a)))
	//*p = 0;				
	//p = (int*) &a;		//+1  是加了 sizeof(a)
	printf("%d",*p);
	return 0;
}

#include<stdio.h>
int main()
{
	int a=0x12345678;
	//unsigned char* p = (unsigned char*)&a;//输出255
	char* p = (char*)&a;//输出-1
	printf("int a=0x12345678 , char *p=(char*)&a, *p=0x\%x\n",*p);
	return 0;
}
输出
int a=0x12345678 , char *p=(char*)&a, *p=0x78
Press any key to continue

```

# 指针例题三 函数指针数组的指针

```cpp
#include <stdio.h>
#include <windows.h>
char* fun1(char *p)
{
	printf("fun1:%s\n",p);
	return p;
}
char* fun2(char *p)
{
	printf("fun2:%s\n",p);
	return p;
}
char* fun3(char *p)
{
	printf("fun3:%s\n",p);
	return p;
}
int main()
{
	char* (*a[3])(char *p) = {0}; // 函数指针数组
	char* (*(*pf)[3])(char* p) = NULL;//函数指针数组的指针
	pf = &a;
	a[0] = fun1;
	a[1] = &fun2;
	a[2] = &fun3;
	pf[0][0]("fun1");
	pf[0][1]("fun2");
	pf[0][2]("fun3");
	return 0;
}

```

# 指针例题四 类成员函数指针

```cpp
#include <iostream>
using namespace std;
class CMyClass;
typedef int (CMyClass::*pSubFunc)( int);//函数指针类型 typedef的声明 不占内存  
class CMyClass
{
public:
	static void Add();//静态函数不属于任何一个类  但是 可以用类定义函数的方法定义函数
	int Sub(int);
};
static void(*Add1)();  //静态函数指针  前面 不能加typedef 
void CMyClass::Add()//实现静态函数
{
	cout<<"CMyClass::Static Add()"<<endl;
}
int CMyClass::Sub(int a)
{
	cout<<"CMyClass::Normal Sub()"<<endl;
	return 0;
}
int main()
{
	// 很奇怪的调用方法
	pSubFunc pOne = CMyClass::Sub;  //这是类里面 一般函数成员的指针  需要类对象才能调用的  
	CMyClass One;
	(One.*pOne)(3);//sub()  函数需要使用类对象调用   这就是语法 需要记  没对象不能调用  

	Add1 = CMyClass::Add;
	Add1();//因为静态函数 不属于任何一个类，属于整个程序  则不需要用类定义一个对象来调用这个函数
	One.Add();//没问题   对象也可以调用静态函数   静态函数就是多了一种调用方式  静态函数在类没有出现的时候  函数就已经生成
  
}

```

# 指针例题五 区分 int* a[3]  与 int (*a)[3]

```cpp
#include <stdio.h>
#include <windows.h>
void Fun(int (*a)[3],int nRow)
{
  int i = 0,j = 0;
  for(i=0;i<nRow;++i)
  {
    for(j =0;j<3;++j)
      printf("%2d ",a[i][j]);
    printf("\n");
  }
}
void BigFunc(int *a[3])
{
   int i = 0;
   for (i=0;i<3;++i)
      printf("%3d ",*a[i]);  // a[i] 存放的是地址 ,a[i] 是一维指针
}

int main()
{

  int a[3][3] = {1,2,3,4,5,6,7,8,9};
  Fun(a,3); // 这里正确   我们可以说 int a[3][3]  与 int(*a)[3] 等价
  //BigFunc(a,3); // 这里编译会报错 因为 int a[3][3] 与 int *a[3] 不等价
  // BigFunc(&a,3); //cannot convert parameter 1 from 'int (*)[3][3]' to 'int *[]'
  // 这里也是错误的，我们推断int* a[10] 其中的a 是二维指针 因此 数组中存放的是指针 
  // int *a[10] 等价于 int **a ;下面进行例证
  int **p = (int**)malloc(sizeof(int*)*3);
  int i = 110;
  int j = 120;
  int k = 130;
  p[0] = &i;
  p[1] = &j;
  p[2] = &k;
  BigFunc(p);  // 我们看到这里正确了，可以输出 110,120,130 因此  int* a[3] 是与 int**a 等价的
                // 即  int* a[3]  中存放的是指针，是指针数组 , a是数组的首元素的首地址(注意区分数组首地址), 
                // 在这里就是二维指针
  free(p);
  return 0;
}

输出
 1  2  3
 4  5  6
 7  8  9
110 120 130 Press any key to continue


```

# 数组与指针结合


## 1 动态二维数组

```cpp
#include<stdio.h>
int main()
{
	int** p=new int* [2];
     *p=new int [2];
	 *(p+1)=new int [2];
	 int i=0,j=0;
	 int Temp=0;
	 int k=0,r=0;
	 int iArray[2][2] = {1,2,3,4};
	 for(i=0;i<2;i++)
	 {
		 for(j=0;j<2;j++)
		 {
			 *(*(p+i)+j)=iArray[i][j];

		 }
	 }
	 for(i=0;i<2;i++)//冒泡算法
	 {
		 for(j=0;j<2;j++)
		 {
			for(k=i+1;k<2;k++)
			{
				for(r=j+1;r<2;r++)
				{
					if( *(*(p+i)+j)< *(*(p+k)+r))
					{
						Temp=*(*(p+i)+j);
						*(*(p+i)+j)=*(*(p+k)+r);
						*(*(p+k)+r)=Temp;
					}
				}
			}

		 }
	 }
	 for(i=0;i<2;i++)
	 {
		 for(j=0;j<2;j++)
		 {
			 printf("%d ",*(*(p+i)+j));

		 }
	 }
	 delete *p;
	 printf("\n");
	return 0;
}
```

## 2 数组指针

```cpp
#include <stdio.h>
#include <windows.h>
int main()
{
	char a[5] = {'A','B','C','D'};
	char (*p3)[5] = &a; // p3 是指针 存放 数组首地址 *p3 也是数组的首地址 打印**p才是A  
	//  char (*p4)[5] = a; // 这个会报错  因为 a 是数组首元素的地址 &a 才是数组的首地址
   //char (*p3)[3] = &a ; // 错误
  // char (*p3)[10] = &a ;// 错误
  printf("%c \n",**p3);  
  return 0;
}
第二例
#include <stdio.h>
#include <tchar.h>
int _tmain(int argc, _TCHAR* argv[])
{
	int a[2][2] = {1,2,3,4};
	int **p = (int**)a; // 换做是 &a 也是一样的结果
	int i = 0,j =0;
	for (i=0;i<2;i++)
		for (j=0;j<2;j++)
			printf("%d ",*(p+i)+j);   // 注意这里我们定义的p是二维指针所以使用p访问的时候
			//　需要* 两次一次的话就是一维指针也就看作了一个地址
			// 对地址+1  就是+4 个字节 以地址加的方式加的但是打印的是数字
			// 所以答案是1 5  2 6
			// cout 打印就是0x00000001 0x00000005   0x00000002 0x00000006
	
	printf("\n*****************************************\n");
	for(i=0;i<2;++i)
		for (j=0;j<2;j++)
			printf("%d  ",*(p+i+j));  // 我草这里竟然是1  2  2  3  
	printf("\n*****************************************\n");
	
	for (i=0;i<2;i++)
	{
		for (j=0;j<2;j++)
		{
			// printf("%d\n",**(p+i)+j); // 注意这里是不能打印的 因为即使我们的*(p+i) 是地址但是无效的地址
			// 0x00000001 是不允许访问的
		}
	}
	return 0;
}
```

## 3 数组指针+1的问题

```cpp
#include <stdio.h>
#include <Windows.h>
int main()
{
	int a[5] = {1,2,3,4,5};
	int * ptr1 = (int*) (&a+1); // 这里加加的是sizeof a  为数组的长度 直接把数组加过去了
	int *ptr2 = (int*)((int)a+1); // a 在内存中存放形式 01 00 00 00 02 00 00 00 00 ...  
	// 因为这里的+1 是加了一个字节所以取出一个字节就是 00 00 00 02 读出来就是02000000
	printf("ptr1[-1] = %x,*ptr2 = %x,*a = %x\n ,*(ptr1-1) = %d,*(a+1) = %d\n",
		ptr1[-1],*ptr2,*a,*(ptr1-1),*(a+1));
	printf("&a = %#p,&a+1 = %#p ,&a+1 - &a=%d,(&a+1 -&a)/sizeof(int)=%d,\
		((int)(&a+1)-(int)&a)/sizeof(int)=%d\n",
		&a,&a+1 , &a+1 -&a,(&a+1 -&a)/sizeof(int),((int)(&a+1)-(int)&a)/sizeof(int)); 
	//&a = 0X0012FF34,&a+1 = 0X0012FF48 
	return 0;
}
```

## 4 一维指针与二维指针的概念区别

```cpp
#include <stdio.h>
#include <iostream>
using namespace std;
int  main()
{
	int a[] = {1,2};
	int **p = (int**)a;
	int i,j;
	// 因为p是二维指针 前面写一个* 是变成了一维指针
	// 一维指针int*的+1 操作是加4个字节,16进制数字显示上会+4
	for (i=0; i<2; ++i)
		for (j=0; j<2; ++j)
			printf("%d ",(*(p+i)+j));//注意这里*只一次，就是解引用只有一次
	printf("\n");
	for (i=0; i<2; ++i)
		for (j=0; j<2; ++j)
			cout<<(*(p+i)+j)<<" ";
	return 0;
}

```