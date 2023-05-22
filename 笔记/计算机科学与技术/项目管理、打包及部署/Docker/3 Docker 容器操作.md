# 3	Docker 容器操作

## 3.1	容器相关命令

##### 容器操作相关命令如图

![](img/3.1-1.png)

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>

## 3.2	容器状态

##### 容器的三种状态

- 运行：进程正常运行
- 暂停：进程暂停，CPU不再运行，并不释放内存
- 停止：进程终止，回收进程占用的内存、CPU等资源

<br>

##### 查看运行中的容器信息

```shell
docker ps
```

<br>

##### 查看所有容器信息，包括未运行的容器

```shell
docker ps -a
```

<br>

##### 启动容器

```shell
docker start [容器ID/容器名]
```

- 建议使用容器ID，容器ID支持模糊查询而容器名称不支持

<br>

##### 让一个运行的容器暂停

```shell
docker pause [容器ID/容器名]
```

<br>

##### 让一个容器从暂停状态恢复运行

```
docker unpause [容器ID/容器名]
```

<br>

##### 关闭容器：

```shell
docker stop [容器ID/容器名]
```

<br>

##### 强制关闭容器

```shell
docker kill [容器ID/容器名]
```

<br>

##### 重启容器

```shell
docker restart [容器ID/容器名]
```

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>

## 3.3	创建并运行容器

##### 创建并运行容器命令

```cmd
docker run --name [容器名] -p [宿主机端口]:[容器端口][OPTIONS] -d [镜像名称]
```

命令解读：

- docker run ：创建并运行一个容器
- --name : 给容器起一个名字，比如叫做 mn
- -p ：将宿主机端口与容器端口映射，冒号左侧是宿主机端口，右侧是容器端口
- -d：后台运行容器
- [镜像名称]：镜像名称，例如 nginx

<br>

##### -p 参数

`-p` 参数，将容器端口映射到宿主机端口。默认情况下，容器是隔离环境，我们直接访问宿主机的端口，无法访问到容器的内部。现在，将容器的端口与宿主机的端口关联起来，当我们访问宿主机的端口时，就会被映射到容器的端口，这样就能访问到容器的内部了。

![](img/3.2-1.png)

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>

## 3.4	进入容器，修改文件

##### 进入容器命令

```
docker exec -it [容器名] bash
```

命令解读：

- docker exec ：进入容器内部，执行一个命令
- -it : 给当前进入的容器创建一个标准输入、输出终端，允许我们与容器交互
- mn ：要进入的容器的名称
- bash：进入容器后执行的命令，bash是一个linux终端交互命令

<br>

##### 使用 sed 命令修改容器内的文件

容器内无法使用 vi 命令，无法直接修改文件内容，需要使用如下命令：

```cmd
sed -i -e 's#[原内容]#[替换内容]#g' \
	   -e 's#[原内容]#[替换内容]#g' \
	   [需要修改文件的文件名]
```

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>

## 3.5	删除容器

##### 删除容器

```shell
docker rm [容器ID/容器名]
```

- 需要先停止容器，再进行删除，如果没有为容器创建数据卷，那么容器的所有数据会全部丢失。

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>

## 3.6	容器开机自启动

##### 📌设置容器开机自动启动

###### 前提

需要将 Docker 设置为开机自启动。

###### 实现

- 对于未运行过的容器，可以在启动时添加参数 `--restart=always`。

- 对于已经运行过的容器，使用 docker update 命令：

```
docker update --restart=always [容器ID/容器名]
```

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>

## 3.7	查看容器日志

##### 查看容器日志的命令

```shell
docker logs [容器ID/容器名]
```

- 添加 `-f` 参数可以持续查看日志

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>