

# 4	MyBatis-Plus 

## 4.1	MyBatis-Plus 概述

### 4.1.1	MyBatis-Plus 简介

##### 什么是 MyBatis-Plus

[MyBatis-Plus (opens new window)](https://github.com/baomidou/mybatis-plus)（简称 MP）是一个 [MyBatis (opens new window)](https://www.mybatis.org/mybatis-3/)的增强工具，在 MyBatis 的基础上只做增强不做改变，为简化开发、提高效率而生。

<br>

##### 特性

- **无侵入**：只做增强不做改变，引入它不会对现有工程产生影响，如丝般顺滑。
- **损耗小**：启动即会自动注入基本 CURD，性能基本无损耗，直接面向对象操作。
- **强大的 CRUD 操作**：内置通用 Mapper、通用 Service，仅仅通过少量配置即可实现单表大部分 CRUD 操作，更有强大的条件构造器，满足各类使用需求。
- **支持 Lambda 形式调用**：通过 Lambda 表达式，方便的编写各类查询条件，无需再担心字段写错。
- **支持主键自动生成**：支持多达 4 种主键策略（内含分布式唯一 ID 生成器 - Sequence），可自由配置，完美解决主键问题。
- **支持 ActiveRecord 模式**：支持 ActiveRecord 形式调用，实体类只需继承 Model 类即可进行强大的 CRUD 操作。
- **支持自定义全局通用操作**：支持全局通用方法注入（ Write once, use anywhere ）。
- **内置代码生成器**：采用代码或者 Maven 插件可快速生成 Mapper 、 Model 、 Service 、 Controller 层代码，支持模板引擎，更有超多自定义配置等您来使用。
- **内置分页插件**：基于 MyBatis 物理分页，开发者无需关心具体操作，配置好插件之后，写分页等同于普通 List 查询。
- **分页插件支持多种数据库**：支持 MySQL、MariaDB、Oracle、DB2、H2、HSQL、SQLite、Postgre、SQLServer 等多种数据库。
- **内置性能分析插件**：可输出 SQL 语句以及其执行时间，建议开发测试时启用该功能，能快速揪出慢查询。
- **内置全局拦截插件**：提供全表 delete 、 update 操作智能分析阻断，也可自定义拦截规则，预防误操作。

<br>

----

<div STYLE="page-break-after: always;"><br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br></div>

### 4.1.2	快速开始

##### 数据库准备

创建数据库，并添加 user 表：

```sql
DROP TABLE IF EXISTS user;

CREATE TABLE user
(
    id BIGINT(20) NOT NULL COMMENT '主键ID',
    name VARCHAR(30) NULL DEFAULT NULL COMMENT '姓名',
    age INT(11) NULL DEFAULT NULL COMMENT '年龄',
    email VARCHAR(50) NULL DEFAULT NULL COMMENT '邮箱',
    PRIMARY KEY (id)
);
```

插入数据：

```sql
DELETE FROM user;

INSERT INTO user (id, name, age, email) VALUES
(1, 'Jone', 18, 'test1@baomidou.com'),
(2, 'Jack', 20, 'test2@baomidou.com'),
(3, 'Tom', 28, 'test3@baomidou.com'),
(4, 'Sandy', 21, 'test4@baomidou.com'),
(5, 'Billie', 24, 'test5@baomidou.com');
```

<br>

##### 创建工程并引入依赖

创建 Spring Boot 工程，并引入以下依赖：

```xml
<dependencies>

    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter</artifactId>
    </dependency>

    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
        <exclusions>
            <exclusion>
                <groupId>org.junit.vintage</groupId>
                <artifactId>junit-vintage-engine</artifactId>
            </exclusion>
        </exclusions>
    </dependency>

    <!--mybatis-plus-->
    <dependency>
        <groupId>com.baomidou</groupId>
        <artifactId>mybatis-plus-boot-starter</artifactId>
        <version>3.0.5</version>
    </dependency>
    
            <!-- MySQL 驱动 -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>8.0.28</version>
        </dependency>
    
</dependencies>
```

<br>

##### 完成 MyBatis 配置

```yaml
spring:
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/mybatis_plus?useSSL=false
    root: root
    password: password
```

```java
//MyBatis 配置类
@Configuration
@MapperScan("cn.nilnullnaught.MyBatisPlus_demo.mapper")
public class MyBatisConfig {

}
```

```java
//启动类
@SpringBootApplication
public class MybatisPlusDemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(MybatisPlusDemoApplication.class, args);
    }

}
```

<br>

##### 创建实体类 User

```java
public class User {
    private Long id;
    private String name;
    private Integer age;
    private String email;
	
	...
	
}
```

<br>

##### 📌UserMapper 继承泛型接口 BaseMapper\<T>

```java
@Repository
public interface UserMapper extends BaseMapper<User> {
}
```

<br>

##### 测试

```java
@SpringBootTest
class MybatisPlusDemoApplicationTests {

	@Autowired
    private UserMapper userMapper;

	@Test
	void contextLoads() {
		System.out.println(("----- selectAll method test ------"));
		//UserMapper 中的 selectList() 方法的参数为 MP 内置的条件封装器 Wrapper
		//所以不填写就是无任何条件
		List<User> users = userMapper.selectList(null);
		users.forEach(System.out::println);
	}

}
```

<br>

---

<div STYLE="page-break-after: always;"><br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br></div>

### 4.1.3	开启日志

##### 查看 sql 输出日志

在配置文件中进行配置，执行查询后在控制台输出 Sql 语句：

```yaml
mybatis-plus:
  configuration:
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
```

<br>

---

<div STYLE="page-break-after: always;"><br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br></div>


## 4.2	基本操作

##### insert

```
	@Test
	public void testInsert(){
		User user = new User();
		//注意，这里没有设置 id
		user.setName("赵大");
		user.setAge(18);
		user.setEmail("1111111@email.com");

		int result = userMapper.insert(user);
		System.out.println(result);//返回影响的数据行数
		System.out.println(user.getId());// MyBatis-Plus 会自动完成 ID 回填
	}
```

<br>

##### update

```
	@Test
	void testUpdateById(){
		User user = new User();
		user.setId(1L);
		user.setAge(28);

		int result = userMapper.updateById(user);
		System.out.println(result);//返回影响的数据行数
	}
```

<br>

---

<div STYLE="page-break-after: always;"><br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br></div>


## 4.3	主键策略

##### 唯一主键

主键用于唯一标识表中的每一条数据，不能重复, 不能为空。

<br>

##### ID_WORKER

MyBatis-Plus 默认的主键策略，自动生成全局唯一 ID。

<br>

##### 自增策略

要想提供 MyBatis-Plus 设置主键自增需要配置如下主键策略：

1. 需要在创建数据表的时候设置主键自增
2. 实体字段中配置 `@TableId(type = IdType.AUTO)`

```java
@TableId(type = IdType.AUTO)
private Long id;
```

<br>

##### 开启所有实体类主键自增

在配置文件中进行配置

```yaml
#全局设置主键生成策略
mybatis-plus:
	global-config:
		db-config:
			id-type: auto
```

<br>

##### 其他主键策略（以过时）

分析 IdType 源码可知：

```java
public enum IdType {
    AUTO(0),//数据库ID自增
    NONE(1),//不设置主键
    INPUT(2),//用户输入ID，该类型可以通过自己注册自动填充插件进行填充
    
    /* 以下3种类型、只有当插入对象ID 为空，才自动填充。 */
    ID_WORKER(3),//全局唯一ID (idWorker)
    UUID(4),//全局唯一ID (UUID)
    ID_WORKER_STR(5);//字符串全局唯一ID (idWorker 的字符串表示)

    private int key;

    private IdType(int key) {
        this.key = key;
    }

    public int getKey() {
        return this.key;
    }
}

```

<br>

##### 使用 Mybatis-plus ID 生成器生成 ID（在代码逻辑中进行）

```
        //生成 UUID
        String IdWorkerID = IdWorker.get32UUID();
```

<br>

---

<div STYLE="page-break-after: always;"><br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br></div>

## 4.4	数据自动填充

##### 使用 MyBatis-Plus 完成自动填充

项目中经常会遇到一些数据，每次都使用相同的方式填充，例如记录的创建时间，更新时间等。我们可以使用MyBatis Plus的自动填充功能，完成这些字段的赋值工作。

<br>

##### 例——自动填充 create_time 与 update_time

###### 第一步

数据库表 User 中添加 datetime 类型的新字段 create_time 与 update_time

```sql
ALTER TABLE `user` ADD `create_time` DATETIME;
ALTER TABLE `user` ADD `update_time` DATETIME;
```

###### 第二步

在实体类中添加字段 createTime 与 updateTime：

```java
@Data
public class User {
    ......
        
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;
    
    //@TableField(fill = FieldFill.UPDATE)
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date updateTime;
    
}
```

###### 第三步

实现元对象处理器接口：

```java
package cn.nilnullnaught.mybatisplus_demo.handler;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.Date;


public class MyMetaObjectHandler implements MetaObjectHandler {
/** 旧版
    @Override
    public void insertFill(MetaObject metaObject) {
        //使用实体类属性名称，而不是数据库字段名称
        this.setFieldValByName("createTime", new Date(), metaObject);
        this.setFieldValByName("updateTime", new Date(), metaObject);
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        this.setFieldValByName("updateTime", new Date(), metaObject);
    }
*/
    
//新版
    @Override
    public void insertFill(MetaObject metaObject) {
        // 起始版本 3.3.0(推荐使用)
        //使用实体类属性名称，而不是数据库字段名称
        this.strictInsertFill(metaObject, "createTime", LocalDateTime.class, LocalDateTime.now());
        this.strictInsertFill(metaObject, "updateTime", LocalDateTime.class, LocalDateTime.now()); 
        // 或者
         // 起始版本 3.3.3(推荐)
        this.strictInsertFill(metaObject, "createTime", () -> LocalDateTime.now(), LocalDateTime.class);
        this.strictInsertFill(metaObject, "updateTime", () -> LocalDateTime.now(), LocalDateTime.class);

        // 或者
        // 也可以使用(3.3.0 该方法有bug)
        this.fillStrategy(metaObject, "createTime", LocalDateTime.now()); // 也可以使用(3.3.0 该方法有bug)
        this.fillStrategy(metaObject, "updateTime", LocalDateTime.now()); // 也可以使用(3.3.0 该方法有bug)
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        log.info("start update fill ....");
        // 起始版本 3.3.0(推荐)
        this.strictUpdateFill(metaObject, "updateTime", LocalDateTime.class, LocalDateTime.now()); 
        // 或者
        // 起始版本 3.3.3(推荐)
        this.strictUpdateFill(metaObject, "updateTime", () -> LocalDateTime.now(), LocalDateTime.class); 
        // 或者
        // 或者也可以使用(3.3.0 该方法有bug)
        this.fillStrategy(metaObject, "updateTime", LocalDateTime.now()); 
    }
}


```

###### 第四步

```java
	@Test
	void testAutoFieldFill(){
		User user = new User();
		//没有设置 id
		user.setName("钱二");
		user.setAge(18);
		user.setEmail("22222222@email.com");

		int result = userMapper.insert(user);
		System.out.println(result);//返回影响的数据行数
		System.out.println(user.getCreateTime());
		System.out.println(user.getUpdateTime());

		user.setAge(20);

		result = userMapper.updateById(user);
		System.out.println(result);//返回影响的数据行数
		System.out.println(user.getCreateTime());
		System.out.println(user.getUpdateTime());
	}
```

<br>

---

<div STYLE="page-break-after: always;"><br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br></div>


## 4.5	乐观锁

##### 主要适用场景

当要更新一条记录的时候，希望这条记录没有被别人更新，也就是说实现线程安全的数据更新。

<br>

##### 乐观锁实现方式

1. 取出记录时，获取当前 version
2. 更新时，带上这个 version
3. 执行更新时， set version = newVersion where version = oldVersion
4. 如果 version 不对，就更新失败

<br>

##### 例——实现乐观锁

###### 第一步

在数据库 user 中添加 version 字段：

```sql
ALTER TABLE `user` ADD COLUMN `version` INT DEFAULT `1`;
```

###### 第二步

实体类 User 中添加 version 字段，并在 Version 字段上添加注解

```
@Version
@TableField(fill = FieldFill.INSERT)
private Integer version;
```

###### 第三步

元对象处理器接口添加 version 的 insert 默认值

```java
@Component
public class MyMetaObjectHandler implements MetaObjectHandler {

	......
	
    @Override
    public void insertFill(MetaObject metaObject) {
        
        ......
        
        this.setFieldValByName("version", 1, metaObject);
    }
    
    .......
}
```

###### 第四步

在 MybatisPlusConfig 中注册 Bean：

```
@EnableTransactionManagement
@Configuration
@MapperScan("com.atguigu.mybatis_plus.mapper")
public class MybatisPlusConfig {
    /**
     * 乐观锁插件
     */
    @Bean
    public OptimisticLockerInterceptor optimisticLockerInterceptor() {
        return new OptimisticLockerInterceptor();
    }

}
```

###### 第五步

测试后分析打印的 sql 语句，将 version 的数值进行了加 1 操作

```java
	
	//乐观锁测试
	@Test
	void testOptimisticLocker(){
		User user = new User();
		//没有设置 id
		user.setName("孙三");
		user.setAge(18);
		user.setEmail("333@email.com");


		int result = userMapper.insert(user);
		user.setEmail("xxxxxxxx@email.com");
		userMapper.updateById(user);
	}
	
	//乐观锁失败测试
	@Test
	void testOptimisticLockerFail(){
		//使用上次插入的数据 ID 查询数据
		User user = userMapper.selectById(1448293068760166402L);
		user.setEmail("@email.com");


		////模拟取出数据后，数据库中version实际数据比取出的值大，即已被其它线程修改并更新了version
		user.setVersion(user.getVersion() - 1);
		userMapper.updateById(user);
	}
```

###### 📌注意

- 支持的数据类型只有 int、Integer、long、Long、Date、Timestamp、LocalDateTime
- 整数类型下 `newVersion = oldVersion + 1`
- ``newVersion` 会回写到 `entity` 中
- 仅支持 `updateById(id)` 与 `update(entity, wrapper)` 方法
- 在 `update(entity, wrapper)` 方法下, `wrapper` 不能复用

<br>

---

<div STYLE="page-break-after: always;"><br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br></div>


## 4.6	查询

##### 根据 ID 查询记录

```java
@Test
public void testSelectById(){
    User user = userMapper.selectById(1L);
    System.out.println(user);
}
```

<br>

##### 通过多个 ID 批量查询

MyBatis-Plus 完成了动态 sql 的 foreach 功能

```java
@Test
public void testSelectBatchIds(){
   List<User> users = userMapper.selectBatchIds(Arrays.asList(1, 2, 3));
    users.forEach(System.out::println);
}
```

<br>

##### 简单的条件查询

通过 map 封装查询条件：

```java
@Test
public void testSelectByMap(){
    HashMap<String, Object> map = new HashMap<>();
    map.put("name", "Helen");
    map.put("age", 18);
    List<User> users = userMapper.selectByMap(map);
    users.forEach(System.out::println);
}
```

**注意**，map 中的 key 对应的是数据库中的列名，而不是实体类中的属性名。例如数据库 user_id，实体类是 userId，这时 map 的 key 需要填写 user_id。

<br>

##### 分页查询

MyBatis Plus 自带分页插件，只要简单的配置即可实现分页功能。

###### 第一步——配置分页插件

在 MybatisPlusConfig 中配置分页插件

```java
//Spring boot方式
@Configuration
@MapperScan("com.baomidou.cloud.service.*.mapper*")
public class MybatisPlusConfig {

    // 旧版
    @Bean
    public PaginationInterceptor paginationInterceptor() {
        PaginationInterceptor paginationInterceptor = new PaginationInterceptor();
        // 设置请求的页面大于最大页后操作， true调回到首页，false 继续请求  默认false
        // paginationInterceptor.setOverflow(false);
        // 设置最大单页限制数量，默认 500 条，-1 不受限制
        // paginationInterceptor.setLimit(500);
        // 开启 count 的 join 优化,只针对部分 left join
        paginationInterceptor.setCountSqlParser(new JsqlParserCountOptimize(true));
        return paginationInterceptor;
    }
    
    // 最新版（v3.4.3.4）
    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor() {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        interceptor.addInnerInterceptor(new PaginationInnerInterceptor(DbType.H2));
        return interceptor;
    }
    
}
```

###### 第二步——获取查询数据

方式一 —— 通过 page 对象进行分页查询：

```java
@Test
public void testSelectPage() {

    Page<User> page = new Page<>(1,5);
    userMapper.selectPage(page, null);
    
    page.getRecords().forEach(System.out::println);
    System.out.println(page.getCurrent());
    System.out.println(page.getPages());
    System.out.println(page.getSize());
    System.out.println(page.getTotal());
    System.out.println(page.hasNext());
    System.out.println(page.hasPrevious());
}
```

方式二 —— 通过 selectMapsPage 进行分页查询：

```
@Test
public void testSelectMapsPage() {

    Page<User> page = new Page<>(1, 5);
    IPage<Map<String, Object>> mapIPage = userMapper.selectMapsPage(page, null);
    
    
    mapIPage.getRecords().forEach(System.out::println//注意：本行必须使用 mapIPage 获取记录列表，否则会有数据类型转换错误
    System.out.println(page.getCurrent());
    System.out.println(page.getPages());
    System.out.println(page.getSize());
    System.out.println(page.getTotal());
    System.out.println(page.hasNext());
    System.out.println(page.hasPrevious());
}
```

<br>

---

<div STYLE="page-break-after: always;"><br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br></div>


## 4.7	删除

##### 根据 id 删除记录

```java
@Test
public void testDeleteById(){
    int result = userMapper.deleteById(8L);
    System.out.println(result);
}
```

<br>

##### 批量删除

```
    @Test
    public void testDeleteBatchIds() {
        int result = userMapper.deleteBatchIds(Arrays.asList(8, 9, 10));
        System.out.println(result);
    }
```

<br>

##### 简单的条件查询删除

```
@Test
public void testDeleteByMap() {
    HashMap<String, Object> map = new HashMap<>();
    map.put("name", "Helen");
    int result = userMapper.deleteByMap(map);
    System.out.println(result);
}
```

<br>

##### 逻辑删除

###### 什么是逻辑删除

物理删除，即真实删除，将对应数据从数据库中删除，之后查询不到此条被删除数据，通常意义上的删除操作。

逻辑删除即假删除，将对应数据中代表是否被删除字段状态修改为“被删除状态”，之后在数据库中仍旧能看到此条数据记录。

<br>

##### 4.3.0 版本之后实现逻辑删除

###### 第一步

在 application.yml 中进行配置：

```
mybatis-plus:
  global-config:
    db-config:
      logic-delete-field: flag # 全局逻辑删除的实体字段名(since 3.3.0,配置后可以忽略不配置步骤2)
      logic-delete-value: 1 # 逻辑已删除值(默认为 1)
      logic-not-delete-value: 0 # 逻辑未删除值(默认为 0)
```

###### 第二步

实体类字段上加上 `@TableLogic` 注解

```java
@TableLogic
private Integer deleted;
```

<br>

##### 4.3.0 版本之前实现逻辑删除

###### 第一步

在数据库 User 中添加 deleted 字段

```
ALTER TABLE `user` ADD COLUMN `deleted` boolean DEFAULT `0`
```

###### 第二步

在实体 User 类中添加 deleted 字段，加上 @TableLogic 注解 和 @TableField(fill = FieldFill.INSERT) 注解

```java
@TableLogic
@TableField(fill = FieldFill.INSERT)
private Integer deleted;
```

###### 第三步

在元对象处理器接口添加 deleted 的 insert 默认值

```java
@Component
public class MyMetaObjectHandler implements MetaObjectHandler {

	......
	
    @Override
    public void insertFill(MetaObject metaObject) {
        
        ......
        
        this.setFieldValByName("deleted", 0, metaObject);
    }
    
    .......
}
```

###### 第四步

在配置文件中进行配置，逻辑删除一般是默认开启的，所以也可以不进行配置

```
mybatis-plus.global-config.db-config.logic-delete-value=1
mybatis-plus.global-config.db-config.logic-not-delete-value=0
```

###### 第五步

在 MybatisPlusConfig 中注册 Bean

```java
//开启逻辑删除
@Bean
public ISqlInjector sqlInjector() {
    return new LogicSqlInjector();
}
```

###### 第六步

测试逻辑删除

```java
//进行一次逻辑删除
@Test
public void testLogicDelete() {
    int result = userMapper.deleteById(1L);
    System.out.println(result);
}

//查询逻辑删除后的结果
@Test
public void testLogicDeleteResult() {
    int result = userMapper.deleteById(1L);
    System.out.println(result);
}
```

<br>

---

<div STYLE="page-break-after: always;"><br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br></div>


## 4.8	复制查询

##### 条件构造器 wapper

![img](img/4.8/1.png)

<br>

##### AbstractWrapper

`QueryWrapper(LambdaQueryWrapper)` 和 `UpdateWrapper(LambdaUpdateWrapper)` 的父类。用于生成 sql 的 where 条件, entity 属性也用于生成 sql 的 where 条件。

注意:，entity 生成的 where 条件与使用各个 api 生成的 where 条件 **没有任何关联行为**。

<br>

##### allEq

```java
allEq(Map<R, V> params)
allEq(Map<R, V> params, boolean null2IsNull)
allEq(boolean condition, Map<R, V> params, boolean null2IsNull)
```

- 全部

  eq

  (或个别

  isNull

  )

  个别参数说明:

  `params` : `key`为数据库字段名,`value`为字段值
  `null2IsNull` : 为`true`则在`map`的`value`为`null`时调用 [isNull](https://mp.baomidou.com/guide/wrapper.html#isnull) 方法,为`false`时则忽略`value`为`null`的

- 例1: `allEq({id:1,name:"老王",age:null})`--->`id = 1 and name = '老王' and age is null`

- 例2: `allEq({id:1,name:"老王",age:null}, false)`--->`id = 1 and name = '老王'`

```java
allEq(BiPredicate<R, V> filter, Map<R, V> params)
allEq(BiPredicate<R, V> filter, Map<R, V> params, boolean null2IsNull)
allEq(boolean condition, BiPredicate<R, V> filter, Map<R, V> params, boolean null2IsNull) 
```

个别参数说明:

`filter` : 过滤函数,是否允许字段传入比对条件中
`params` 与 `null2IsNull` : 同上

- 例1: `allEq((k,v) -> k.indexOf("a") >= 0, {id:1,name:"老王",age:null})`--->`name = '老王' and age is null`
- 例2: `allEq((k,v) -> k.indexOf("a") >= 0, {id:1,name:"老王",age:null}, false)`--->`name = '老王'`

### [#](https://mp.baomidou.com/guide/wrapper.html#eq)eq



 



```java
eq(R column, Object val)
eq(boolean condition, R column, Object val)
```

- 等于 =
- 例: `eq("name", "老王")`--->`name = '老王'`

### [#](https://mp.baomidou.com/guide/wrapper.html#ne)ne



 



```java
ne(R column, Object val)
ne(boolean condition, R column, Object val)
```

- 不等于 <>
- 例: `ne("name", "老王")`--->`name <> '老王'`

### [#](https://mp.baomidou.com/guide/wrapper.html#gt)gt



 



```java
gt(R column, Object val)
gt(boolean condition, R column, Object val)
```

- 大于 >
- 例: `gt("age", 18)`--->`age > 18`

### [#](https://mp.baomidou.com/guide/wrapper.html#ge)ge



 



```java
ge(R column, Object val)
ge(boolean condition, R column, Object val)
```

- 大于等于 >=
- 例: `ge("age", 18)`--->`age >= 18`

### [#](https://mp.baomidou.com/guide/wrapper.html#lt)lt



 



```java
lt(R column, Object val)
lt(boolean condition, R column, Object val)
```

- 小于 <
- 例: `lt("age", 18)`--->`age < 18`

### [#](https://mp.baomidou.com/guide/wrapper.html#le)le



 



```java
le(R column, Object val)
le(boolean condition, R column, Object val)
```

- 小于等于 <=
- 例: `le("age", 18)`--->`age <= 18`

### [#](https://mp.baomidou.com/guide/wrapper.html#between)between



 



```java
between(R column, Object val1, Object val2)
between(boolean condition, R column, Object val1, Object val2)
```

- BETWEEN 值1 AND 值2
- 例: `between("age", 18, 30)`--->`age between 18 and 30`

### [#](https://mp.baomidou.com/guide/wrapper.html#notbetween)notBetween



 



```java
notBetween(R column, Object val1, Object val2)
notBetween(boolean condition, R column, Object val1, Object val2)
```

- NOT BETWEEN 值1 AND 值2
- 例: `notBetween("age", 18, 30)`--->`age not between 18 and 30`

### [#](https://mp.baomidou.com/guide/wrapper.html#like)like



 



```java
like(R column, Object val)
like(boolean condition, R column, Object val)
```

- LIKE '%值%'
- 例: `like("name", "王")`--->`name like '%王%'`

### [#](https://mp.baomidou.com/guide/wrapper.html#notlike)notLike



 



```java
notLike(R column, Object val)
notLike(boolean condition, R column, Object val)
```

- NOT LIKE '%值%'
- 例: `notLike("name", "王")`--->`name not like '%王%'`

### [#](https://mp.baomidou.com/guide/wrapper.html#likeleft)likeLeft



 



```java
likeLeft(R column, Object val)
likeLeft(boolean condition, R column, Object val)
```

- LIKE '%值'
- 例: `likeLeft("name", "王")`--->`name like '%王'`

### [#](https://mp.baomidou.com/guide/wrapper.html#likeright)likeRight



 



```java
likeRight(R column, Object val)
likeRight(boolean condition, R column, Object val)
```

- LIKE '值%'
- 例: `likeRight("name", "王")`--->`name like '王%'`

### [#](https://mp.baomidou.com/guide/wrapper.html#isnull)isNull



 



```java
isNull(R column)
isNull(boolean condition, R column)
```

- 字段 IS NULL
- 例: `isNull("name")`--->`name is null`

### [#](https://mp.baomidou.com/guide/wrapper.html#isnotnull)isNotNull



 



```java
isNotNull(R column)
isNotNull(boolean condition, R column)
```

- 字段 IS NOT NULL
- 例: `isNotNull("name")`--->`name is not null`

### [#](https://mp.baomidou.com/guide/wrapper.html#in)in



 



```java
in(R column, Collection<?> value)
in(boolean condition, R column, Collection<?> value)
```

- 字段 IN (value.get(0), value.get(1), ...)
- 例: `in("age",{1,2,3})`--->`age in (1,2,3)`



 



```java
in(R column, Object... values)
in(boolean condition, R column, Object... values)
```

- 字段 IN (v0, v1, ...)
- 例: `in("age", 1, 2, 3)`--->`age in (1,2,3)`

### [#](https://mp.baomidou.com/guide/wrapper.html#notin)notIn



 



```java
notIn(R column, Collection<?> value)
notIn(boolean condition, R column, Collection<?> value)
```

- 字段 NOT IN (value.get(0), value.get(1), ...)
- 例: `notIn("age",{1,2,3})`--->`age not in (1,2,3)`



 



```java
notIn(R column, Object... values)
notIn(boolean condition, R column, Object... values)
```

- 字段 NOT IN (v0, v1, ...)
- 例: `notIn("age", 1, 2, 3)`--->`age not in (1,2,3)`

### [#](https://mp.baomidou.com/guide/wrapper.html#insql)inSql



 



```java
inSql(R column, String inValue)
inSql(boolean condition, R column, String inValue)
```

- 字段 IN ( sql语句 )
- 例: `inSql("age", "1,2,3,4,5,6")`--->`age in (1,2,3,4,5,6)`
- 例: `inSql("id", "select id from table where id < 3")`--->`id in (select id from table where id < 3)`

### [#](https://mp.baomidou.com/guide/wrapper.html#notinsql)notInSql



 



```java
notInSql(R column, String inValue)
notInSql(boolean condition, R column, String inValue)
```

- 字段 NOT IN ( sql语句 )
- 例: `notInSql("age", "1,2,3,4,5,6")`--->`age not in (1,2,3,4,5,6)`
- 例: `notInSql("id", "select id from table where id < 3")`--->`id not in (select id from table where id < 3)`

### [#](https://mp.baomidou.com/guide/wrapper.html#groupby)groupBy



 



```java
groupBy(R... columns)
groupBy(boolean condition, R... columns)
```

- 分组：GROUP BY 字段, ...
- 例: `groupBy("id", "name")`--->`group by id,name`

### [#](https://mp.baomidou.com/guide/wrapper.html#orderbyasc)orderByAsc



 



```java
orderByAsc(R... columns)
orderByAsc(boolean condition, R... columns)
```

- 排序：ORDER BY 字段, ... ASC
- 例: `orderByAsc("id", "name")`--->`order by id ASC,name ASC`

### [#](https://mp.baomidou.com/guide/wrapper.html#orderbydesc)orderByDesc



 



```java
orderByDesc(R... columns)
orderByDesc(boolean condition, R... columns)
```

- 排序：ORDER BY 字段, ... DESC
- 例: `orderByDesc("id", "name")`--->`order by id DESC,name DESC`

### [#](https://mp.baomidou.com/guide/wrapper.html#orderby)orderBy

 



```java
orderBy(boolean condition, boolean isAsc, R... columns)
```

- 排序：ORDER BY 字段, ...
- 例: `orderBy(true, true, "id", "name")`--->`order by id ASC,name ASC`

### [#](https://mp.baomidou.com/guide/wrapper.html#having)having



 



```java
having(String sqlHaving, Object... params)
having(boolean condition, String sqlHaving, Object... params)
```

- HAVING ( sql语句 )
- 例: `having("sum(age) > 10")`--->`having sum(age) > 10`
- 例: `having("sum(age) > {0}", 11)`--->`having sum(age) > 11`

### [#](https://mp.baomidou.com/guide/wrapper.html#func)func



 



```java
func(Consumer<Children> consumer)
func(boolean condition, Consumer<Children> consumer)
```

- func 方法(主要方便在出现if...else下调用不同方法能不断链)
- 例: `func(i -> if(true) {i.eq("id", 1)} else {i.ne("id", 1)})`

### [#](https://mp.baomidou.com/guide/wrapper.html#or)or



 



```java
or()
or(boolean condition)
```

- 拼接 OR

  注意事项:

  主动调用`or`表示紧接着下一个**方法**不是用`and`连接!(不调用`or`则默认为使用`and`连接)

- 例: `eq("id",1).or().eq("name","老王")`--->`id = 1 or name = '老王'`



 



```java
or(Consumer<Param> consumer)
or(boolean condition, Consumer<Param> consumer)
```

- OR 嵌套
- 例: `or(i -> i.eq("name", "李白").ne("status", "活着"))`--->`or (name = '李白' and status <> '活着')`

### [#](https://mp.baomidou.com/guide/wrapper.html#and)and



 



```java
and(Consumer<Param> consumer)
and(boolean condition, Consumer<Param> consumer)
```

- AND 嵌套
- 例: `and(i -> i.eq("name", "李白").ne("status", "活着"))`--->`and (name = '李白' and status <> '活着')`

### [#](https://mp.baomidou.com/guide/wrapper.html#nested)nested



 



```java
nested(Consumer<Param> consumer)
nested(boolean condition, Consumer<Param> consumer)
```

- 正常嵌套 不带 AND 或者 OR
- 例: `nested(i -> i.eq("name", "李白").ne("status", "活着"))`--->`(name = '李白' and status <> '活着')`

### [#](https://mp.baomidou.com/guide/wrapper.html#apply)apply



 



```java
apply(String applySql, Object... params)
apply(boolean condition, String applySql, Object... params)
```

- 拼接 sql

  注意事项:

  该方法可用于数据库**函数** 动态入参的`params`对应前面`applySql`内部的`{index}`部分.这样是不会有sql注入风险的,反之会有!

- 例: `apply("id = 1")`--->`id = 1`

- 例: `apply("date_format(dateColumn,'%Y-%m-%d') = '2008-08-08'")`--->`date_format(dateColumn,'%Y-%m-%d') = '2008-08-08'")`

- 例: `apply("date_format(dateColumn,'%Y-%m-%d') = {0}", "2008-08-08")`--->`date_format(dateColumn,'%Y-%m-%d') = '2008-08-08'")`

### [#](https://mp.baomidou.com/guide/wrapper.html#last)last



 



```java
last(String lastSql)
last(boolean condition, String lastSql)
```

- 无视优化规则直接拼接到 sql 的最后

  注意事项:

  只能调用一次,多次调用以最后一次为准 有sql注入的风险,请谨慎使用

- 例: `last("limit 1")`

### [#](https://mp.baomidou.com/guide/wrapper.html#exists)exists



 



```java
exists(String existsSql)
exists(boolean condition, String existsSql)
```

- 拼接 EXISTS ( sql语句 )
- 例: `exists("select id from table where age = 1")`--->`exists (select id from table where age = 1)`

### [#](https://mp.baomidou.com/guide/wrapper.html#notexists)notExists



 



```java
notExists(String notExistsSql)
notExists(boolean condition, String notExistsSql)
```

- 拼接 NOT EXISTS ( sql语句 )
- 例: `notExists("select id from table where age = 1")`--->`not exists (select id from table where age = 1)`

## 📌QueryWrapper

说明:

继承自 AbstractWrapper ,自身的内部属性 entity 也用于生成 where 条件
及 LambdaQueryWrapper, 可以通过 new QueryWrapper().lambda() 方法获取

### [#](https://mp.baomidou.com/guide/wrapper.html#select)select





 



```java
select(String... sqlSelect)
select(Predicate<TableFieldInfo> predicate)
select(Class<T> entityClass, Predicate<TableFieldInfo> predicate)
```

- 设置查询字段

  说明:

  以上方法分为两类.
  第二类方法为:过滤查询字段(主键除外),入参不包含 class 的调用前需要`wrapper`内的`entity`属性有值! 这两类方法重复调用以最后一次为准

- 例: `select("id", "name", "age")`

- 例: `select(i -> i.getProperty().startsWith("test"))`

## 📌 UpdateWrapper

说明:

继承自 `AbstractWrapper` ,自身的内部属性 `entity` 也用于生成 where 条件
及 `LambdaUpdateWrapper`, 可以通过 `new UpdateWrapper().lambda()` 方法获取!

### [#](https://mp.baomidou.com/guide/wrapper.html#set)set

```java
set(String column, Object val)
set(boolean condition, String column, Object val)
```

- SQL SET 字段
- 例: `set("name", "老李头")`
- 例: `set("name", "")`--->数据库字段值变为**空字符串**
- 例: `set("name", null)`--->数据库字段值变为`null`

### [#](https://mp.baomidou.com/guide/wrapper.html#setsql)setSql

```java
setSql(String sql)
```

- 设置 SET 部分 SQL
- 例: `setSql("name = '老李头'")`

### [#](https://mp.baomidou.com/guide/wrapper.html#lambda)lambda

- 获取 `LambdaWrapper`
  在`QueryWrapper`中是获取`LambdaQueryWrapper`
  在`UpdateWrapper`中是获取`LambdaUpdateWrapper`

---

<div STYLE="page-break-after: always;"><br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br></div>