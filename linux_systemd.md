

### basic commands

```
# systemctl status <>
# systemctl start <>
# systemctl stop <>
# systemctl enable <>
# systemctl disable <>
```

在某些系统 `systemctl status <>` 给出的状态没 memory 这一项，

按照  https://github.com/ingvagabund/articles/blob/master/cpu-and-memory-accounting-for-systemd.md 配置，

有效果，但是大小不对，预期显示 12GB， 实际显示 0KB。暂时没找到解决方案。

在能按照预期显示的系统上，检查 MemoryAccounting 同样是 no。所以这个属性不是决定性作用。

### See unit stdout 
```
# journalctl -u <unit>

```

### See unit realtime stdout

```
# journalctl -f -u <unit>
```

### See stdout by UTC time

```
# journalctl --utc
```

### See systemd top

```
# systemd-cgtop
```