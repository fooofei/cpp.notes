
### EPOLLET 

epoll 是比 select, poll 都性能更高的处理并发请求的解决方案。

epoll要面对 EPOLLET边缘触发 EPOLLLT 水平触发两种工作模式。

不带两者任何标记，add epoll 都是 EPOLLLT，注明要 EPOLLET，才会使用 EPOLLET，所以不存在 EPOLLLT 标记。

常见的 EPOLLET EPOLLLT 消息触发方式解释见 https://blog.csdn.net/skymanwu/article/details/7429312。

(这博客里的 read 也不对， read返回0，通常表示对端已经关闭)

提到两者的区别在于 socket 从 readable/writeable 的状态切换，可理解为如下：

socket 从unreadable/unwriteable -> readable/writeable   EPOLLET EPOLLLT 都会触发.

如果我们继续 recv/send 部分数据，也就是缓冲区还有剩余数据，

表现在API为第二次调用 recv/send 返回值 >0， 如果不做第二次调用，此时 socket 状态不发生 

readable/writeable->unreadable/unwriteable 的迁移， EPOLLLT 照样触发， EPOLLET 不触发。



如果按照这个理解无误的话，在使用 epoll_wait API 时发现，并不是上面表述的那样，

参照 EPOLLONESHOT 的存在。


我自己的发现是，使用 EPOLLET 工作模式，在得到一次 epollin 事件后，read 之前，下一次 epollin 事件也会到来，

也就是在第一次 epollin 之后，socket 已经是 readable 了，但是照样会来第二次 epollin，这里会引发自己线程处理bug。




### 有关 add EPOLL fd 的细节

被 register 进epoll 的 fd 什么时候关闭

http://www.udpwork.com/item/6451.html
http://www.udpwork.com/item/16280.html

fd 必须在 unregister epoll (EPOLL_CTL_DEL) 之前 close(fd);

不能反序。

### epoll enum 

https://github.molgen.mpg.de/git-mirror/glibc/blob/master/sysdeps/unix/sysv/linux/sys/epoll.h

