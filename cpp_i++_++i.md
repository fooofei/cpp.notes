
# �ֱ�++i  �� i++�� ����  

ֻ������ = ��������

```
1.i++����ִ�����������ʽ֮�󣬲Ż�������++i������Ȼ��Ż�ִ���������ʽ��
2.���һ�����ʽ�г����������ϵ�ĳ������ǰ��������������Ŀ��������кܴ��ϵ��Visual C++ 6.0 ��Visual 2008 �Ĵ���ʽ�Ͳ�ͬ��

```

```cpp
#include <stdio.h>
int main()
{
	int i = 4;
	printf("%d ",++i+ ++i+ ++i); // Visual C++ 6.0�� 6+6+7=19  Visual 2008��7+7+7=21
	return 0;
}

```

in Visual C++ 6.0

asm:

![](cpp_i++_++i_vc6_asm.png)

![](cpp_i++_++i_vc6_asm_tu.png)

in Visual Studio 2008

asm:

![](cpp_i++_++i_vs2008_asm.png)

![](cpp_i++_++i_vs2008_asm_tu.png)