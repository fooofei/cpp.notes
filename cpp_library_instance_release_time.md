从 dll 中创建实例时，实例释放问题。


1、一般的代码模式：
 LoadLibrary -> GetProcAddress 
	-> CreateInstance ->AddRef -> Release 
 ->FreeLibrary
 
2、遇到创建多个实例时，
	LoadLibrary 1 -> GetProcAddress 1 
		-> CreateInstance 1 -> AddRef 1 
	-> LoadLibrary 2 -> GetProcAddress 2 
		-> CreateInstance 2 -> AddRef 2 -> Release 2 
	->FreeLibrary 2 
		-> Release 1 
	-> FreeLibrary 1

在 Release 1 之前有 FreeLibrary 2 ，会崩溃吗？不会，不用担心。
