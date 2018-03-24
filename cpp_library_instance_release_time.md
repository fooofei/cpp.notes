从 DLL 中创建实例时，实例释放问题。

模块级别，是以模块句柄为输入的操作函数

实例级别是从模块内导出函数创建的内存实例。

1、一般的代码模式：
  模块级别 LoadLibrary -> GetProcAddress 
    
    实例级别 -> CreateInstance ->AddRef -> Release 
  模块级别 ->FreeLibrary
  
  也就是说，显示 Load 模块，然后从模块中创建实例，使用实例，
  释放实例，再释放模块。 模块和实例释放顺序不可颠倒。
 
2、遇到创建多个实例时，
  模块级别 LoadLibrary 1 -> GetProcAddress 1 
    实例级别 -> CreateInstance 1 -> AddRef 1 
  模块级别 没在乎第一次 Load -> LoadLibrary 2 -> GetProcAddress 2 
		实例级别 -> CreateInstance 2 -> AddRef 2 -> Release 2 
  模块级别 ->FreeLibrary 2 
		实例级别 -> Release 1 
  模块级别 -> FreeLibrary 1

在 Release 1 之前有 FreeLibrary 2 ，会崩溃吗？不会，不用担心。
