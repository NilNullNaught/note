# 7	Gatway 路由网关

## 7.1	Gateway 概述

##### 什么是 Gateway

Spring Cloud Gateway 是 Spring Cloud 的一个子项目，该项目是基于 Spring 5.0，Spring Boot 2.0 和 Project Reactor 等响应式编程和事件流技术开发的网关，它旨在为微服务架构提供一种简单有效的统一的 API 路由管理方式。

Gateway 网关是我们服务的守门神，所有微服务的统一入口。

<br>

##### 网关的**核心功能特性**

- **请求路由和负载均衡**：一切请求都必须先经过 gateway，但网关不处理业务，而是根据某种规则，把请求转发到某个微服务，这个过程叫做路由。当然路由的目标服务有多个时，还需要做负载均衡。
- **权限控制**：网关作为微服务入口，需要校验用户是是否有请求资格，如果没有则进行拦截。
- **限流**：当请求流量过高时，在网关中按照下流的微服务能够接受的速度来放行请求，避免服务压力过大。

<br>

##### 网关架构图

<img src="img/7.1-1.png" alt="image-20210714210131152" style="zoom:50%;" />

<br>

##### gateway 与 zuul

在 Spring Cloud 中网关的实现包括两种，分别是 Zuul 和 gateway。Zuul 是基于 Servlet 的实现，属于阻塞式编程。而 SpringCloudGateway 则是基于 Spring5 中提供的 WebFlux，属于响应式编程的实现，具备更好的性能。

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br>
</div>

## 7.2	Gateway 基础使用

##### 使用步骤

1. 创建微服务 gateway 子模块。
2. 引入网关依赖与服务发现依赖。

```java
<!--网关-->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-gateway</artifactId>
</dependency>
    
<!--nacos服务发现依赖-->
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
</dependency>
```

3. 编写启动类。
4. 编写基础配置和路由规则。

