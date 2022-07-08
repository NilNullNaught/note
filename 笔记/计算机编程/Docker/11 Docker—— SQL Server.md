# 11	Docker—— SQL Server

## 11.1	配置 SQL Server 容器

##### 拉取 Sql Server 2017镜像

```shell
docker pull mcr.microsoft.com/mssql/server:2017-latest
```

<br>

##### 使用 docker 运行 容器镜像:

```shell
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=<YourStrong@Passw0rd>" \
   -p 1433:1433 --name sql1 -h sql1 \
   -d \
   mcr.microsoft.com/mssql/server:2017-latest
```

- 密码需求：密码应符合 SQL Server 默认密码策略，否则容器无法设置 SQL Server，将停止工作。 默认情况下，密码的长度必须至少为 8 个字符，并且必须包含以下四种字符中的三种：大写字母、小写字母、十进制数字和符号。 你可以通过执行 docker logs 命令检查错误日志。

<br>

##### 参数说明

| 参数                                           | 说明                                                         |
| :--------------------------------------------- | :----------------------------------------------------------- |
| **-e "ACCEPT_EULA=Y"**                         | 将 **ACCEPT_EULA** 变量设置为任意值，以确认接受 [最终用户许可协议](https://go.microsoft.com/fwlink/?linkid=857698)。 SQL Server 映像的必需设置。 |
| -e "SA_PASSWORD=<YourStrong@Passw0rd>"         | 指定至少包含 8 个字符且符合 [SQL Server 密码要求](https://docs.microsoft.com/zh-cn/sql/relational-databases/security/password-policy?view=sql-server-2017)的强密码。 SQL Server 映像的必需设置。 |
| **-p 1433:1433**                               | 将主机环境中的 TCP 端口（第一个值）映射到容器中的 TCP 端口（第二个值）。 在此示例中，SQL Server 侦听容器中的 TCP 1433，并对主机上的端口 1433 公开。 |
| **--name sql1**                                | 为容器指定一个自定义名称，而不是使用随机生成的名称。 如果运行多个容器，则无法重复使用相同的名称。 |
| -h sql1                                        | 用于显式设置容器主机名，如果不指定它，则默认为容器 ID，该 ID 是随机生成的系统 GUID。 |
| **-d**                                         | 在后台运行容器（守护程序）                                   |
| **mcr.microsoft.com/mssql/server:2017-latest** | SQL Server 2017 Linux 容器映像。                             |

<br>

##### 📌为 Sql Server 容器配置数据卷

如果不配置数据卷，容器被删除后，数据库中的数据将会丢失。

<br>

##### 📌Sql Server 对内存的需求

需要保证系统空闲内存在 1 GB 以上，否则容器启动会失败。

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>