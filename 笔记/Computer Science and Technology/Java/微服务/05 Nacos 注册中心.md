# 5	Nacos 注册中心

## 5.1	Nacos 概述

##### Nacos 简介

Nacos 由阿里巴巴出品，是 Spring Cloud Alibaba 的注册中心组件。相比 Eureka 功能更加丰富，在国内受欢迎程度较高。Nacos 是Spring Cloud Alibaba的组件，而 Spring Cloud Alibaba 也遵循 Spring Cloud 中定义的服务注册、服务发现规范。因此使用 Nacos 和使用 Eureka 对于微服务来说，并没有太大区别。

<br>

##### Nacos 与 Eureka 之间的异同

###### 共同点

- 都支持服务注册和服务拉取；
- 都支持服务提供者心跳方式做健康检测。

###### 区别

- Nacos 支持服务端主动检测提供者状态：临时实例采用心跳模式，非临时实例采用主动检测模式；
- 临时实例心跳不正常会被剔除，非临时实例则不会被剔除；
- Nacos 支持服务列表变更的消息推送模式，服务列表更新更及时；
- Nacos 集群默认采用 AP 方式，当集群中存在非临时实例时，采用 CP 模式；Eureka 采用 AP 方式。

<br>

##### Nacos 官方文档

https://nacos.io/zh-cn/

<br>

##### Nacos GitHub 主页

https://github.com/alibaba/nacos

<br>

##### Nacos GitHub Release 下载页

https://github.com/alibaba/nacos/releases

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br>
</div>

## 5.2	安装 Nacos

##### Windows 平台

###### 下载与解压

1. 在 https://github.com/alibaba/nacos/releases 选择适当的版本下载
2. 将下载后的安装包解压到任意非中文目录下

###### 目录结构

![](img/5.2-1.png)

- **bin**：启动脚本
- **conf**：配置文件

###### 端口配置

Nacos 的默认端口是 8848，如果你电脑上的其它进程占用了 8848 端口，请先尝试关闭该进程。

如果需要修改 Nacos 的默认端口，可以在 conf/application.properties  文件中进行修改。

![](img/5.2-2.png)

<img src="img/5.2-4.png" style="zoom:50%;" />

###### 启动

进入 bin 目录，在 bin 目录下打开 cmd 窗口，输入：

```shell
startup.cmd -m standalone
```

<img src="img/5.2-5.png" alt="nacos 启动成功效果" style="zoom:50%;" />

###### 访问

在浏览器重输入地址 http://127.0.0.1:8848/nacos：

<img src="img/5.2-6.png" alt="image-20210914201438766" style="zoom:50%;" />

默认账号-密码为：`nacos-nacos`。

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br>
</div>

## 5.3	在项目中引入 Nacos

##### 步骤

1. 在项目父工程的 pom.xml 文件中引入 Spring Cloud Alibaba 依赖：

   ```xml
   <dependency>
       <groupId>com.alibaba.cloud</groupId>
       <artifactId>spring-cloud-alibaba-dependencies</artifactId>
       <version>2.2.6.RELEASE</version>
       <type>pom</type>
       <scope>import</scope>
   </dependency>
   ```

2. 在微服务模块的 pom.xml 文件中引入 nacos-discovery：

   ```xml
   <!-- 引入这段依赖之前必须先将 Eureka 依赖  -->
   <dependency>
       <groupId>com.alibaba.cloud</groupId>
       <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
   </dependency>
   ```

3. 在微服务模块的 application.yml 文件中添加 nacos 配置

   ```php
   spring:
     cloud:
       nacos:
         server-addr: localhost:8848
   ```

4. 重启微服务

   <br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br>
</div>

## 5.4	Nacos 服务分级存储模型

##### 服务分级存储模型

一个 **服务** 可以有多个 **实例**，假如这些实例分布于全国各地的不同机房，Nacos 可以将同一机房内的实例划分为一个**集群**。

![](img/5.4-1.png)

<br>

##### 微服务互相访问时应尽可能访问同集群实例

