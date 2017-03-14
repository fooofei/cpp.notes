
posix ƽ̨��ȡ�ļ���С��ȡ�ķ���(�����):
```cpp
    struct stat buf;
	int err = fstat(fd, &buf);
	if (err)
		return INVALID_FILE_SIZE;
	if (size_high)
	{
        *size_high = (DWORD)(buf.st_size >> 32);
    }
	return (DWORD)(buf.st_size);
```

��δ���ȱ�� 
1��struct stat.st_size ĳЩƽ̨�� 32λ(4 �ֽ�)�ģ����ڴ��� 4GB �ļ�������Ϊ���� 
2��ĳЩƽ̨���� struct stat.st_size �� 32 λ�� 4 �ֽ�ʱ�����ƴ��ڵ��ڵ�ǰ���ݿ�ȣ������δ����ģ�����˵����ǰ�ƶ� 32 λʱ�����δ���塣
���� mips32 λƽ̨��IDA �鿴�������ɽ�������ƻ�࣬λ�Ʋ������Ż�ʡȥ��


��������(��)��
```cpp
    struct stat buf;
	int err = fstat(fd, &buf);
	if (err)
		return INVALID_FILE_SIZE;
	if (size_high)
	{
        unsigned long long h = buf.st_size;
        *size_high = (DWORD)( h>> 32);
    }
	return (DWORD)(buf.st_size);
```