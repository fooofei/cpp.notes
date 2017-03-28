

* 用户是 x64 系统，运行 x86 dll ，崩溃的 dump 文件，分析时，windbg 使用命令切换到 x86 友好查看模式.
```
.load wow64exts
 !sw
```