�� dll �д���ʵ��ʱ��ʵ���ͷ����⡣


1��һ��Ĵ���ģʽ��
 LoadLibrary -> GetProcAddress 
	-> CreateInstance ->AddRef -> Release 
 ->FreeLibrary
 
2�������������ʵ��ʱ��
	LoadLibrary 1 -> GetProcAddress 1 
		-> CreateInstance 1 -> AddRef 1 
	-> LoadLibrary 2 -> GetProcAddress 2 
		-> CreateInstance 2 -> AddRef 2 -> Release 2 
	->FreeLibrary 2 
		-> Release 1 
	-> FreeLibrary 1

�� Release 1 ֮ǰ�� FreeLibrary 2 ��������𣿲��ᣬ���õ��ġ�
