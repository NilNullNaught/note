# 1	概述



---

<br>

## 1.2	安装 Docker

### 1.2.1	在 Linux 环境下安装 Docker

使用官方安装脚本自动安装：

```shell
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
```

---

<br>

# 2	基本命令

## 2.1	启动和关闭docker

**启动 docker 命令：**

```shell
systemctl start docker
```

**关闭 docker：**

```shell
systemctl stop docker
```

**重新启动 docker：**

```shell
service docker restart
```

**设置 docker 开机自启动：**

```shell
systemctl enable docker
```

---

<br>

## 2.2	                      

查看docker的版本信息

```shell
docker version
```

查看Docker的系统信息

```shell
docker info 
```

---

<br>

## 2.3	镜像命令

**查看所有已安装的镜像：**

```shell
docker images

docker images -a			#列出本地所有的镜像
docker images -p			#只显示镜像ID
docker images --digests		#显示镜像的摘要信息
docker images --no-trunc	#显示完整的镜像信息
```

**从 Docker Hub 上查找镜像：**

```shell
docker search [镜像名]
```

**拉取镜像：**

```shell
docker pull [镜像名]

//通过 tag 指定拉取镜像的版本，可以通过 last 指定为当前最新版本
docker pull [镜像名]:tag
```

**删除镜像：**

```shell
docker rmi hello-world				从Docker中删除hello-world镜像
docker rmi -f hello-world			从Docker中强制删除hello-world镜像
docker rmi -f hello-world nginx		从Docker中强制删除hello-world镜像和nginx镜像
```

---

<br>

## 2.4	容器命令

### 2.4.1	查看容器信息

**查看运行中的容器：**

```shell
docker ps
```

查看所有容器信息，包括未运行的容器

```shell
docker ps -a
```

---

<br>

### 2.4.2	运行容器

**运行容器：**

```
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
```

##### docker 参数列表

| 参数 | 说明                                               |
| ---- | -------------------------------------------------- |
| `-i` | 以交互模式运行容器，通常与 -t 同时使用；           |
| `-t` | 为容器重新分配一个伪输入终端，通常与 -i 同时使用； |
| -p   | 指定端口映射，格式为：主机(宿主)端口:容器端口      |

-a stdin: 指定标准输入输出内容类型，可选 STDIN/STDOUT/STDERR 三项；

-d: 后台运行容器，并返回容器ID；

-P: 随机端口映射，容器内部端口随机映射到主机的端口

--name="nginx-lb": 为容器指定一个名称；

--dns 8.8.8.8: 指定容器使用的DNS服务器，默认和宿主一致；

--dns-search example.com: 指定容器DNS搜索域名，默认和宿主一致；

-h "mars": 指定容器的hostname；

-e username="ritchie": 设置环境变量；

--env-file=[]: 从指定文件读入环境变量；

--cpuset="0-2" or --cpuset="0,1,2": 绑定容器到指定CPU运行；

-m :设置容器使用内存最大值；

--net="bridge": 指定容器的网络连接类型，支持 bridge/host/none/container: 四种类型；

--link=[]: 添加链接到另一个容器；

--expose=[]: 开放一个端口或一组端口；

--volume , -v: 绑定一个卷

---

<br>

### 2.4.3	容器操作

##### 关闭容器：

```shell
docker stop [容器ID/容器名]
```

##### 强制关闭容器

```shell
docker kill [容器ID/容器名]
```

##### 启动容器

```shell
docker start [容器ID/容器名]
```

- 建议使用容器ID，容器ID支持模糊查询而容器名称不支持

##### 重启容器

```shell
docker restart [容器ID/容器名]
```

##### 设置容器自动启动

- 对于未运行过的容器，可以在启动时添加参数 `--restart=always`。

- 对于已经运行过的容器，使用 docker update 命令：

  ```shell
  docker update --restart=always [容器ID/容器名]
  ```

##### 删除容器

```shell
docker rm [容器ID/容器名]
```

---

<br>

# 3	具体操作

## 3.1	配置 Mysql 容器

##### 基本命令

```php
docker run -itd --name [自定义的容器名称] -p 3306:3306 -e MYSQL_ROOT_PASSWORD=PASSWORDis1024 [镜像名称]
```

##### 使用 -v 参数配置 Mysql 容器

