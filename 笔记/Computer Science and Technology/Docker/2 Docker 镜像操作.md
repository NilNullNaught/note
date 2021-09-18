# 2	Docker 镜像操作

## 2.1	镜像的名称组成

##### 镜像名称

镜像名称一般分两部分组成：`[repository]:[tag]`。

- 在没有指定tag时，默认是 latest，代表最新版本的镜像。

![](img/2.1-1.png)

这里的 mysql 就是 repository，5.7 就是 tag，合一起就是镜像名称，代表 5.7 版本的 MySQL 镜像。

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>

## 2.2	镜像命令

### 2.2.1		常见的镜像操作命令

##### 常见的镜像操作命令如图

<img src="img/2.2.1-1.png" style="zoom: 25%;" />

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>

## 2.2.2	搜索镜像

##### 方式一

在 https://hub.docker.com/ 中搜索镜像。

<br>

##### 方式二

使用 docker search 命令

```
docker search [镜像名]
```

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>

### 2.2.3	拉取、查看镜像

##### 拉取镜像

```cmd
#拉取最新版本的镜像
docker pull [镜像名]

#通过 tag 指定拉取镜像的版本
docker pull [镜像名]:tag
```

<br>

##### 查看所有已安装的镜像

```cmd
docker images
```

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>

### 2.2.4	保存、导入镜像

##### 导出镜像到磁盘 

```cmd
docker save -o [保存的目标文件名称] [镜像名称]
```

<br>

##### 加载磁盘上的镜像文件

```cmd
#需要先删除同名镜像
docker load -i [镜像文件名] #镜像文件名示例：nginx.tar
```

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>

### 2.2.5	删除镜像

##### 删除镜像

```cmd
docker rmi [镜像名]			从 Docker 中删除指定镜像
docker rmi -f [镜像名]			从 Docker 中强制删除指定镜像
docker rmi -f [镜像1]	[镜像2] 	从 Docker 中强制删除指定的多个镜像
```

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>