```yaml
server:
  port: 10010 # 网关端口
spring:
  application:
    name: gateway # 服务名称
  cloud:
    nacos:
      server-addr: localhost:8848 # nacos地址
    gateway:
      routes: # 网关路由配置
        - id: user-service # 路由id，自定义，只要唯一即可
          # uri: http://127.0.0.1:8081 # 路由的目标地址,使用 http 作为前缀意味使用的是固定地址
          uri: lb://userservice # 路由的目标地址 lb就是负载均衡，后面跟服务名称
          predicates: # 路由断言，即判断请求是否符合路由规则的条件
            - Path=/user/** # 这个是按照路径匹配，只要以/user/开头就符合要求
            
#上述规则会将 `/user/**`开头的请求，代理到`lb://userservice`，lb是负载均衡，根据服务名拉取服务列表，实现负载均衡。
```

5. 访问 http://localhost:10010/user/1 时，符合 `/user/**` 规则，请求转发到 uri：http://userservice/user/1，得到了结果：

   ![image-20210714211908341](img/7.2-1.png)

<br>

##### 网关路由的流程图

<img src="img/7.2-2.png" alt="网关路由的流程图" style="zoom:50%;" />

<br>

##### Gateway 所包括的路由配置

- **路由 ID**：路由的唯一标示
- **路由目标（uri）**：路由的目标地址，http代表固定地址，lb代表根据服务名负载均衡
- **路由断言（predicates）**：判断路由的规则，
- **路由过滤器（filters）**：对请求或响应做处理

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br>
</div>

## 7.3	断言规则与断言工厂

##### 断言规则的处理流程

配置文件中的断言规则只是字符串，这些字符串会被 PredicateFactory （断言工厂）读取并处理，转变为路由判断的条件。

例如 `Path=/user/**` 是按照路径匹配，这个规则是由 `org.springframework.cloud.gateway.handler.predicate.PathRoutePredicateFactory` 处理的。

<br>

##### SpringCloudGateway 的 11 个断言工厂

| **名称**   | **说明**                       | **示例**                                                     |
| ---------- | ------------------------------ | ------------------------------------------------------------ |
| After      | 是某个时间点后的请求           | -  After=2037-01-20T17:42:47.789-07:00[America/Denver]       |
| Before     | 是某个时间点之前的请求         | -  Before=2031-04-13T15:14:47.433+08:00[Asia/Shanghai]       |
| Between    | 是某两个时间点之前的请求       | -  Between=2037-01-20T17:42:47.789-07:00[America/Denver],  2037-01-21T17:42:47.789-07:00[America/Denver] |
| Cookie     | 请求必须包含某些cookie         | - Cookie=chocolate, ch.p                                     |
| Header     | 请求必须包含某些header         | - Header=X-Request-Id, \d+                                   |
| Host       | 请求必须是访问某个host（域名） | -  Host=\*\*.somehost.org,\*\*.anotherhost.org               |
| Method     | 请求方式必须是指定方式         | - Method=GET,POST                                            |
| Path       | 请求路径必须符合指定规则       | - Path=/red/{segment},/blue/\*\*                             |
| Query      | 请求参数必须包含指定参数       | - Query=name, Jack或者-  Query=name                          |
| RemoteAddr | 请求者的ip必须是指定范围       | - RemoteAddr=192.168.1.1/24                                  |
| Weight     | 权重处理                       |                                                              |

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br>
</div>

## 7.4	Gateway 过滤器工厂

##### 什么是路由过滤器

路由过滤器是 Gateway 提供的一种过滤器，可以对进入网关的请求和微服务返回的响应做处理：

<img src="img/7.4-1.png" alt="GatewayFilter 示意图" style="zoom: 67%;" />

<br>

##### Gateway  提供的路由过滤器

Gateway  提供了 31 种不同的路由过滤器工厂。例如：

| **名称**             | **说明**                     |
| -------------------- | ---------------------------- |
| AddRequestHeader     | 给当前请求添加一个请求头     |
| RemoveRequestHeader  | 移除请求中的一个请求头       |
| AddResponseHeader    | 给响应结果中添加一个响应头   |
| RemoveResponseHeader | 从响应结果中移除有一个响应头 |
| RequestRateLimiter   | 限制请求的流量               |

<br>

##### 示例 —— 请求头过滤器

###### 需求

给所有进入 userservice 的请求添加一个请求头：Text=Test AddRequestHeader  GatewayFilter

###### 实现

只需要修改 gateway 服务的 application.yml 文件，添加路由过滤即可：

```yaml
当前过滤器写在userservice路由下，因此仅仅对访问userservice的请求有效。spring:
  cloud:
    gateway:
      routes:
      - id: user-service 
        uri: lb://userservice 
        predicates: 
        - Path=/user/** 
        filters: # 过滤器
        - AddRequestHeader=TestText,Test AddRequestHeader  GatewayFilter # 添加请求头
        #当前过滤器写在userservice路由下，因此仅仅对访问userservice的请求有效。
```

###### 测试

在 userservice 的 Controller 中添加方法进行测试。

```
    @GetMapping("/AddRequestHeaderTest")
    public String AddRequestHeaderTest(@RequestHeader(value = "TestText",required = false)String TestText){
        return TestText;
    }
```

<br>

##### 默认过滤器

如果要对所有的路由都生效，则可以将过滤器工厂写到default下。格式如下：

```yaml
spring:
  cloud:
    gateway:
      routes:
      - id: user-service 
        uri: lb://userservice 
        predicates: 
        - Path=/user/**
      default-filters: # 默认过滤项
      - AddRequestHeader=Truth, Itcast is freaking awesome! 
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

## 7.5	GlobalFilter 

##### 全局过滤器的作用

与 GatewayFilter 相同，全局过滤器的作用也是处理一切进入网关的请求和微服务响应。区别在于，GatewayFilter 通过配置定义，处理逻辑是固定的；而 GlobalFilter 的逻辑需要自己写代码实现。

因此，可以通过自定义的业务逻辑，从而实现多种功能：

- 登录状态判断
- 权限校验
- 请求限流
- ......

<br>

##### 全局过滤器的实现

通过创建一个类实现 GlobalFilter 接口进行：

```java
//GlobalFilter 接口源码
public interface GlobalFilter {
    /**
     *  处理当前请求，有必要的话通过{@link GatewayFilterChain}将请求交给下一个过滤器处理
     *
     * @param exchange 请求上下文，里面可以获取Request、Response等信息
     * @param chain 用来把请求委托给下一个过滤器 
     * @return {@code Mono<Void>} 返回标示当前过滤器业务结束
     */
    Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain);
}
```

<br>

##### 示例 —— 实现一个自定义的全局过滤器

###### 需求

定义全局过滤器，拦截请求，判断请求的参数是否满足下面条件：

- 参数中是否有 authorization，
- authorization 参数值是否为 admin

如果同时满足则放行，否则拦截。

###### 实现

在 gateway 中定义一个过滤器：

```java
package cn.itcast.gateway.filters;

import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

