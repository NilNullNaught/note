# 2	Spring Boot 单元测试最佳实践

##### 依赖

```xml
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
```

<br>

##### 单元测试基类

```java
//一般声明在 UT 测试类上，用于指定该测试类的配置类
@ActiveProfiles(value = "test")

@RunWith(SpringRunner.class)
@SpringBootTest//(
				//指定启动类
				//classes = Application.class, 
				//和测试类中的 @LocalServerPort 一起在注入属性时使用。会随机生成一个端口号。
				//webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)

//开启事务回滚（防止测试数据污染数据库）
//在需要开启事务回滚的方法上使用 @Transactional
@Rollback(value = true)

//忽略单元测试中不需要的自动配置类
//例：排除 redis 配置类
//@TestPropertySource(properties={
//        "spring.autoconfigure.exclude=" +
//        "org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration," +
//        "org.springframework.boot.autoconfigure.data.redis.RedisRepositoriesAutoConfiguration"
//})
public class BaseTest {
}
```

<br>

##### 单元测试配置文件

如果在项目中使用了配置中心，那么单元测试的配置文件的文件名设置为 `bootstrap-test.yml`，否则使用 `application-test.yaml`：

```yaml
spring:
  main:
  	#启用延迟初始化，缩短应用程序的启动时间
    lazy-initialization: true
  cloud:
    nacos:
      #关闭 nacos 发现
      discovery:
        enabled: false
      #关闭配置中心  
      config:
        enabled: false

	...其他配置
```

<br>

##### 单元测试方法

```java
public class Test extends BaseTest{

    @Test
    //开启事务
    //@Transactional
   
    //与 @Transactional 配合使用，在方法执行完成后进行回滚，防止脏数据
    //注意，意味 BaseTest 中已经开启该注解，所以可以不加该注解
    //@Rollback(value = true)
    public void test(){

}
```

<br>

##### 📌单元测试无法扫描 Mapper.xml 文件（Invalid bound statement (not found)）

将配置文件中加载 mapper.xm l配置文件的路径由 ：

```
classpath:/cn/nilnullnaught/ProjectID/ModuleID/*/mapper/xml/*.xml
```

修改为：

```
classpath*:/cn/nilnullnaught/ProjectID/ModuleID/*/mapper/xml/*.xml
```

<br>

----

<div STYLE="page-break-after: always;">
    <br>
	<br>
	<br>
	<br>
	<br>
</div>
