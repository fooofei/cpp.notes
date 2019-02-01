### Docker gdb attach

container 中运行进程 test，宿主机为 A，一台 Windows 办公机器有 test 代码，能 ssh A，

通过 VisualStudio gdb 无法加断点，test 在A上运行，VS远程断点都正常。

尝试在 docker run 后面加 `--privileged --cap-add=SYS_PTRACE --security-opt seccomp=unconfined `

都无效。


### Docker 版本变迁
---
http://www.imooc.com/article/16906

suse 的 docker 叫 suse/sles11sp3:latest   https://github.com/SUSE/sle2docker

The new docker name is `Docker CE`, old name is `Docker` or `Docker Engine`.

[CentOS 安装 Docker CE] https://yeasy.gitbooks.io/docker_practice/content/install/centos.html


### docker proxy

修改 `/lib/systemd/system/docker.service`

`[service]` 下
`EnvironmentFile=-/etc/sysconfig/docker`

创建或修改 `/etc/sysconfig/docker`

`HTTP_PROXY=http://localhost:3128/`
`HTTPS_PROXY=http://localhost:3128/`
`NO_PROXY=localhost,127.0.0.1,internal-docker-registry.somecorporation.com`
`export HTTP_PROXY HTTPS_PROXY NO_PROXY`
 
刷新配置,使代理生效
`systemctl daemon-reload`   # 这一步必须

`systemctl restart docker`
 

### docker start

如何在 docker restart 前在 host 上固定执行几个命令？

如何在 dockerfile 里 mount ？


### docker image 关系
---

![image](https://i.stack.imgur.com/vGuay.png)


from https://stackoverflow.com/questions/21498832/in-docker-whats-the-difference-between-a-container-and-an-image

### entrypoint
---
20180316

今天尝试了 
`docker run --entrypoint /usr/bin/python /home/test.py` 
`docker run --entrypoint "/usr/bin/python /home/test.py"`
`docker run --entrypoint="/usr/bin/python /home/test.py"`
都是错误的，提示 Cannot exec 


### 导入导出
---
```shell
$ docker export <container_id> > <tar package>

$ docker import <tar package> <tag name>
<tag name> = <repo>:<tag>
```

```shell
$ docker save <image id> > <tar package>

$ docker load < <tar package>
$ docker load -i <tar package>
```

两种导入包的方式
```
1 Use shell 
docker import 1.tar os:import

2  Use Dockerfile
FROM scratch 
ADD xxx.tar.xz /
```

从 macOS export 的包，到 linux 使用 ，import 没问题，但是运行 container 出错
[root@localhost testing]# docker run -it --name=temp centos:python bash
docker: Error response from daemon: oci runtime error: container_linux.go:265: starting container process caused "exec: \"bash\": executable file not found in $PATH".

[root@localhost testing]# docker run -it --name=temp centos:python sh
docker: Error response from daemon: oci runtime error: container_linux.go:265: starting container process caused "exec: \"sh\": executable file not found in $PATH".

export import 使用还是有局限

docker save on macOS, docker load on linux, error :
on macOS:
$ docker save centos:7_make_gcc_gdb_python > centos_p.tar

[root@localhost testing]# docker load < centos_p.tar.gz 
open /var/lib/docker/tmp/docker-import-308524309/repositories: no such file or directory
非 gz 文件也不行
[root@localhost testing]# docker load < centos_p.tar 
open /var/lib/docker/tmp/docker-import-918895631/repositories: no such file or directory

### docker rm
---
在 docker rmi 镜像之前，必须关闭移除所有这个镜像的 container

不管哪个镜像 全部都移除 container
```shell
$ docker stop $(docker ps -a -q)
$ docker rm $(docker ps -a -q)
```


### Host 与 Container 文件互通
---
把 Host 的文件做映射

```shell
$ docker run -v /:/docker_host  -it <id> bash
```
1、2个文件使用 docker cp 这种慢的方式 $ docker cp /bin/gdb sensor:/bin/
 暂时还不知道 带不带尾部的 / 有什么区别



### docker pull connection reset
---
```shell
$ docker pull ubuntu:16.04
Trying to pull repository docker.io/library/ubuntu ... 
Get https://registry-1.docker.io/v2/library/ubuntu/manifests/sha256:dd7808d8792c9841d0b460122f1acf0a2dd1f56404f8d1e56298048885e45535: Get https://auth.docker.io/token?scope=repository%3Alibrary%2Fubuntu%3Apull&service=registry.docker.io: read tcp *.*.*.*:41348->50.17.62.194:443: read: connection reset by peer
```
answer:
dig auth.docker.io
更改 /etc/hosts 添加为其他可用 ip
34.193.147.40 registry-1.docker.io auth.docker.io

### 镜像加速
---
https://c.163.com/wiki/index.php?title=DockerHub%E9%95%9C%E5%83%8F%E5%8A%A0%E9%80%9F
sudo echo "DOCKER_OPTS=\"\$DOCKER_OPTS --registry-mirror=http://hub-mirror.c.163.com\"" >> /etc/default/docker
另一个 DOCKER_OPTS="--registry-mirror=https://docker.mirrors.ustc.edu.cn"
service docker restart


### 容器磁盘占用空间

`docker ps -s`
