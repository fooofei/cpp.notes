

### basic commands

```
# systemctl status <>
# systemctl start <>
# systemctl stop <>
# systemctl enable <>
# systemctl disable <>
```

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