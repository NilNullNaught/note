# 6	Feign HTTP 客户端

## 6.1	Feign 概述

#### RestTemplate 远程调用的缺点

1. 代码可读性差，编程体验不统一；
2. 参数复杂，字符形式的 URL 难以维护。

<br>

##### 什么是 Feign

Feign 是由 Netflix 开发的 **声明式、模板化** 的 HTTP 客户端，Feign 可以帮助我们更快捷、优雅地调用 HTTP API。

Feign 支持多种注解，例如 Feign 自带的注解或者 JAX-RS 注解等。

<br>

##### Feign 的作用

Feign 的作用就是帮助我们优雅的实现 http 请求的发送，解决上面提到的问题。Feign 可以把 Rest 的请求进行隐藏，伪装成类似 SpringMVC 的 Controller 格式。如此一来，不需要再进行拼接 url、拼接参数等等操作，一切交由 Feign 完成。

<br>

##### Spring Cloud Feign

Spring Cloud 对 Feign 进行了增强，使 Feign 支持了 Spring MVC 注解，并整合了 Ribbon 和 Eureka，从而让 Feign 的使用更加方便。

Spring Cloud Feign 是基于 Netflix feign 实现**，整合了 Spring Cloud Ribbon 和 Spring Cloud Hystrix**，除了提供这两者的强大功能外，还提供了一种声明式的 Web 服务客户端定义的方式。

Spring Cloud Feign 帮助我们定义和实现依赖服务接口的定义。在 Spring Cloud feign 的实现下，只需要创建一个接口并用注解方式配置它，即可完成服务提供方的接口绑定，简化了在使用 Spring Cloud Ribbon 时自行封装服务调用客户端的开发量。

<br>

##### 官方地址

https://github.com/OpenFeign/feign。

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br>
</div>
## 6.2	Feign 远程调用基础

##### 前提条件

服务提供者与服务调用者都已经在注册中心（nacos） 中进行注册。

<br>

##### Feign 基本使用步骤

1. 在微服务的 pom.xml 文件中引入 feign 依赖：

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-openfeign</artifactId>
</dependency>
```

2. 在微服务的启动类添加注解开启 Feign 的功能：

```java
@MapperScan("cn.itcast.order.mapper")
@SpringBootApplication
@EnableFeignClients//开启 Feign 功能
public class OrderApplication {

    public static void main(String[] args) {
        SpringApplication.run(OrderApplication.class, args);
    }

}
```

3. 编写 Feign 的客户端，在微服务中新建一个接口，内容如下：

```java
package cn.itcast.order.client;

import cn.itcast.order.pojo.User;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient("userservice")// 被调用的w
public interface UserClient {
    @GetMapping("/user/{id}")
    User findById(@PathVariable("id") Long id);
}
//Feign  客户端主要是基于 SpringMVC 的注解来声明远程调用的信息，对应为：
//- 服务名称：userservice
//- 请求方式：GET
//- 请求路径：/user/{id}
//- 请求参数：Long id
//- 返回值类型：User
```

4. 使用 Feign 客户端调用接口：

```java
@RestController
@RequestMapping("order")
public class OrderController {

   @Autowired
   private OrderService orderService;

    @Autowired
    private UserClient userClient;

    @GetMapping("{orderId}")
    public Order queryOrderByUserId(@PathVariable("orderId") Long orderId) {
        //1.查询订单
        Order order = orderService.queryOrderById(orderId);
        //2.利用 Feign 发送 HTTP 请求，查询用户
        User user = userClient.findById(order.getUserId());
        //3.封装 user 到 Order
        order.setUser(user);
        //4.返回
        return orderService.queryOrderById(orderId);
    }
}
```

5. 进行测试。

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br>
</div>
## 6.3	Feign 配置

##### Feign 支持自定义的配置

Feign 可以支持很多的自定义配置，如下表所示：

| 类型                           | 作用             | 说明                                                         |
| ------------------------------ | ---------------- | ------------------------------------------------------------ |
| **feign.Logger.Level**[^6.3-1] | 修改日志级别     | 包含四种不同的级别：NONE[^6.3-2]、BASIC[^6.3-3]、HEADERS[^6.3-4]、FULL[^6.3-5] |
| feign.codec.Decoder            | 响应结果的解析器 | http远程调用的结果做解析，例如解析json字符串为java对象       |
| feign.codec.Encoder            | 请求参数编码     | 将请求参数编码，便于通过http请求发送                         |
| feign. Contract                | 支持的注解格式   | 默认是SpringMVC的注解                                        |
| feign. Retryer                 | 失败重试机制     | 请求失败的重试机制，默认是没有，不过会使用Ribbon的重试       |

一般情况下，默认值就能满足我们使用，如果要自定义时，只需要创建自定义的 `@Bean` 覆盖默认 Bean 即可。

<br>

##### 示例 —— 自定义配置 Feign 的日志级别

###### 方式一 —— 通过配置修改 feign 的日志级别

针对特定服务的日志级别生效：

```yaml
feign:  
  client:
    config: 
      userservice: # 针对某个微服务的配置
        loggerLevel: FULL #  日志级别 