- 通过映射本地目录到容器将 MySQL 数据存储在本地目录，例：

  ```shell
  $ docker run -d -e MYSQL_ROOT_PASSWORD=admin --name mysql -v /data/mysql/data:/var/lib/mysql -p 3306:3306 mysql 
  ```

- 指定 Mysql 配置文件，例：

  ```shell
  docker run -d -e MYSQL_ROOT_PASSWORD=admin --name mysql -v /data/mysql/my.cnf:/etc/mysql/my.cnf -v /data/mysql/data:/var/lib/mysql -p 3306:3306 mysql 
  ```

- 📌**注意**：

  - -v 参数可以多次使用，每次映射一个目录

##### 📌通用 Mysql 容器配置命令

```shell
docker run -itd \
--name mysqlcontainer1	\ #设置容器名
-p 3306:3306	\ #设置容器端口
-e MYSQL_ROOT_PASSWORD=PASSWORDis1024	\ #设置 root 用户密码
centos/mysql-57-centos7	\ #使用的镜像
```



---

<br>

## 3.2	配置 SQL Server 容器

**参考：**

- [在 docker 环境下安装 sqlserver 2017](https://docs.microsoft.com/zh-cn/sql/linux/quickstart-install-connect-docker?view=sql-server-2017&preserve-view=true&pivots=cs1-bash)

**拉取 Sql Server 2017镜像：**

```shell
docker pull mcr.microsoft.com/mssql/server:2017-latest
```

**使用 docker 运行 容器镜像:**

```shell
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=<YourStrong@Passw0rd>" \
   -p 1433:1433 --name sql1 -h sql1 \
   -d \
   mcr.microsoft.com/mssql/server:2017-latest
```

- 密码应符合 SQL Server 默认密码策略，否则容器无法设置 SQL Server，将停止工作。 默认情况下，密码的长度必须至少为 8 个字符，并且必须包含以下四种字符中的三种：大写字母、小写字母、十进制数字和符号。 你可以通过执行 docker logs 命令检查错误日志。

- docker run 参数说明：

  | 参数                                           | 说明                                                         |
  | :--------------------------------------------- | :----------------------------------------------------------- |
  | **-e "ACCEPT_EULA=Y"**                         | 将 **ACCEPT_EULA** 变量设置为任意值，以确认接受 [最终用户许可协议](https://go.microsoft.com/fwlink/?linkid=857698)。 SQL Server 映像的必需设置。 |
  | -e "SA_PASSWORD=<YourStrong@Passw0rd>"         | 指定至少包含 8 个字符且符合 [SQL Server 密码要求](https://docs.microsoft.com/zh-cn/sql/relational-databases/security/password-policy?view=sql-server-2017)的强密码。 SQL Server 映像的必需设置。 |
  | **-p 1433:1433**                               | 将主机环境中的 TCP 端口（第一个值）映射到容器中的 TCP 端口（第二个值）。 在此示例中，SQL Server 侦听容器中的 TCP 1433，并对主机上的端口 1433 公开。 |
  | **--name sql1**                                | 为容器指定一个自定义名称，而不是使用随机生成的名称。 如果运行多个容器，则无法重复使用相同的名称。 |
  | -h sql1                                        | 用于显式设置容器主机名，如果不指定它，则默认为容器 ID，该 ID 是随机生成的系统 GUID。 |
  | **-d**                                         | 在后台运行容器（守护程序）                                   |
  | **mcr.microsoft.com/mssql/server:2017-latest** | SQL Server 2017 Linux 容器映像。                             |

**注意：**

- 在 docker 上创建的数据库容器在被删除之后，有可能会导致数据库中的所有数据 **全部丢失**，但是可以通过参数指定数据库文件在硬盘上的保存位置！根据 Docker 官方容器使用技巧，不要将数据存储在 docker 中！

---

<br>

# 附录

##### 最后编辑时间

- 2021/03/06

##### 环境

- centOS 7.3
- docker  20.10.3

##### 参考

- [docker 教材|菜鸟教程](https://www.runoob.com/docker/docker-tutorial.html)

##### 相关资料

- 

##### 脚注

[^xxx]: 

##### 代码链接

[1]:

##### 锚点

[](#1) 

##### 质疑

[^!1]: 

##### 疑问

[^?1]: 
