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


���Ա���ɹ��� `b = 2 ` �������вι��캯�����Ժ���ڵ��������Ĺ��캯�������Ƽ�д `explicit`��
