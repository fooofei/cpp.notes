
# ָ��

����������ָ����������ӣ� 

```
��һ�� 
(1)int*ptr; 
(2)char*ptr; 
(3)int**ptr; 
(4)int(*ptr)[3]; 
(5)int*(*ptr)[4]; 
```


## ָ������

���﷨�ĽǶȿ�����ֻҪ��ָ������������ָ������ȥ����ʣ�µĲ��־������ָ������͡�����ָ�뱾�������е����͡������ǿ�����һ�и���ָ������ͣ� 

```
(1)int*ptr;//ָ���������int* 
(2)char*ptr;//ָ���������char* 
(3)int**ptr;//ָ���������int** 
(4)int(*ptr)[3];//ָ���������int(*)[3] 
(5)int*(*ptr)[4];//ָ���������int*(*)[4] 
```


## ָ����ָ������

����ͨ��ָ��������ָ����ָ����ڴ���ʱ��ָ����ָ������;����˱�����������Ƭ�ڴ���������ݵ���ʲô�������� 

���﷨�Ͽ�����ֻ���ָ����������е�ָ�����ֺ�������ߵ�ָ��������*ȥ����ʣ�µľ���ָ����ָ������͡����磺 
```
(1)int*ptr;//ָ����ָ���������int 
(2)char*ptr;//ָ����ָ��ĵ�������char 
(3)int**ptr;//ָ����ָ��ĵ�������int* 
(4)int(*ptr)[3];//ָ����ָ��ĵ�������int()[3] 
(5)int*(*ptr)[4];//ָ����ָ��ĵ�������int*()[4] 
```

## ָ���ֵ

ָ���ֵ��ָ�뱾��洢����ֵ�����ֵ��������������һ����ַ��������һ��һ�����ֵ����32λ������������͵�ָ���ֵ����һ��32λ��������Ϊ32λ�������ڴ��ַȫ����32λ���� ָ����ָ����ڴ������Ǵ�ָ���ֵ��������Ǹ��ڴ��ַ��ʼ������Ϊsi zeof(ָ����ָ�������)��һƬ�ڴ������Ժ�����˵һ��ָ���ֵ��XX�����൱��˵��ָ��ָ������XXΪ�׵�ַ��һƬ�ڴ���������˵һ��ָ��ָ����ĳ���ڴ����򣬾��൱��˵��ָ���ֵ������ڴ�������׵�ַ�� 


## ָ�뱾��ռ�ݵ��ڴ���

һ��ָ��ptrold����һ������n�󣬽����һ���µ�ָ��ptrnew��ptrnew�����ͺ�ptrold��������ͬ��ptrnew��ָ������ͺ�ptrold��ָ�������Ҳ��ͬ��ptrnew��ֵ����ptrold��ֵ������n��sizeof(ptrold��ָ�������)���ֽڡ�����˵��ptrnew��ָ����ڴ�������ptrold��ָ����ڴ�����ߵ�ַ�����ƶ���n��sizeof(ptrold��ָ�������)���ֽڡ� 

һ��ָ��ptrold��ȥһ������n�󣬽����һ���µ�ָ��ptrnew��ptrnew�����ͺ�ptrold��������ͬ��ptrnew��ָ������ͺ�ptrold��ָ�������Ҳ��ͬ��ptrnew��ֵ����ptrold��ֵ������n��sizeof(ptrold��ָ�������)���ֽڣ�����˵��ptrnew��ָ����ڴ�������ptrold��ָ����ڴ�����͵�ַ�����ƶ���n��sizeof(ptrold��ָ�������)���ֽڡ� 




# ָ������һ CONTAINING_RECORD ��offsetof ������

```cpp
1 CONTAINING_RECORD���ɽṹ���е�ĳһ�����ֵõ����ṹ�����ʼ��ַ��
2 offsetof���ɽṹ�����ʼ��ַ�õ�ĳһ���ֵĵ�ַ��
3 �����պ��෴��
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
	// Ȼ����ǲ������ǵĵ�ַ�Ƿ���ͬ��ͬ��ô��˵��������ȷ��
	// ����ʹ��assert ��������
	// ��Ҫע��������ǵĵ�һ�������Ǹ���ַ
	PNODE pNodeNew = CONTAINING_RECORD(&pNode->ch , NODE, ch) ;
	assert ( CONTAINING_RECORD(&pNode->ch , NODE, ch) == pNode);
	assert ( CONTAINING_RECORD(&pNode->i , NODE, i) == pNode);
	assert ( CONTAINING_RECORD(&pNode->sh , NODE, sh) == pNode);
	// �����������ǵ�offsetof
	BYTE* pBase = (BYTE*)&node;
	_tprintf(_T("ch=%c,i=%d,sh=%d.\n"),
		*(_TCHAR*)(pBase+offsetof(NODE,ch)),
		*(int*)(pBase + offsetof(NODE, i)),
		*(short*)(pBase + offsetof(NODE, sh)));
	return 0;
}

���
ch=A,i=11,sh=22.
Press any key to continue

```

