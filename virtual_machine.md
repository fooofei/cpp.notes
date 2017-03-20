
* host = Windows, vmware guest = Ubuntu 16.04.2, 不能在共享目录 /mnt/hgfs 中使用 git clone.
```
Cannot git clone to VMWare shared folder
http://stackoverflow.com/questions/33393077/cannot-git-clone-to-vmware-shared-folder
```

* virtualbox 安装 ubuntu 之后，ifconfig 查到的 ip 是公网 ip，host 主机无法通过 ssh 连接。

解决办法：
```
http://serverfault.com/questions/225155/virtualbox-how-to-set-up-networking-so-both-host-and-guest-can-access-internet
使用第 1 步就可以了，NAT 网络是默认存在的，增加 1 个网络 [host only] ，这个 ip 是 192.168.xxx.xxx 的，host 可以通过 ssh 访问。
```