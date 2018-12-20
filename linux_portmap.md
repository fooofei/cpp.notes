

> tunnel


我能直接访问机器 A ，A能访问机器B

我想做到在我的机器上直接 ssh 访问机器B，需要打隧道

出现错误
[root@localhost ~]# channel 3: open failed: administratively prohibited: open failed

修改 /etc/ssh/sshd_config
AllowTcpForwarding yes
PermitTunnel yes

都无效

需要机器 A B 都打开 AllowTcpForwarding yes


ssh 复杂 ，试试
https://centos.pkgs.org/7/nux-misc-x86_64/rinetd-0.62-9.el7.nux.x86_64.rpm.html
vim /etc/rinetd.conf
0.0.0.0 33  <目标机器> 22

systemctl restart rinetd