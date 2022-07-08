# 1	概述

##### 1.1	Canal

##### Cannal 简介

Cannal 的主要用途是基于 MySQL 数据库增量日志解析，提供增量数据订阅和消费。

基于日志增量订阅和消费的业务包括

- 数据库镜像
- 数据库实时备份
- 索引构建和实时维护(拆分异构索引、倒排索引等)
- 业务 cache 刷新
- 带业务逻辑的增量数据处理

当前的 canal 支持源端 MySQL 版本包括 5.1.x , 5.5.x , 5.6.x , 5.7.x , 8.0.x

<br>

##### canal 各版本之间的区别

###### canal.example

demo 工程。

###### canal.admin

canal-admin设计上是为canal提供整体配置管理、节点运维等面向运维的功能，提供相对友好的WebUI操作界面，方便更多用户快速和安全的操作
canal-admin。

###### canal-adapter

增加客户端数据落地的适配及启动功能(支持HBase等)

###### canal-deployer

相当于 canal 的服务端，启动它才可以在客户端接收数据库变更信息。

<br>

----

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>
## 1.2	在 Linux 上部署 Canal

##### 官方文档

https://github.com/alibaba/canal/wiki/QuickStart

<br>

##### 在 Linux 上进行部署

###### 1 - 下载 canal.deployer 并上传到 Linux 服务器上

下载地址：https://github.com/alibaba/canal/releases，或

```
wget https://github.com/alibaba/canal/releases/download/canal-1.0.17/canal.deployer-1.0.17.tar.gz
```

###### 2 - 创建文件夹 canal ，解压到 canal 文件夹中，并将 /canal 移动到 /usr/local 目录下

canal 解压后无文件夹，需要创建文件夹

```
mkdir canal
mv canal.deployer-1.1.5.tar.gz canal
```

```
tar -zxvf canal.deployer-1.1.5.tar.gz
```

```
mv canal /usr/local/
```

###### 3 - 开启 mysql 的 binlog 写入功能

canal 的实现是基于 mysql binlog 技术，需要在 MySQL 的 my.cnf 中进行如下配置：（建议配置 binlog 模式为 row）

```
[mysqld]
log-bin=mysql-bin #添加该行即可
binlog-format=ROW #选择row模式
server_id=1 #配置 mysql replaction 需要定义，不能和 canal 的 slaveId 重复
```

<br>

###### 4 - 配置修改

```
vi conf/example/instance.properties
```

```
#需要改成自己的数据库信息
canal.instance.master.address=192.168.44.132:3306

#需要改成自己的数据库用户名与密码

canal.instance.dbUsername=canal
canal.instance.dbPassword=canal

#白名单,如 test\..* 只监听test数据库,test\.test监控test库里的test表,多个的话用逗号隔开
#但是注意【这个配置会被客户端 subscribe 方法中的规则覆盖】
canal.instance.filter.regex = .\.. 这个是
#是黑名单,排除库表,配置同上,这个配置有效
canal.instance.filter.black.regex = 这个
```

###### 5 - 启动

```
sh /usr/local/canal/bin/startup.sh
```

###### 查看 server 日志

```
vi logs/canal/canal.log</pre>
```

<br>

##### 配置 ElasticSearch 适配器，并实现同步

###### 1 - 下载 Canal.adapter

https://github.com/alibaba/canal/releases/tag/canal-1.1.5

###### 2 - 

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>
##### 解决： Canal 无法使用 JDK 8.0 以上版本启动

https://blog.csdn.net/libizhide/article/details/109555562



# 📌为什么不使用 Canal 实现数据同步

##### 理由

1. Canal 版本更新速度慢（Canal 每个版本的更新间隔接近一年，且 Canal-1.1.5 仅支持 JDK 8，如果使用其他版本的 JDK 则需要修改启动参数）。
2. Canal 配置复杂，对于特殊的更新规则需要修改源代码进行定制。
3. Canal 对全量更新的支持不全面。
4. 有众多没有解决的未知错误。

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>
