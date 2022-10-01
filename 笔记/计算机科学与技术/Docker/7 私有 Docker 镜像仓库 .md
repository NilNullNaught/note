# 7	私有 Docker 镜像仓库 

## 7.1	搭建私有镜像仓库

##### DockerRegistry

搭建镜像仓库可以基于 Docker 官方提供的 DockerRegistry 来实现。官网地址：https://hub.docker.com/_/registry。

<br>

##### 搭建简化版的镜像仓库

Docker 官方的 Docker Registry 是一个基础版本的 Docker 镜像仓库，具备仓库管理的完整功能，但是没有图形化界面。

搭建方式比较简单，命令如下：

```shell
docker run -d \
    --restart=always \
    --name registry	\
    -p 5000:5000 \
    -v registry-data:/var/lib/registry \
    registry
```

<br>

##### 搭建带有图形化界面的镜像仓库

使用 DockerCompose 部署带有图象界面的 DockerRegistry，命令如下：

```yaml
version: '3.0'
services:
  registry:
    image: registry
    volumes:
      - ./registry-data:/var/lib/registry
  ui:
    image: joxit/docker-registry-ui:static
    ports:
      - 8080:80
    environment:
      - REGISTRY_TITLE=传智教育私有仓库
      - REGISTRY_URL=http://registry:5000
    depends_on:
      - registry
```

<br>

##### 配置Docker信任地址

由于私服采用的是 http 协议，默认不被 Docker 信任，所以需要做一个配置：

```sh
# 打开要修改的文件
vi /etc/docker/daemon.json
# 添加内容：
"insecure-registries":["http://192.168.150.101:8080"]
# 重加载
systemctl daemon-reload
# 重启docker
systemctl restart docker
```

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>

## 5.2.推送、拉取镜像

##### 步骤

推送镜像到私有镜像服务必须先tag，步骤如下：

1.  重新tag本地镜像，名称前缀为私有仓库的地址：192.168.150.101:8080/

 ```sh
docker tag nginx:latest 192.168.150.101:8080/nginx:1.0 
 ```

2. 推送镜像

```sh
docker push 192.168.150.101:8080/nginx:1.0 
```

3.  拉取镜像

```sh
docker pull 192.168.150.101:8080/nginx:1.0 
```

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>