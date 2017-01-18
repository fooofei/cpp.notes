```
	if (0)
    {
        // µ¯±ÀÀ£´°¿Ú
        assert(0);
    }

    else
    {
        // ²»µ¯±ÀÀ£´°¿Ú
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