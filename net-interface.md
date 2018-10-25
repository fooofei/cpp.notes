
# CentOS interface


### add ip for interface

`ifconfig enp130s0f0 4.1.88.99/24`


### remove ip for interface

`ifconfig enp130s0f0 0.0.0.0`

`ifconfig enp130s0f0 del 4.1.88.99`  not work



### add gateway 

`route add default gw <gateway ip>`

add to file `vi /etc/sysconfig/network-scripts/ifcfg-enp1s0f0`

```
BOOTPROTO=static
ONBOOT=yes
IPADDR=4.1.88.41
NETMASK=255.255.255.0
GATEWAY=4.1.88.1
```
should `systemctl restart network` to be valid


### down interface 

`ifconfig enp130s0f0 down`

down 之后在交换机上 `[Quidway]display interface brief` 能看到与这个 interface 直连的接口 `down` 了


### add route

`route add 192.140.0.0 mask 255.255.255.0 192.145.1.4`
`route add -net 192.140.0.0/24 gw 192.145.1.4`

### remove route

`route delete 192.140.0.0 `
`route del -net 192.150.0.0/24`

### show route

`ip route show | column -t`
`route -n`