@Component
public class AuthorizeFilter implements GlobalFilter {
    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        // 1.获取请求参数
        MultiValueMap<String, String> params = exchange.getRequest().getQueryParams();
        // 2.获取authorization参数
        String auth = params.getFirst("authorization");
        // 3.校验
        if ("admin".equals(auth)) {
            // 放行
            return chain.filter(exchange);
        }
        // 4.拦截
        // 4.1.禁止访问，设置状态码
        exchange.getResponse().setStatusCode(HttpStatus.FORBIDDEN);
        // 4.2.结束处理
        return exchange.getResponse().setComplete();
    }
}
```

###### 测试

可以使用 Postman 工具进行测试。

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br>
</div>

## 7.6	过滤器执行顺序

##### 过滤器链

请求进入网关会碰到三类过滤器：当前路由的过滤器、DefaultFilter、GlobalFilter。请求路由后，会将当前路由过滤器和 DefaultFilter、GlobalFilter，合并到一个过滤器链（集合）中，排序后依次执行每个过滤器：

<img src="img/7.6-1.png" alt="image-20210714214228409" style="zoom:50%;" />

<br>

##### 路由的过滤器、DefaultFilter、GlobalFilter 的合并原理

详细内容，可以查看源码：`org.springframework.cloud.gateway.route.RouteDefinitionRouteLocator#getFilters()`方法是先加载 defaultFilters，然后再加载某个route的filters，然后合并。

`org.springframework.cloud.gateway.handler.FilteringWebHandler#handle()` 方法会加载全局过滤器，与前面的过滤器合并后根据order排序，组织过滤器链

<br>

##### 过滤器链排序的规则

- 每一个过滤器都必须指定一个 int 类型的 order 值，**order 值越小，优先级越高，执行顺序越靠前**。
- GlobalFilter  通过实现 Ordered 接口，或者添加 @Order 注解来指定order值，由我们自己指定。
- 路由过滤器和 defaultFilter 的 order 由 Spring 指定，默认是 **按照声明顺序从1递增**。
- 当过滤器的 order 值一样时，会按照 defaultFilter > 路由过滤器 > GlobalFilter 的顺序执行。

<br>

##### 示例 —— 设置 GlobalFilter  的 order 值

###### 方式一 —— 实现 Ordered 接口

```java
@Component
public class AuthorizeFilter implements GlobalFilter {
    
    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
       
       ......
       
    }
    
    //将 order 值设为 -1
    @Override
    public int getOrder() {
        return -1;
    }
}
```

###### 方式二 —— 者添加 @Order 注解

```java
@Order(-1)
@Component
public class AuthorizeFilter implements GlobalFilter {
    
    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
       
       ......
       
    }
    
    //将 order 值设为 -1
    @Override
    public int getOrder() {
        return -1;
    }
}
```

<br>

---





## 7.7	跨域问题

##### 什么是跨域问题

域名不一致就是跨域，主要包括：

- 域名不同： www.taobao.com 和 www.taobao.org 和 www.jd.com 和 miaosha.jd.com

- 域名相同，端口不同：localhost:8080 和 localhost:8081

跨域问题：浏览器禁止请求的发起者与服务端发生跨域 ajax 请求，导致请求被浏览器拦截。

<br>

##### 跨域问题的解决方案

CORS，这个以前应该学习过，这里不再赘述了。不知道的小伙伴可以查看https://www.ruanyifeng.com/blog/2016/04/cors.html

<br>

##### 模拟跨域问题

找到课前资料的页面文件：

![image-20210714215713563](img/image-20210714215713563.png)

放入 tomcat 或者 nginx 这样的 web 服务器中，启动并访问。

可以在浏览器控制台看到下面的错误：

![image-20210714215832675](img/image-20210714215832675.png)



从localhost:8090访问localhost:10010，端口不同，显然是跨域的请求。

<br>

##### 解决跨域问题

在 gateway 服务的 application.yml 文件中，添加下面的配置：

```yaml
spring:
  cloud:
    gateway:
      # 。。。
      globalcors: # 全局的跨域处理
        add-to-simple-url-handler-mapping: true # 解决options请求被拦截问题
        corsConfigurations:
          '[/**]':
            allowedOrigins: # 允许哪些网站的跨域请求 
              - "http://localhost:8090"
            allowedMethods: # 允许的跨域ajax的请求方式
              - "GET"
              - "POST"
              - "DELETE"
              - "PUT"
              - "OPTIONS"
            allowedHeaders: "*" # 允许在请求中携带的头信息
            allowCredentials: true # 是否允许携带cookie
            maxAge: 360000 # 这次跨域检测的有效期
```









