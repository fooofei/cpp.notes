
* host = Windows, vmware guest = Ubuntu 16.04.2, 不能在共享目录 /mnt/hgfs 中使用 git clone.
```
Cannot git clone to VMWare shared folder
http://stackoverflow.com/questions/33393077/cannot-git-clone-to-vmware-shared-folder
```

* VirtualBox 安装 ubuntu 之后，ifconfig 查到的 ip 是公网 ip，host 主机无法通过 ssh 连接。

解决办法：
```
http://serverfault.com/questions/225155/virtualbox-how-to-set-up-networking-so-both-host-and-guest-can-access-internet
使用第 1 步就可以了，NAT 网络是默认存在的，增加 1 个网络 [host only] ，这个 ip 是 192.168.xxx.xxx 的，host 可以通过 ssh 访问。
```

* VirtualBox 设置共享文件夹 勾选自动挂载，默认挂载到 `/media` 目录, 以 `sf_` 为前缀 。

如果没有自动挂载成功，或者无法访问到，是因为目录挂载到了 `vboxsf` 组，需要把当前用户加入该组：
```
usermod -a -G vboxsf <your_user_name>
usermod -> /usr/sbin/usermod
校验是否加入成功, 当前用户的所有组:
groups <your_user_name>
```

* VirtualBox 镜像 VMWare 互转 
```
https://www.howtogeek.com/125640/how-to-convert-virtual-machines-between-virtualbox-and-vmware/
https://www.maketecheasier.com/convert-virtual-machines-vmware-virtualbox/
```