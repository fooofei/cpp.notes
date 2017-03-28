
## crack 010editor with ida

1. open with ida , shift + F12 , open [Strings window],

2. search a string starts with "Invalid name", use command x , jump to it.

3. 跳转好几次，没办法描述了。写不下来，看到这的时候自己猜。

4. 到发现 只需要 return 0DB h 就行了，就不会让我注册了。

5. 需要用到 配置 Options->General-> Auto comments (给汇编显示注释)   Options->General->Number of opcode bytes (显示汇编对应十六进制值)

6. 接下来在某个函数里，需要用到 90 (就是 nop 空指令) 把某些跳转指令和判断屏蔽掉，mov eax ,<立即数> 更改为 mov eax 0DB.

更改需要跳到 HexView 窗口按 F2 进入修改模式，修改完毕继续 F2 保存修改，这个修改不会保存到硬盘上。

要保存到硬盘上，需找到每一处修改的位置和值，可以用 ida 的 Jump->Jump to file offset 定位修改位置在文件中的便宜，然后使用其他的二进制

编辑器编辑二进制文件。 