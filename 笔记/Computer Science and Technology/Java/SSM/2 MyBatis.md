## 1.2	快速开始



在 application.properties 配置文件中添加 MySQL 数据库的相关配置：

###### mysql5 

```properties
#mysql数据库连接
spring.datasource.driver-class-name=com.mysql.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/mybatis_plus
spring.datasource.username=root
spring.datasource.password=123 
```

###### mysql8以上（spring boot 2.1）

```properties
#注意：driver 和 url 的变化
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
#spring.datasource.url=jdbc:mysql://localhost:3306/mybatis_plus?serverTimezone=GMT%2B #无效
spring.datasource.url=jdbc:mysql://localhost:3306/mybatis_plus?useSSL=false
spring.datasource.username=root
spring.datasource.password=123456
```

**注意：**

- （！！！该后缀无效，原因未知，使用?useSSL=false有效）这里的 url 使用了 ?serverTimezone=GMT%2B8 后缀，因为Spring Boot 2.1 集成了 8.0版本的jdbc驱动，这个版本的 jdbc 驱动需要添加这个后缀，否则运行测试用例报告如下错误：

```
java.sql.SQLException: The server time zone value 'ÖÐ¹ú±ê×¼Ê±¼ä' is unrecognized or represents more 
```

- 这里的 driver-class-name 使用了 com.mysql.cj.jdbc.Driver ，在 jdbc 8 中 建议使用这个驱动，之前的 com.mysql.jdbc.Driver 已经被废弃，否则运行测试用例的时候会有 WARN 信息

<br>

##### 在 Spring Boot 启动类或者配置类中添加 @MapperScan 注解，扫描 Mapper文件夹

```
@SpringBootApplication
@MapperScan("com.atguigu.mybatisplus.mapper")
public class MybatisPlusApplication {
    ......
}
```

```
@SpringBootApplication
@MapperScan("com.atguigu.mybatisplus.mapper")
public class MybatisPlusApplication {
    ......
}
```



---

