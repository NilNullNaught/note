## 使用 IDEA 创建 Java Web 项目

###### 第一步——创建 Maven 项目

略。

###### 第二步——添加 Web 支持

右键项目，选择 add framework support：

![](img/使用 IDEA 创建 Java Web 项目/1.png)

勾选 Web Application：

![](img/使用 IDEA 创建 Java Web 项目/2.png)

###### 第三步——完善项目结构

在 web/WEB-INF 文件夹下创建 classes 和 lib 文件夹：

![](img/使用 IDEA 创建 Java Web 项目/3.png)

###### 第四步——修改 Output path

打开 Project Structure：

![](img/使用 IDEA 创建 Java Web 项目/4.png)

打开 Modules → Paths，修改 Output path 为 wen/WEN-INF/classes：

![](img/使用 IDEA 创建 Java Web 项目/5.png)

###### 第五步——修改 jar Directory

打开 Modules → Dependencies → + JARs or Directories：

![](img/使用 IDEA 创建 Java Web 项目/6.png)

![](img/使用 IDEA 创建 Java Web 项目/7.png)

勾选并接受：

![](img/使用 IDEA 创建 Java Web 项目/8.png)



###### 第六步——配置 Web 容器

打开 Run/Debug Configurations：



![](img/使用 IDEA 创建 Java Web 项目/9.png)

添加本地 Tomcat 容器：

![](img/使用 IDEA 创建 Java Web 项目/10.png)

配置容器：

![](img/使用 IDEA 创建 Java Web 项目/11.png)

添加 artifact（Project Structure → + → Web Application exploded  → from Modules）：

![](img/使用 IDEA 创建 Java Web 项目/12.png)

<br>

##### 参考文章地址

https://blog.csdn.net/mongchu/article/details/118198222