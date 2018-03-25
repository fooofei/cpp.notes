


### x86 x64 sw

用户是 x64 系统，运行 x86 dll ，崩溃的 dump 文件，分析时，windbg 使用命令切换到 x86 友好查看模式.
```
.load wow64exts
 !sw
```

### env

设置环境变量
key:_NT_SYMBOL_PATH
values:
SRV*D:\windbg_symbols
srv*http://msdl.microsoft.com/download/symbols


### 设置崩溃自动启动 Windbg
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AeDebug
Debuger = "C:\Program Files\Windows Kits\8.1\Debuggers\x64\windbg.exe" -p %ld -e %ld -g

windbg.exe -I 也行

一个两个 windbg.exe, x64 位注册后无效就 注册 x86 的