```

针对所有服务的日志级别生效：

```
feign:  
  client:
    config: 
      default: # 这里用default就是全局配置，如果是写服务名称，则是针对某个微服务的配置  
        loggerLevel: FULL #  日志级别 
```

###### 方式二 —— 基于 Java 代码修改日志级别

1. 声明一个类，在类中声明一个 Logger.Level 的对象

```java
public class DefaultFeignConfiguration  {
	@Bean    
	public Logger.Level feignLogLevel(){
    	return Logger.Level.BASIC; // 日志级别为BASIC    
    }
}
```

2. 使配置生效。

```java
//针对所有服务的日志级别生效
//修改启动类的 @EnableFeignClients
@EnableFeignClients(defaultConfiguration = DefaultFeignConfiguration .class) 
```

```java
//针对特定服务的日志级别生效
//修改对应 feign 接口的 @FeignClient 注解中
@FeignClient(value = "userservice", configuration = DefaultFeignConfiguration .class) 
```

3. 测试。

<br>

---

[^6.3-1]: 这项配置的默认值为 NONE，一般需要配置为 BASIC。
[^6.3-2]: 不记录任何日志信息，这是默认值。
[^6.3-3]: 仅记录请求的方法，URL 以及响应状态码和执行时间，常用配置。
[^6.3-4]: 在 BASIC 的基础上，额外记录了请求和响应的头信息。
[^6.3-5]: 记录所有请求和响应的明细，包括头信息、请求体、元数据。

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br>
</div>

## 6.4	Feign 使用优化

##### Feign 的底层实现原理

Feign 底层发起 http 请求，依赖于其它的 HttpClient 框架。Feign 支持的 HttpClient 包括：

- URLConnection：默认实现，**不支持连接池**
- Apache HttpClient ：支持连接池
- OKHttp：支持连接池

<br>

##### 通过修改 HttpClient 可以提升 Feign 的性能

因为默认的 URLConnection 不支持连接池，所以提高 Feign 性能的主要手段就是使用 **支持连接池的 HttpClient ** 代替默认的 URLConnection。

<br>

##### 将 Feign 的 HttpClient 修改为 Apache HttpClient

1. 在微服务的 pom.xml 文件中引入 Apache 的 HttpClient 依赖：

```xml
<!--httpClient的依赖 -->
<dependency>   
	<groupId>io.github.openfeign</groupId>
    <artifactId>feign-httpclient</artifactId>
</dependency>
```

2. 在微服务的 application.yml 中添加连接池配置

```yaml
feign:
  client:
    config:
      default: # default全局的配置
        loggerLevel: BASIC # 日志级别，BASIC就是基本的请求和响应信息
  httpclient:
    enabled: true # 开启feign对HttpClient的支持
    max-connections: 200 # 最大的连接数
    max-connections-per-route: 50 # 每个路径的最大连接数
```

3. 测试，在 FeignClientFactoryBean 中的 loadBalance 方法中打断点，以 Debug 方式启动 order-service 服务，可以看到这里的 client，底层就是 Apache HttpClient。

![image-20210916190839909](img/6.4-1.png)

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br>
</div>

## 6.5	Feign 最佳实践

##### Feign 客户端与服务提供者的 Controller 代码之间的相似性

Order-service 的 Feign 客户端代码：

```java
@FeignClient("userservice")
public interface UserClient {
    @GetMapping("/user/{id}")
    User findById(@PathVariable("id") Long id);
}
```

userservice 的 controller 代码：

```java
@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 路径： /user/110
     *
     * @param id 用户id
     * @return 用户
     */
    @GetMapping("/{id}")
    public User queryById(@PathVariable("id") Long id) {
        return userService.queryById(id);
    }
}
```

那么，有没有一种办法简化这种重复的代码编写呢？

<br>

##### 通过继承方式实现共享

###### 实现步骤

1. 定义一个 API 接口，利用定义方法，并基于 SpringMVC 注解做声明。
2. Feign 客户端和 Controller 都集成该接口。

![image-20210714190640857](img/6.5-1.png)

###### 优点

- 简单
- 实现了代码共享

###### 缺点

- 服务提供方、服务消费方紧耦合

- 参数列表中的注解映射并不会继承，因此 Controller 中必须再次声明方法、参数列表、注解

<br>

##### 📌通过抽取方式实现共享

###### 实现原理

将 Feign 的Client抽取为独立模块，并且把接口有关的POJO、默认的Feign配置都放到这个模块中，提供给所有消费者使用。例如，将 UserClient、User、Feign 的默认配置都抽取到一个 feign-api 包中，所有微服务引用该依赖包，即可直接使用。

###### 实现步骤

1. 首先创建一个 module，命名为 feign-api

2. 将 pojo 包、clients 包 以及 config/DefaultFeignConfiguration.java 都移动到 feign-api 中。

   ![](img/6.5-2.png)

3. 在 feign-api 中然后引入 feign 的 starter 依赖

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-openfeign</artifactId>
</dependency>
```

