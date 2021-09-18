# 10	Docker —— Mysql

## 10.1	配置 Mysql 容器

##### 基本命令

```php
docker run -itd --name [自定义的容器名称] -p 3306:3306 -e MYSQL_ROOT_PASSWORD=PASSWORDis1024 [镜像名称]
```

<br>

##### 使用 -v 参数配置 Mysql 容器

###### 通过映射本地目录到容器将 MySQL 数据存储在本地目录

示例：

```shell
$ docker run -d -e MYSQL_ROOT_PASSWORD=admin --name mysql -v /data/mysql/data:/var/lib/mysql -p 3306:3306 mysql 
```

###### 指定 Mysql 配置文件

示例：

```shell
docker run -d -e MYSQL_ROOT_PASSWORD=admin --name mysql -v /data/mysql/my.cnf:/etc/mysql/my.cnf -v /data/mysql/data:/var/lib/mysql -p 3306:3306 mysql 
```

<br>

##### ⚡通用 Mysql 容器配置命令

```shell
docker run -itd \
--name mysqlcontainer1	\ #设置容器名
-v /my/custom:/etc/mysql/conf.d  \ #/my/custom/config-file.cnf 配置文件地址
-v /my/own/datadir:/var/lib/mysql \#/my/own/datadir 数据存储目录
-p 3306:3306	\ #设置容器端口
-e MYSQL_ROOT_PASSWORD=PASSWORDis1024	\ #设置 root 用户密码
centos/mysql-57-centos7	\ #使用的镜像
```

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>