微服务互相访问时，应该尽可能访问同集群实例，因为本地访问速度更快。当本集群内不可用时，才访问其它集群。

<img src="img/5.4-2.png" style="zoom:50%;" />

<br>

##### 为微服务模块配置集群

1. 修改微服务模块的 application.yml 文件，添加集群配置：

   ```yaml
   spring:
     cloud:
       nacos:
         server-addr: localhost:8848
         discovery:
           cluster-name: HZ # 集群名称
   ```

2. 创建一个新的实例，添加属性：

   ```
   -Dserver.port=8084 -Dspring.cloud.nacos.discovery.cluster-name=SH
   ```

3. 启动所有实例后查看控制台：

   <img src="img/5.4-3.png" style="zoom:50%;" />

<br>

##### 设置同集群优先的负载均衡

默认的`ZoneAvoidanceRule`并不能实现根据同集群优先来实现负载均衡。因此 Nacos 提供了一个 `NacosRule` 的实现，可以优先从同集群中挑选实例。

###### 步骤

1. 为微服务模块配置集群信息

2. 修改微服务模块的 application.ym l文件，修改负载均衡规则：

   ```php
   userservice:
     ribbon:
       NFLoadBalancerRuleClassName: com.alibaba.cloud.nacos.ribbon.NacosRule # 负载均衡规则 
   ```

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br>
</div>

## 5.5	权重配置

##### 能者多劳

实际部署中会出现这样的场景——服务器设备性能有差异，部分实例所在机器性能较好，另一些较差，我们希望性能好的机器承担更多的用户请求。但默认情况下 NacosRule 是同集群内随机挑选，不会考虑机器的性能问题。

因此，Nacos 提供了权重配置来控制访问频率，权重越大则访问频率越高。

<br>

##### 修改实例权重

1. 通过 Nacos 控制台的服务列表查找对应的服务，进入详情页面。

   <img src="img/5.5-1.png" style="zoom:50%;" />

2. 选择需要修改的实例，点击编辑按钮。

   <img src="img/5.5-2.png" style="zoom:50%;" />

3. 对权重进行编辑。

   <img src="img/5.5-3.png" style="zoom:50%;" />

<br>

##### 权重为 0

如果权重修改为0，则该实例永远不会被访问。

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br>
</div>

## 5.6	环境隔离

##### Nacos 的 namespace

Nacos 提供了 namespace 来实现环境隔离功能。

- nacos 中可以有多个 namespace

- namespace 下可以有group、service等

  <img src="img/5.6-1.png" style="zoom:33%;" />

- **不同 namespace 之间相互隔离**，即不同 namespace 的服务互相不可见.

- 默认情况下，所有 service、data、group 都在同一个namespace，名为 public

<img src="img/5.6-2.png" style="zoom:50%;" />

<br>

##### 创建 namespace

1. 在 Nacos 控制台的命名空间一栏中选择新建命名空间。

   ![](img/5.6-3.png)

2. 输入必要信息。

   ![](img/5.6-4.png)

3. 创建成功。

   <img src="img/5.6-5.png" style="zoom:50%;" />

<br>

##### 为微服务配置 namespace

1. 修改微服务 的 application.yml 文件：

   ```yaml
   spring:
     cloud:
       nacos:
         server-addr: localhost:8848
         discovery:
           cluster-name: HZ
           namespace: 7ff7b9fe-d9a0-4b65-8853-7e8e920ef872 # 命名空间，填写自动生成或设置的命名空间 ID
   ```

2. 之后重启微服务。

----

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br>
</div>

## 5.7	临时实例与永久实例

##### Nacos 的两种服务实例类型

- **临时实例**：如果实例宕机超过一定时间，会从服务列表剔除，**默认的类型**。
- **永久实例（非临时实例）**：如果实例宕机，不会从服务列表剔除。

<br>

##### 配置一个服务实例为永久实例

```ymal
spring:
  cloud:
    nacos:
      discovery:
        ephemeral: false # 设置为永久实例
```

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br>
</div>