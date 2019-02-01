

# TotalCommand

total command's plugin `VisualDirSize` can the a directory's sub files count of every sub directory.

use `CTRL+Q` to use the plugin

# Batch CurDir

这一步是为了切换磁盘，比如现在在 C 盘， cd 到 D 盘某个目录是失败的。

需要先切到 D 盘，才能到 D 盘中某个目录。
```
%~d0
cd /d %~dp0
```


# CNTLM

### 使用背景：
  某些代理是 NTLM 类型，该类型要求 在普通代理 host+port 的基础上增加 user password 认证。
  但是我们普通的软件 如 Git 不支持这种 NTLM 代理方式。
  需要增加一层转换。
  
### 使用的转换软件：
  cntlm http://cntlm.sourceforge.net/
  
### 安装
#### Windows
安装时不要自己更改路径，一定要使用默认路径。因为 cntlm 是基于 linux 平台开发的软件， Windows 版本是直接用 linux 版本代码，cygwin 编译的。
在路径处理上有 bug。
在安装时如果更改过路径，会看到 warning
  cygwin warning:
  MS-DOS style path detected: D:\Program Files (x86)\Cntlm\cntlm.ini
  Preferred POSIX equivalent is: /Cntlm/cntlm.ini
不能改为 c:\cntlm 也不能改为 d:\program files\

### 使用
 获取认证信息 用来填充 cntlm.ini 文件
 cntlm.exe -H   或者  cntlm.exe -v -c cntlm.ini -I -M http://www.baidu.com
 生成的填充到  PassLM PassNT  PassNTLMv2(可选)
 有了这个不需要填写 Password
 
 cntlm.ini 文件在 Windows linux 通用。
 
 
 NoProxy 这个需要自己找找
 
 Auth		NTLM #这个一定要加上
 Allow		127.0.0.1
 
 Proxy  允许 domain + port， 不一定是 IP 地址
 
### 启动 
以服务方式启动 在【服务】或者【开始菜单】见到名字 Cntlm Authentication Proxy



### 查看使用情况

定位问题。到 Windows 事件查看器。  【Windows 日志】 -> 【应用程序】

# Windows Jump Lists
```
https://www.forensicfocus.com/Forums/viewtopic/p=6576440/
http://forensicswiki.org/wiki/Jump_Lists
https://ericzimmerman.github.io/
https://binaryforay.blogspot.my/2016/02/jump-lists-in-depth-understand-format.html
tool https://tzworks.net/prototype_page.php?proto_id=20
```


# Local NetWork File Transfer

```
http://cend.me 内网 connect 失败
https://send.firefox.com/ 内网打不开
https://www.raysync.cn/ 不是本地局域网传输了
https://filenation.io/ 内网能打开能发文件但是接收不到
https://fileshifter.io/converter/  内网无法打开 
http://tmp.link/ 内网上传失败 无响应
```
