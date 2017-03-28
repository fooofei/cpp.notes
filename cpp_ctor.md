```
  struct base
  {
      int data;
      base()
      {
          data = 0;
      }
      base( int a)
      {
          data = a;
      }
      base( const base & )
      {
          printf("copy ctor\n");
      }
  };

  int main()
  {
       base b = 1;
       b = 2;
      return 0;
  }
```


可以编译成功。 `b = 2 ` 调用了有参构造函数。以后对于单个参数的构造函数还是推荐写 `explicit`。
