
### start fail --/tmp/mysql.sock

# mysql -uroot -proot -hlocalhost
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/tmp/mysql.sock' (2)


systemctl start  mariadb.service

# systemctl start  mariadb.service
Failed to start mariadb.service: Unit not found.


# mysql.server start
-bash: mysql.server: command not found


这个有效
ln -s /var/lib/mysql/mysql.sock   /tmp/mysql.sock


### connect fail -- not allowed

MySQL 在 linux 上部署，通过另一台 Windows 机器使用 GUI 远程链接。

错误提示
Configuring database connection results in Error:
Host 'xxxxxxx' is not allowed to connect to this MySQL server
select user,password,host from user;
CREATE USER 'root'@'182.100.5.31' IDENTIFIED BY 'root';
查看我的权限
SHOW GRANTS FOR root@182.100.5.31;
+----------------------------------------------------------------------------------------------------------------+
| Grants for root@182.100.5.31 |
+----------------------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'root'@'182.100.5.31' IDENTIFIED BY PASSWORD '*81F5E21E35407D884A6CD4A731AEBFB6AF209E1B' |
+----------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

输出这个表示权限不足

GRANT ALL PRIVILEGES ON *.* TO 'root'@'182.100.5.31' IDENTIFIED BY 'root' WITH GRANT OPTION;
当我的机器重启后，IP发生变化，上面那样定死 IP 的做法就不可取了，执行下面的。

GRANT ALL PRIVILEGES ON *.* TO ''@'localhost' IDENTIFIED BY 'root' WITH GRANT OPTION;
增加权限后
+-------------------------------------------------------------------------------------------------------------------------------------------+
| Grants for root@182.100.5.31 |
+-------------------------------------------------------------------------------------------------------------------------------------------+
| GRANT ALL PRIVILEGES ON *.* TO 'root'@'182.100.5.31' IDENTIFIED BY PASSWORD '*81F5E21E35407D884A6CD4A731AEBFB6AF209E1B' WITH GRANT OPTION |
+-------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)
flush privileges;
没有答案 https://stackoverflow.com/questions/37153877/grant-all-privileges-to-all-users-on-a-host-in-mysql


### connect fail -- no route


修改 /etc/mysql/my.cnf
有这样一行
bind-address 127.0.0.1
注释掉就行了


