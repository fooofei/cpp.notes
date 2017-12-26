
如果代码文件编码为 utf-8 no BOM，在代码文件中增加了中文注释，

那么 Visual Studio 编译报警告：

warning C4819: 该文件包含不能在当前代码页(936)中表示的字符。请将该文件保存为 Unicode 格式以防止数据丢失

还会造成影响：调试时，行数跟代码对不上。

解决的办法：
属性 -> 配置属性 -> C/C++ -> 命令行 其他选项增加
/source-charset:utf-8 /execution-charset:utf-8  
见官方操作
https://msdn.microsoft.com/en-us/library/mt708821.aspx


相关链接:
http://zhiqiang.org/note/md/vs-2013-c4819-warning.html
