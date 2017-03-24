
* docker pull reset 
question:
```shell
$ docker pull ubuntu:16.04
Trying to pull repository docker.io/library/ubuntu ... 
Get https://registry-1.docker.io/v2/library/ubuntu/manifests/sha256:dd7808d8792c9841d0b460122f1acf0a2dd1f56404f8d1e56298048885e45535: Get https://auth.docker.io/token?scope=repository%3Alibrary%2Fubuntu%3Apull&service=registry.docker.io: read tcp *.*.*.*:41348->50.17.62.194:443: read: connection reset by peer
```
answer:
```
dig auth.docker.io
更改 /etc/hosts 添加为其他可用 ip
34.193.147.40 registry-1.docker.io auth.docker.io
```

* 创建 centos5 docker from dockerfile
```shell
down files from https://github.com/CentOS/sig-cloud-instance-images/tree/2d0554464ae19f4fd70d1b540c8968dbe872797b/docker
在该目录执行 
sudo docker build -t "centos5_x85_x64:v1" .  #双引号中是镜像的名字，是自定义的
```
另一个方法
```
$ docker pull centos:5.11

接着启动
$ docker run -i -t centos:5.11 会报错
docker: Error response from daemon: No command specified.
因为 centos 启动需要加 bash 参数， ubuntu 就不需要。
参考 http://www.jianshu.com/p/b34dbb643a70

这下就行了
docker run -i -t centos:5.11 /bin/bash

```

* 镜像加速
```
https://c.163.com/wiki/index.php?title=DockerHub%E9%95%9C%E5%83%8F%E5%8A%A0%E9%80%9F
sudo echo "DOCKER_OPTS=\"\$DOCKER_OPTS --registry-mirror=http://hub-mirror.c.163.com\"" >> /etc/default/docker
另一个 DOCKER_OPTS="--registry-mirror=https://docker.mirrors.ustc.edu.cn"
service docker restart
```