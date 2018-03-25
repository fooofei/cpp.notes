### Docker 版本变迁
---
http://www.imooc.com/article/16906


### docker image 关系


![image](https://i.stack.imgur.com/vGuay.png)


from https://stackoverflow.com/questions/21498832/in-docker-whats-the-difference-between-a-container-and-an-image

### entrypoint

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

### docker rm
在 docker rmi 镜像之前，必须关闭移除所有这个镜像的 container

不管哪个镜像 全部都移除 container
```shell
$ docker stop $(docker ps -a -q)
$ docker rm $(docker ps -a -q)
```


### Host 与 Container 文件互通

把 Host 的文件做映射

```shell
$ docker run -v /:/docker_host  -it <id> bash
```
1、2个文件使用 docker cp 这种慢的方式



### docker pull connection reset

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

https://c.163.com/wiki/index.php?title=DockerHub%E9%95%9C%E5%83%8F%E5%8A%A0%E9%80%9F
sudo echo "DOCKER_OPTS=\"\$DOCKER_OPTS --registry-mirror=http://hub-mirror.c.163.com\"" >> /etc/default/docker
另一个 DOCKER_OPTS="--registry-mirror=https://docker.mirrors.ustc.edu.cn"
service docker restart