4. 修改微服务中与 pojo、Client、DefaultFeignConfiguration 相关的类或接口，从 feign-api 中导入。
5. 由于微服务的 @EnableFeignClients 注解在 `GroupId.ProjectName.ModuleName` （比如 `cn.nilnullnaught.nnnnote.user`）包下，与 feign-api 不在同一个包，所以无法扫描到 feign-api 中的内容，解决这个问题有三种方式：

```java
//指定 Feign 应该扫描的包 
@EnableFeignClients(basePackages = "cn.nilnullnaught.nnnnote.feign.clients")
@SpringApplication
public class Application{
    ...
}
```

```java
//指定需要加载的 Client 接口
@EnableFeignClients(clients = {UserClient.class})
@SpringApplication
public class Application{
    ...
}
```

6. 测试。

<br>

##### 📌最佳实践的打包问题

最佳实践中，一般会将所有的 Feign 接口放到一个独立的模块中，但是对于这种没有 main() 的模块，打包时会出现 Unable to find main class 错误， 需要在 pom.xml 文件中加入以下配置

	<build>
	    <plugins>
	        <plugin>
	            <groupId>org.springframework.boot</groupId>
	            <artifactId>spring-boot-maven-plugin</artifactId>
	            <version>2.3.2.RELEASE</version>
	            <configuration>
	                <layout>NONE</layout>
	                <classifier>exec</classifier>
	            </configuration>
	        </plugin>
	    </plugins>
	</build>

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br>
</div>
## 6.6	Feign 的默认超时时间设置

##### 问题

Feign 的默认超时时间太短。

<br>

##### Ribbon 超时时间

Feign 底层的负载均衡通过 Ribbon实现

###### 全局配置

对所有的服务该配置都生效

```yaml
 ribbon:  
	#连接超时时间，单位毫秒，默认为1秒
    ReadTimeout: 30000 #该值会被FeignClient配置connectTimeout覆盖
    #建立连接之后，读取响应资源超时时间，默认为1秒
    ConnectTimeout: 30000 #该值会被FeignClient配置readTimeout覆盖
```

###### 指定服务配置

```yaml
# servicename 是服务的名称，该配置只针对该服务生效
servicename:
  ribbon:
  	#连接超时时间，单位毫秒，默认为1秒
    ReadTimeout: 30000 #该值会被FeignClient配置readTimeout覆盖
    #建立连接之后，读取响应资源超时时间，默认为1秒
    ConnectTimeout: 30000 #该值会被FeignClient配置readTimeout覆盖
```

<br>

##### Feign

###### 全局配置

```yaml
feign:
  client:
    config:
      default:
        #连接超时时间，单位毫秒
        connectTimeout: 5000 
        #建立连接之后，读取响应资源超时时间
        readTimeout: 5000 
```

###### 指定服务配置

```yaml
feign:
  client:
    config:
      annoroad-beta:
      	#连接超时时间，单位毫秒
        connectTimeout: 10000 
        #建立连接之后，读取响应资源超时时间
        readTimeout: 10000
```

<br>

##### 📌建议使用 Feign 配置超时时间

理由：

1. Ribbon 的配置要想生效必须满足微服务相互调用的时候通过注册中心，如果你是在本地通过 @FeignClient 注解的 url 参数进行服务相互调用的测试，此时 ribbon 设置的超时时间将会失效，但是通过 Feign 设置的超时时间不会受到影响（仍然会生效）。
2. 如果同时配置了Ribbon、Feign，那么 Feign 的配置将生效。

综上所述建议使用 Feign 的来设置超时时间

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br>
</div>
## 6.7	在请求头中添加参数

##### 请求发送者

```java

@Autowired
private ServiceHandlerClient serviceHandlerClient

public void sendRequest(){

	serviceHandlerClient.paramInHeader("Hello world");
}

```

<br>

##### feign接口

```java
@FeignClient(name = "service-handler")
public interface ServiceHandlerClient {

    @PostMapping("/paramInHeader")
    public String paramInHeader(@RequestHeader("token")String token);
}
```

<br>

##### 请求处理者

```java


    @PostMapping("/paramInHeader")
    public String paramInHeader(@RequestHeader("token")String token){
    	return token;
    }
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

## 6.8	使用 feign 传输文件

##### feign 接口

```
    @PostMapping(value = "/path",consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public String upDateFile(,@RequestPart("file")MultipartFile file);
```

<br>

##### 请求处理者

```
    @PostMapping("/path")
    public String upDateFile(@RequestPart("file")MultipartFile file) {
        return "OK";
    }
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
## 6.8	使用 contextId 属性、对一个微服务创捷多个 Feign 接口

在openfeign高版本2.2.1中@FeignClient里面添加了新属性ContextId

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br>
</div>
