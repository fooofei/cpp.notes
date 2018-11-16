

### EPOLL 事件触发时机

https://blog.csdn.net/halfclear/article/details/78061771

### 使用过的2个 epoll 设计

1 一个线程epoll_wait,所有fd都在这个线程得到关心。

	epoll_wait获得消息后，加入无锁队列。

  其他worker线程从无锁队列获取事件的结构体，去执行IO和计算。

  这样大弊端是不能使用 epoll 的 EPOLLLT 工作模式。

  代表： 梁斌peeny 在 pollword上的使用。微博搜索关键字“： "queue" "pullword" "无锁队列"

2 陈硕的 one loop per thread。多个epoll_wait, 以线程为单位，每个线程配备epoll，

IO只在当前线程处理，不传递IO事件到其他线程 ，accept 的工作放到 acceptor，一个线程只用来接受TCP连接，

把链接负载分担到其他线程。

### epoll_wait 

多个线程 epoll_wait 在同一个fd上，要避免惊群。不建议这么设计。

https://idea.popcount.org/2017-02-20-epoll-is-fundamentally-broken-12/

### epoll 资源限制

以下文件可以用来限制epoll使用的内核态内存空间大小(Linux 2.6.28 开始)：

/proc/sys/fs/epoll/max_user_watches


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


我自己的发现是，使用 EPOLLET 工作模式，在得到一次 EPOLLIN 事件后，read 之前，下一次 EPOLLIN 事件也会到来，

也就是在第一次 EPOLLIN 之后，socket 已经是 readable 了，但是照样会来第二次 EPOLLIN ，这里会引发自己线程处理bug。

在微博搜索到一个人的说法也验证我的实验："淘叔度:epoll的那些事儿3：ET的EPOLLIN针对的不是buffer满不满，而是事件有没有被消耗完。

也就是说，底层若有新的读事件发生，即使上次的read没有把数据读完，还是照样会有EPOLLIN事件。 ​"



### EPOLLET 还是 EPOLLLT

理想的工作方式是 EPOLLIN 使用 EPOLLLT， EPOLLOUT 使用 EPOLLET。

也就是说在 read 时期待协议栈缓冲区有数据就应该通知App去读取。只有在 write 返回EAGAIN 之后，才关心 EPOLLOUT 事件，

等待可写时，继续把上次App缓存中保存的未写入的部分继续写入，直到全部写入，取消关心 EPOLLOUT 事件。


### 有关 add EPOLL fd 的细节

a 被 register 进epoll 的 fd 什么时候关闭

http://www.udpwork.com/item/6451.html
http://www.udpwork.com/item/16280.html

fd 必须在 unregister epoll (EPOLL_CTL_DEL) 之前 close(fd);

不能反序。

https://idea.popcount.org/2017-03-20-epoll-is-fundamentally-broken-22/

b 同一个fd的 read write必须在同一个线程得到处理。

c epoll_wait 跟它关心的fd 的read write 都在同一个线程得到处理，非阻塞，此为 reactor。

### epoll enum 

https://github.molgen.mpg.de/git-mirror/glibc/blob/master/sysdeps/unix/sysv/linux/sys/epoll.h

