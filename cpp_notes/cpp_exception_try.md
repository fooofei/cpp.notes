```
	if (0)
    {
        // ����������
        assert(0);
    }

    else
    {
        // ������������
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