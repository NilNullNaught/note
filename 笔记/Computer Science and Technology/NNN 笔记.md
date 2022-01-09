# 1	需求分析

## 1.1	功能性需求

##### 注册功能

- 允许用户通过邮箱与手机号进行注册
- 设置密码与确认
- Captcha 验证

<br>

##### 登录功能

- 使用邮箱或手机号进行登录
- 使用手机号与短信验证码进行登录
- 记住我功能
- 账号找回
- Captcha 验证

<br>

##### 用户个人信息

- 设置用户名（可重复）
- 设置头像
- 修改密码

<br>

##### 笔记

- 使用 MarkDown 语法进行笔记
- 可以插入图片
- 支持插入视频地址，但是不能直接插入视频。

<br>

##### 笔记管理

- 笔记搜索
- 笔记批量选择
- 笔记删除
- 笔记排序（按时间排序、按标题排序）
- 笔记分组
- 笔记修改
- 笔记回收站

<br>

##### 定时任务提醒

- 发送邮件或短信进行提醒。
- 仅支持文字内容。
- 与笔记属于并列关系

<br>

##### 后台管理

- 数据分析
- 权限管理
- 用户管理
- 笔记管理

<br>

---



## 1.2	非功能性需求

##### 性能需求

<br>

##### 环境需求

- 支持主流网页浏览（不支持旧版本 IE 浏览器）
- 支持手机浏览器

<br>

##### 页面设计需求

- 功能简洁易懂

<br>

##### 可扩展功能

- 分享功能
- 评论功能
- 关注功能
- 私信功能

<br>

---



# 2	技术选型

##### 服务器

- Linux version 3.10.0-514.26.2.el7.x86_64 (builder@kbuilder.dev.centos.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Jul 4 15:04:05 UTC 2017

<br>

##### 关系型数据库

- Ver 8.0.26 for Linux on x86_64  (MySQL Community Server - GPL)

<br>

##### JDK

- JDK 17

<br>

##### 数据缓存

###### 本地缓存

- Nginx
- OpenResty
- Redis

###### 进程缓存

- Caffeine

###### 缓存同步

- Canal

<br>

##### 搜索引擎

- Elastic Search

<br>

##### 后端技术

- Spring
- Spring MVC
- Spring Boot
- MyBatis
- MyBatis Plus

<br>

##### 微服务框架

- Spring Cloud Alibaba

<br>

##### 消息中间件

- RabbitMQ

<br>

##### 前端框架

- Vue.js + ElementUI

<br>

##### 📌分布式代码生成器

- 待定

<br>

---



# 3	模块划分



---



# 4	



---

