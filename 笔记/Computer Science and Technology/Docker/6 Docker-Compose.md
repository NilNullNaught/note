# 6	Docker-Compose

## 6.1	Docker-Compose 概述

##### Docker-Compose 的作用

Docker Compose 可以基于 Compose 文件帮我们快速的部署分布式应用，而无需手动一个个创建和运行容器。其实 DockerCompose 文件可以看做是将多个 docker run 命令写到一个文件，只是语法稍有差异。

<br>

##### Compose 文件

Compose文件是一个文本文件，通过指令定义集群中的每个容器如何运行。

###### Compose 文件格式 —— 以一个 Java 项目为例

```
version: "3.8"
 services:
  mysql:
    image: mysql:5.7.25
    environment:
     MYSQL_ROOT_PASSWORD: 123 
    volumes:
     - "/tmp/mysql/data:/var/lib/mysql"
     - "/tmp/mysql/conf/hmy.cnf:/etc/mysql/conf.d/hmy.cnf"
  web:
    build: .
    ports:
     - "8090:8090"

```

上面的 Compose 文件描述了一个 Java 项目，其中包含两个容器：

- mysql：一个基于`mysql:5.7.25`镜像构建的容器，并且挂载了两个目录
- web：一个基于 `docker build` 临时构建的镜像容器，映射端口时8090

<br>

##### DockerCompose 的详细语法参考

https://docs.docker.com/compose/compose-file/

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>

## 6.2	安装 DockerCompose

##### CentOS7 环境下安装 DockerCompose

1. 通过命令下载 DockerCompose

```shell
# 安装
curl -L https://github.com/docker/compose/releases/download/1.23.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
```

2. 修改文件权限

```
# 修改权限
chmod +x /usr/local/bin/docker-compose
```

3. Base 自动补全命令

```shell
# 补全命令
curl -L https://raw.githubusercontent.com/docker/compose/1.29.1/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose

# 如果这一步出现错误，需要修改自己的 hosts 文件
echo "199.232.68.133 raw.githubusercontent.com" >> /etc/hosts
```

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>

## 6.3	部署微服务集群

##### 例 —— 使用 DockerCompose 部署微服务项目 cloud-demo

###### cloud-demo

此例中的 cloud-demo 已经编写好了 docker-compose 文件，而且每个微服务都准备了一个独立的目录。地址：！！！。

###### cloud-demo 根目录下的 Compose 文件内容

```yaml
version: "3.2"

services:
  nacos:
    image: nacos/nacos-server
    environment:
      MODE: standalone
    ports:
      - "8848:8848"
  mysql:
    image: mysql:5.7.25
    environment:
      MYSQL_ROOT_PASSWORD: 123
    volumes:
      - "$PWD/mysql/data:/var/lib/mysql"
      - "$PWD/mysql/conf:/etc/mysql/conf.d/"
  userservice:
    build: ./user-service
  orderservice:
    build: ./order-service
  gateway:
    build: ./gateway
    ports:
      - "10010:10010"
```

可以看到，其中包含5个service服务：

- `nacos`：作为注册中心和配置中心
  - `image: nacos/nacos-server`： 基于nacos/nacos-server镜像构建
  - `environment`：环境变量
    - `MODE: standalone`：单点模式启动
  - `ports`：端口映射，这里暴露了8848端口
- `mysql`：数据库
  - `image: mysql:5.7.25`：镜像版本是mysql:5.7.25
  - `environment`：环境变量
    - `MYSQL_ROOT_PASSWORD: 123`：设置数据库root账户的密码为123
  - `volumes`：数据卷挂载，这里挂载了mysql的data、conf目录，其中有我提前准备好的数据
- `userservice`、`orderservice`、`gateway`：都是基于Dockerfile临时构建的

###### mysql 目录下的 Compose 文件内容

查看 mysql 目录，可以看到其中已经准备好了cloud_order、cloud_user表：

![](img/6.3-1.png)

###### 各个微服务目录下的 Compose 文件内容

查看微服务目录，可以看到都包含Dockerfile文件：

![](img/6.3-2.png)

内容如下：

```dockerfile
FROM java:8-alpine
COPY ./app.jar /tmp/app.jar
ENTRYPOINT java -jar /tmp/app.jar
```

###### 步骤

1. 将我们的每个微服务都打包。因为之前查看到 Dockerfile 中的jar包名称都是app.jar，因此我们的每个微服务都需要用这个名称。可以通过修改pom.xml中的打包名称来实现，每个微服务都需要修改

```xml
<build>
  <!-- 服务打包的最终名称 -->
  <finalName>app</finalName>
  <plugins>
    <plugin>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-maven-plugin</artifactId>
    </plugin>
  </plugins>
</build>
```

打包后：

![](img/6.3-3.png)

2. 编译打包好的 app.ja r文件，需要放到 Dockerfile 的同级目录中。注意：每个微服务的 app.jar 放到与服务名称对应的目录。
3. 将整个 cloud-demo 文件夹上传到服务器中。
4. 进入cloud-demo目录，然后运行下面的命令

```shell
docker-compose up -d
```

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>