# ָ������� ��(С)��ָ�����С(��)������

```cpp
1.����ָ��ķ���������ǿ,����Ҫ��С�������������������ǵ����ݷ�Χ����ֹ���ʳ���;
2.С��ָ����෴��
�磺
#include<stdio.h>
int main()
{
	char a=65;
	//int* p = (int*)&a;
	int* p = (int*)(&a+1);//a��char���͵ģ�ʹ��int*���͵�ָ��������
	// �ͻ����ڴ����
	// a���ڴ�ֲ��� 65 _ _ _  _ _ _ _
	//��������ǰ� ��65֮����ĸ��ֽ�ȫ����Ϊ0
	// �������Ľ����Ӱ����һ�ĸ��ֽڵ�ǰһ���ֽ�
	
	//int* p = (int*)(&a+1) ���� int* p = (int*)(&a+(sizeof(a)))
	//*p = 0;				
	//p = (int*) &a;		//+1  �Ǽ��� sizeof(a)
	printf("%d",*p);
	return 0;
}

#include<stdio.h>
int main()
{
	int a=0x12345678;
	//unsigned char* p = (unsigned char*)&a;//���255
	char* p = (char*)&a;//���-1
	printf("int a=0x12345678 , char *p=(char*)&a, *p=0x\%x\n",*p);
	return 0;
}
���
int a=0x12345678 , char *p=(char*)&a, *p=0x78
Press any key to continue

```

# ָ�������� ����ָ�������ָ��

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
	char* (*a[3])(char *p) = {0}; // ����ָ������
	char* (*(*pf)[3])(char* p) = NULL;//����ָ�������ָ��
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

# ָ�������� ���Ա����ָ��

```cpp
#include <iostream>
using namespace std;
class CMyClass;
typedef int (CMyClass::*pSubFunc)( int);//����ָ������ typedef������ ��ռ�ڴ�  
class CMyClass
{
public:
	static void Add();//��̬�����������κ�һ����  ���� �������ඨ�庯���ķ������庯��
	int Sub(int);
};
static void(*Add1)();  //��̬����ָ��  ǰ�� ���ܼ�typedef 
void CMyClass::Add()//ʵ�־�̬����
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
	// ����ֵĵ��÷���
	pSubFunc pOne = CMyClass::Sub;  //���������� һ�㺯����Ա��ָ��  ��Ҫ�������ܵ��õ�  
	CMyClass One;
	(One.*pOne)(3);//sub()  ������Ҫʹ����������   ������﷨ ��Ҫ��  û�����ܵ���  

	Add1 = CMyClass::Add;
	Add1();//��Ϊ��̬���� �������κ�һ���࣬������������  ����Ҫ���ඨ��һ�������������������
	One.Add();//û����   ����Ҳ���Ե��þ�̬����   ��̬�������Ƕ���һ�ֵ��÷�ʽ  ��̬��������û�г��ֵ�ʱ��  �������Ѿ�����
  
}

```

# ָ�������� ���� int* a[3]  �� int (*a)[3]

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
      printf("%3d ",*a[i]);  // a[i] ��ŵ��ǵ�ַ ,a[i] ��һάָ��
}

int main()
{

  int a[3][3] = {1,2,3,4,5,6,7,8,9};
  Fun(a,3); // ������ȷ   ���ǿ���˵ int a[3][3]  �� int(*a)[3] �ȼ�
  //BigFunc(a,3); // �������ᱨ�� ��Ϊ int a[3][3] �� int *a[3] ���ȼ�
  // BigFunc(&a,3); //cannot convert parameter 1 from 'int (*)[3][3]' to 'int *[]'
  // ����Ҳ�Ǵ���ģ������ƶ�int* a[10] ���е�a �Ƕ�άָ�� ��� �����д�ŵ���ָ�� 
  // int *a[10] �ȼ��� int **a ;���������֤
  int **p = (int**)malloc(sizeof(int*)*3);
  int i = 110;
  int j = 120;
  int k = 130;
  p[0] = &i;
  p[1] = &j;
  p[2] = &k;
  BigFunc(p);  // ���ǿ���������ȷ�ˣ�������� 110,120,130 ���  int* a[3] ���� int**a �ȼ۵�
                // ��  int* a[3]  �д�ŵ���ָ�룬��ָ������ , a���������Ԫ�ص��׵�ַ(ע�����������׵�ַ), 
                // ��������Ƕ�άָ��
  free(p);
  return 0;
}

