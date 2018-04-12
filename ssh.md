### 配置 SSH key 登陆方式

---

```shell
  ssh-keygen   / ssh-keygen -t rsa
  [enter]
  [enter]
  [enter]

  ssh-copy-id username@host
```

#### 可能的错误

```shell
  ssh-copy-id no identities found error
```

  解决

```
  cd ~/.ssh
  ssh-copy-id -i id_rsa.pub USERNAME@SERVERTARGET
```

  继续报错

```
  /usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed

  /usr/bin/ssh-copy-id: ERROR: ssh: connect to host xxx port 22: Connection timed out
```

  手动解决

```
  on A:
  # cat ~/.ssh/id_rsa.pub

  复制上述输出
  on B:
  cd ~/.ssh
  # vim authorized_keys
  粘贴 保存即可
```

### SSH 超时自动登出

---

```shell
 timed out waiting for input: auto-logout
```

#### 无效的解决

```
  vim ~/.ssh/config
  ServerAliveInterval =30
```

  后来把 

  `vim /etc/ssh/sshd_config` 中的 `ServerAliveInterval` 屏蔽掉

  依旧无效

#### 有效的解决

```
  # vim /etc/profile
  #export TMOUT=300   # 注释掉

  并且在 ssh 登陆增加参数
  ssh -o ServerAliveInterval=30 root@x.x.x.x
```
