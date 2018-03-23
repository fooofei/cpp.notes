linux condition 需要加 mutex 吗？ 验证。
仅仅谈 pthread_cond_t 是不需要 mutex lock 的。
http://originlee.com/2015/01/21/trick-in-conditon-variable/
https://github.com/forkhope/apue2/blob/master/11-thread/10-cond/cond.c
https://docs.oracle.com/cd/E19253-01/819-7051/6n919hpai/index.html
https://gist.github.com/chenshuo/6430925
http://www.cppblog.com/Solstice/archive/2013/09/09/203094.html
https://stackoverflow.com/questions/4544234/calling-pthread-cond-signal-without-locking-mutex

我是从 Windows Event 出发的，这与 linux 是不同的。

当 Event 受信时（强调状态）即 SetEvent() 之后，再来 Wait*，

Wait 也会立刻返回，但是 linux pthread_cond_t  就不同了 

当 pthread_cond_signal 调用时，另一侧不阻塞在 pthread_cond_wait

等到另一侧有机会 pthread_cond_wait 了，也不会立刻返回，而是陷入阻塞。

有人这样形容这个现象“作为 Event 和 Windows 的 Event 语义不同，这个实现的 Event 是 edge-triggered，Windows 那个是 level-triggered。”

[Edge和Level触发的中断] http://www.cnblogs.com/liloke/archive/2011/04/12/2014205.html

注意 pthread_cond_timedwait 中的时间，是绝对时间，每次重新 wait 时都要重新获取当前时间，在

当前时间上堆加间隔时间。


chenshuo 问了一个思考题目。

思考题：如果用两个 mutex，一个用于保护“条件”，另一个专门用于和 cond 配合 wait()，会出现什么情况？

写法是 Waiter1

struct waiter
{
  
};

lock(mutx2)
signed=true
unlock(mutex2)
signal(cond1)



bool b;
lock(mutex2)
while(!(b=signed));
unlock(mutex2)
if(!b)
{
  wait(cond1,mutex1)
}

这个写法


写法是 Waiter2
lock(mutx2)
signed=true
unlock(mutex2)
signal(cond1)



bool b;
lock(mutex2)
b=signed;
unlock(mutex2)

if(!b)
{
  wait(cond1,mutex1)
}