���
 1  2  3
 4  5  6
 7  8  9
110 120 130 Press any key to continue


```

# ������ָ����


## 1 ��̬��ά����

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
	 for(i=0;i<2;i++)//ð���㷨
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

## 2 ����ָ��

```cpp
#include <stdio.h>
#include <windows.h>
int main()
{
	char a[5] = {'A','B','C','D'};
	char (*p3)[5] = &a; // p3 ��ָ�� ��� �����׵�ַ *p3 Ҳ��������׵�ַ ��ӡ**p����A  
	//  char (*p4)[5] = a; // ����ᱨ��  ��Ϊ a ��������Ԫ�صĵ�ַ &a ����������׵�ַ
   //char (*p3)[3] = &a ; // ����
  // char (*p3)[10] = &a ;// ����
  printf("%c \n",**p3);  
  return 0;
}
�ڶ���
#include <stdio.h>
#include <tchar.h>
int _tmain(int argc, _TCHAR* argv[])
{
	int a[2][2] = {1,2,3,4};
	int **p = (int**)a; // ������ &a Ҳ��һ���Ľ��
	int i = 0,j =0;
	for (i=0;i<2;i++)
		for (j=0;j<2;j++)
			printf("%d ",*(p+i)+j);   // ע���������Ƕ����p�Ƕ�άָ������ʹ��p���ʵ�ʱ��
			//����Ҫ* ����һ�εĻ�����һάָ��Ҳ�Ϳ�����һ����ַ
			// �Ե�ַ+1  ����+4 ���ֽ� �Ե�ַ�ӵķ�ʽ�ӵĵ��Ǵ�ӡ��������
			// ���Դ���1 5  2 6
			// cout ��ӡ����0x00000001 0x00000005   0x00000002 0x00000006
	
	printf("\n*****************************************\n");
	for(i=0;i<2;++i)
		for (j=0;j<2;j++)
			printf("%d  ",*(p+i+j));  // �Ҳ����ﾹȻ��1  2  2  3  
	printf("\n*****************************************\n");
	
	for (i=0;i<2;i++)
	{
		for (j=0;j<2;j++)
		{
			// printf("%d\n",**(p+i)+j); // ע�������ǲ��ܴ�ӡ�� ��Ϊ��ʹ���ǵ�*(p+i) �ǵ�ַ������Ч�ĵ�ַ
			// 0x00000001 �ǲ�������ʵ�
		}
	}
	return 0;
}
```

## 3 ����ָ��+1������

```cpp
#include <stdio.h>
#include <Windows.h>
int main()
{
	int a[5] = {1,2,3,4,5};
	int * ptr1 = (int*) (&a+1); // ����Ӽӵ���sizeof a  Ϊ����ĳ��� ֱ�Ӱ�����ӹ�ȥ��
	int *ptr2 = (int*)((int)a+1); // a ���ڴ��д����ʽ 01 00 00 00 02 00 00 00 00 ...  
	// ��Ϊ�����+1 �Ǽ���һ���ֽ�����ȡ��һ���ֽھ��� 00 00 00 02 ����������02000000
	printf("ptr1[-1] = %x,*ptr2 = %x,*a = %x\n ,*(ptr1-1) = %d,*(a+1) = %d\n",
		ptr1[-1],*ptr2,*a,*(ptr1-1),*(a+1));
	printf("&a = %#p,&a+1 = %#p ,&a+1 - &a=%d,(&a+1 -&a)/sizeof(int)=%d,\
		((int)(&a+1)-(int)&a)/sizeof(int)=%d\n",
		&a,&a+1 , &a+1 -&a,(&a+1 -&a)/sizeof(int),((int)(&a+1)-(int)&a)/sizeof(int)); 
	//&a = 0X0012FF34,&a+1 = 0X0012FF48 
	return 0;
}
```

## 4 һάָ�����άָ��ĸ�������

```cpp
#include <stdio.h>
#include <iostream>
using namespace std;
int  main()
{
	int a[] = {1,2};
	int **p = (int**)a;
	int i,j;
	// ��Ϊp�Ƕ�άָ�� ǰ��дһ��* �Ǳ����һάָ��
	// һάָ��int*��+1 �����Ǽ�4���ֽ�,16����������ʾ�ϻ�+4
	for (i=0; i<2; ++i)
		for (j=0; j<2; ++j)
			printf("%d ",(*(p+i)+j));//ע������*ֻһ�Σ����ǽ�����ֻ��һ��
	printf("\n");
	for (i=0; i<2; ++i)
		for (j=0; j<2; ++j)
			cout<<(*(p+i)+j)<<" ";
	return 0;
}

```