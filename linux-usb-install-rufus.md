
使用 rufus 制作USB CentOS安装 （iso2usb没成功）

分区类型选 MBR/GPT 任意

在使用 rufus 制作完成安装USB之后，在PC重启后CentOS出现按照错误：

```
[sdb] No Caching mode page found

　　[sdb] Assuming drive cache:write through

　　....
　　Could not boot
　　/dev/root does not exist
```

同时伴随着

```
等待比较长的一段时间后会出现 dracut 关键字
```

按照这个链接能解决安装问题

https://www.cnblogs.com/freeweb/p/5213877.html

https://blog.csdn.net/alex_my/article/details/78711850

但是不能指望每次都这样做，这是在增加安装步骤，那么我们制作的USB是那里不正确呢？

按照如下进行修复：

1 指定一个合法的USB卷标名字，比如 CentOS，CentOS7 都是合法的，CentOS 7 是非法的

2 同时在以下文件中 `hd:LABEL=` 都写上一步做的USB卷标
```
/Volumes/EULEROS/isolinux/isolinux.cfg
/Volumes/EULEROS/EFI/BOOT/grub.cfg
```
