
posix 平台获取文件大小采取的方案(代码块):
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

这段代码缺陷 
1、struct stat.st_size 某些平台是 32位(4 字节)的，对于大于 4GB 文件就无能为力， 
2、某些平台，在 struct stat.st_size 是 32 位， 4 字节时，右移大于等于当前数据宽度，结果是未定义的，就是说，当前移动 32 位时，结果未定义。
测试 mips32 位平台，IDA 查看编译生成结果二进制汇编，位移操作被优化省去。


修正代码(块)：
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