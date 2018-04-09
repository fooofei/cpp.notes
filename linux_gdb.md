

### Reload symbol

正在调试一个 `binary` ，我们加过了 `breakpoints`，加过了 `command line`，

不想 `quit` 然后重新来，直接使用 `run` 命令又会发生可能 `binary` 更改前后 `symbol` 不一致，

debug 时发生异常现象，比如 看到一行代码就是运行了，但是结果却不符合预期， `int i = 10;` 

这样一行代码执行了，但是 i 却不为 10，这样的问题。

这时候可以使用 

```
(gdb) file <binary path>
Reading symbols from <binary path>...done.

(gdb) r 
```

[How to reload a recompiled binary in gdb without exiting and losing breakpoints?] 
https://stackoverflow.com/questions/49487977/how-to-reload-a-recompiled-binary-in-gdb-without-exiting-and-losing-breakpoints



### Doc

[Linux Tools Quick Tutorial] gdb 调试利器 (http://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/gdb.html)
[100-gdb-tips] https://wizardforcel.gitbooks.io/100-gdb-tips/print-threads.html


### Dump memory
[dump memory in gdb](http://it.taocms.org/08/4272.htm)

`(gdb) dump binary memory <file> <start_addr> <end_addr>`


### View data

[view data](http://blog.51cto.com/eminzhang/1256022)

p /x  <expr> 十六进制打印数据
p /t <expr> 二进制格式打印数据
p /c <expr> 字符格式打印数据

p $eax 查看函数返回值  函数结束返回值在 eax 寄存器中

display <expr>  类似 VisualStudio 中的 watch 

x 查看内存


### LLDB GDB map

[lldb <-> gdb map](https://lldb.llvm.org/lldb-gdb.html)