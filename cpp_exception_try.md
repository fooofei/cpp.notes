```cpp
if (0)
{
    // 弹崩溃窗口
    assert(0);
}

else
{
    // 不弹崩溃窗口
    __try
    {
        assert(0);
    }
    __except(EXCEPTION_EXECUTE_HANDLER)
    {
        printf("exp");
    }
}
```
