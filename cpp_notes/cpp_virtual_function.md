
* 同名虚函数的出现顺序。
同一个类中，同名的虚函数出现顺序。
此问题由一个新手在参与项目开发时，在即有接口中增加同名函数引起。

测试结果
```	
	class Test
	{
		public :
		virtual void func1(void *) {}
		virtual void func1(int ){}

	}

```
Vistual studio 2012, 2015 版本验证，在虚函数表中，是 `void func1(int)` 在 `void func1(void *)` 的前面。
甚至是倒序，但在 gcc 中不是这样的。