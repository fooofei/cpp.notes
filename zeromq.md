

### ZeroMQ

使用 ZeroMQ 通信，注意的问题：

1 在服务端程序中，如果要刷新zmq sock 的地址(endpoint) ，不能使用 zmq_socket()，而应该复用 sock ，使用 zmq_disconnect，因为 zmq_close 并不能真正做到释放 socket 资源，

这样就有资源耗尽的风险。

我使用的解决方案是：

对于获得更新的 url 则：

```
if(sock 创建过)
{
    创建 sock
}
else
{
  // 设置 ZMQ_LINGER 确保这里不会一直阻塞
  zmq_disconnect(sock, 原url);
}

zmq_connect(sock, 新url);

value = 0; // 当 zmq_disconnect 调用时忽略未发送的消息 不然会一直 block
rc = zmq_setsockopt(socks, ZMQ_LINGER, &value, sizeof(value));

```


2 `zmq_send(sock, data, data_size, ZMQ_DONTWAIT);` 是非阻塞发送，放入 zmq 发送缓冲队列之后即刻返回结果，或者无法放入队列，即可返回失败。

如果是无法放入队列，那么返回错误码为 EAGAIN =11,  Resource temporarily unavailable，队列默认 1000，也就是有 1000 个未发送的，就会在 1001 失败。

可以使用 `_size = sizeof(_value);  rc = zmq_getsockopt(sock, ZMQ_SNDHWM, &_value, &_size); ` 获取这个 1000 的值， 同样也能使用 zmq_setsockopt 更改这个值。

为了做到尽可能可靠，并且性能要保证（允许下游性能不够就丢包）不能使用 while 循环，失败就尝试，我的解决方案是：

创建 sock 时

```
int value;
value = 200; // milliseconds
rc = zmq_setsockopt(sock, ZMQ_SNDTIMEO, &value, sizeof(value));
```

发送时 
```
size = zmq_send(sock, data, data_size, ZMQ_DONTWAIT);
if (size != (int)data_size && zmq_errno() == EAGAIN)
{
   // 这一次是有阻塞的发送，超时时间为 zmq_setsockopt 设置的时间
    size = zmq_send(sock, data, data_size, 0);
}
```
