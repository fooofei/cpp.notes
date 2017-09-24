
## crack 010editor with ida

1 open with ida, shift + F12, open [Strings window]

2 search a string startswith "Invalid name", use command `x`, jump to it.

还有个字符串可以搜索 "Password accepted" "This license entitle"

3 跳转好几次，没办法描述了。写不下来，看到这的时候自己猜。从上面的字符串跳转到校验 key 的代码块。

4 到发现 只需要 return 0DB h 就行了，就不会让我注册了。

5 需要用到 配置 Options->General-> Auto comments (给汇编显示注释)   Options->General->Number of opcode bytes (显示汇编对应十六进制值)

6 接下来在某个函数里，需要用到 90 (就是 nop 空指令) 把某些跳转指令和判断屏蔽掉，mov eax ,<立即数> 更改为 mov eax 0DB.

更改需要跳到 HexView 窗口按 F2 进入修改模式，修改完毕继续 F2 保存修改，这个修改不会保存到硬盘上。

要保存到硬盘上，需找到每一处修改的位置和值，可以用 ida 的 Jump->Jump to file offset 定位修改位置在文件中的偏移，然后使用其他的二进制
 
编辑器编辑二进制文件。 

7 通过  File -> Produce File -> Create DIF File 生成 IDA 的 diff 文件，然后通过脚本把 patch 生效.


更改的那段代码
```
.text:013BE220                         sub_13BE220     proc near               ; CODE XREF: sub_409CA0j
.text:013BE220
.text:013BE220                         arg_0           = dword ptr  8
.text:013BE220                         arg_4           = dword ptr  0Ch
.text:013BE220
.text:013BE220 55                                      push    ebp
.text:013BE221 8B EC                                   mov     ebp, esp
.text:013BE223 56                                      push    esi
.text:013BE224 8B F1                                   mov     esi, ecx
.text:013BE226 83 7E 2C 00                             cmp     dword ptr [esi+2Ch], 0 ; Compare Two Operands
.text:013BE22A 74 0A                                   jz      short loc_13BE236 ; Jump if Zero (ZF=1)
.text:013BE22C B8 13 01 00 00                          mov     eax, 113h
.text:013BE231 5E                                      pop     esi
.text:013BE232 5D                                      pop     ebp
.text:013BE233 C2 08 00                                retn    8               ; Return Near from Procedure
```