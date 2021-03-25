# 1	ThinkPHP

## 1.1	概述

##### ThinkPHP 简介

- ThinkPHP是一个免开源的、快速简单的、面向对象的 **轻量级PHP开发框架**，是为了敏捷 WEB 应用开发和简化企业应用开发而生。ThinkPHP从诞生以来一直秉承简洁实用的设计原则，在保持出色的性能和至简代码的同时，更注重易用性。


##### ThinkPHP 的开源协议

- ThinkPHP 遵循 `Apache2` 开源许可协议发布，意味着你可以免费使用 ThinkPHP，甚至允许把你基于 ThinkPHP 开发的应用开源或商业产品发布/销售。


##### ThinkPHP 6.0 主要新特性

1. 采用 PHP7 强类型（严格模式）
2. 支持更多的 PSR 规范
3. 多应用支持
4. `ORM` 组件独立
5. 改进的中间件机制
6. 更强大和易用的查询
7. 全新的事件系统
8. 支持容器 `invoke` 回调
9. 模板引擎组件独立
10. 内部功能中间件化
11. SESSION 机制改进
12. 缓存及日志支持多通道
13. 引入 `Filesystem` 组件
14. 对 `Swoole` 以及协程支持改进
15. 对 IDE 更加友好。
16. 统一和精简大量用法。


---

<div STYLE="page-break-after: always;"></div>

## 1.2	Hello World

### 1.2.1	Windows 环境下安装 ThinkPHP6.0

##### 步骤

1. 下载并安装 Composer[^Composer]。

2. 如果是第一次安装，切换到 WEB 根目录下面并执行下面的命令：

   ```shell
   #安装稳定版 ThinkPHP
   composer create-project topthink/think tp
   ```

3. 开启调试模式。由于应用默认是部署模式，在开发阶段，可以修改环境变量 `APP_DEBUG` 开启调试模式，上线部署后切换到部署模式。


##### .env 文件

- **说明**：环境变量文件。本地开发时可以在应用根目录下面定义 `.env` 文件。
- **.example.env 文件**：通过 Composrer 的 `create-project` 命令安装 ThinkPHP 后，在根目录会自带一个 `.example.env` 文件（环境变量示例文件），你可以直接更名为 `.env` 文件并根据你的要求进行修改。*（该示例文件已经开启调试模式）*


---

<div STYLE="page-break-after: always;"></div>

### 1.2.2	测试运行

##### 步骤

1. 进入命令行下面，执行下面指令

   ```shell
   php think run
   ```

2. 在浏览器中输入地址：

   ```php
   http://localhost:8000/
   ```

3. 进入欢迎页面。


---

<div STYLE="page-break-after: always;"></div>

## 1.3	ThinkPHP 编程规范

##### 目录和文件

- 目录使用小写 + 下划线；
- 类库、函数文件统一以 `.php` 为后缀；
- 类的文件名均以命名空间定义，并且命名空间的路径和类库文件所在路径一致；
- 类*（包含接口和 Trait）*文件采用驼峰法命名*（首字母大写）*，其它文件采用小写 + 下划线命名；
- 类名*（包括接口和 Trait）*和文件名保持一致，统一采用驼峰法命名（首字母大写）；


##### 函数和类、属性命名

- 类的命名采用驼峰法*（首字母大写）*，例如 `User`、`UserType`；
- 函数的命名使用小写字母和下划线（小写字母开头）的方式，例如 `get_client_ip`；
- 方法的命名使用驼峰法（首字母小写），例如 `getUserName`；
- 属性的命名使用驼峰法（首字母小写），例如 `tableName`、`instance`；
- 特例：以双下划线`__`打头的函数或方法作为魔术方法，例如 `__call` 和 `__autoload`；


##### 常量和配置

- 常量以大写字母和下划线命名，例如 `APP_PATH`；
- 配置参数以小写字母和下划线命名，例如 `url_route_on` 和`url_convert`；
- 环境变量定义使用大写字母和下划线命名，例如 `APP_DEBUG`；


##### 数据表和字段

- 数据表和字段采用小写加下划线方式命名，并注意字段名不要以下划线开头，例如 `think_user` 表和 `user_name`字段，不建议使用驼峰和中文作为数据表及字段命名。


---

<div STYLE="page-break-after: always;"></div>

## 1.4	目录结构

### 1.4.0	ThinkPHP 目录结构

##### 📌ThinkPHP 6.0 多应用部署

- ThinkPHP 6.0 支持多应用模式部署，实际的目录结构取决于采用的是单应用还是多应用模式。


##### 📌ThinkPHP 部署注意事项

1. 在实际的部署中，请确保只有public目录可以对外访问。
2. 在 mac 或者 linux 环境下面，注意需要设置 runtime 目录权限为 777。


---

<div STYLE="page-break-after: always;"></div>

### 1.4.1	单应用模式

##### 说明

- 默认安装后的目录结构就是一个单应用模式。


##### 应用结构

```
www  WEB部署目录（或者子目录）
├─app           应用目录
│  ├─controller      控制器目录
│  ├─model           模型目录
│  ├─ ...            更多类库目录
│  │
│  ├─common.php         公共函数文件
│  └─event.php          事件定义文件
│
├─config                配置目录
│  ├─app.php            应用配置
│  ├─cache.php          缓存配置
│  ├─console.php        控制台配置
│  ├─cookie.php         Cookie配置
│  ├─database.php       数据库配置
│  ├─filesystem.php     文件磁盘配置
│  ├─lang.php           多语言配置
│  ├─log.php            日志配置
│  ├─middleware.php     中间件配置
│  ├─route.php          URL和路由配置
│  ├─session.php        Session配置
│  ├─trace.php          Trace配置
│  └─view.php           视图配置
│
├─view            视图目录
├─route                 路由定义目录
│  ├─route.php          路由定义文件
│  └─ ...   
│
├─public                WEB目录（对外访问目录）
│  ├─index.php          入口文件
│  ├─router.php         快速测试文件
│  └─.htaccess          用于apache的重写
│
├─extend                扩展类库目录
├─runtime               应用的运行时目录（可写，可定制）
├─vendor                Composer类库目录
├─.example.env          环境变量示例文件
├─composer.json         composer 定义文件
├─LICENSE.txt           授权说明文件
├─README.md             README 文件
├─think                 命令行入口文件
```


---

<div STYLE="page-break-after: always;"></div>

### 1.4.2	多应用模式

##### 说明

- 如果你需要一个多应用的项目架构，目录结构可以参考下面的结构进行调整（关于配置文件的详细结构参考后面章节）。


##### 项目结构

```
www  WEB部署目录（或者子目录）
├─app           应用目录
│  ├─app_name           应用目录
│  │  ├─common.php      函数文件
│  │  ├─controller      控制器目录
│  │  ├─model           模型目录
│  │  ├─view            视图目录
│  │  ├─config          配置目录
│  │  ├─route           路由目录
│  │  └─ ...            更多类库目录
│  │
│  ├─common.php         公共函数文件
│  └─event.php          事件定义文件
│
├─config                全局配置目录
│  ├─app.php            应用配置
│  ├─cache.php          缓存配置
│  ├─console.php        控制台配置
│  ├─cookie.php         Cookie配置
│  ├─database.php       数据库配置
│  ├─filesystem.php     文件磁盘配置
│  ├─lang.php           多语言配置
│  ├─log.php            日志配置
│  ├─middleware.php     中间件配置
│  ├─route.php          URL和路由配置
│  ├─session.php        Session配置
│  ├─trace.php          Trace配置
│  └─view.php           视图配置
│
├─public                WEB目录（对外访问目录）
│  ├─index.php          入口文件
│  ├─router.php         快速测试文件
│  └─.htaccess          用于apache的重写
│
├─extend                扩展类库目录
├─runtime               应用的运行时目录（可写，可定制）
├─vendor                Composer类库目录
├─.example.env          环境变量示例文件
├─composer.json         composer 定义文件
├─LICENSE.txt           授权说明文件
├─README.md             README 文件
├─think                 命令行入口文件
```


##### 📌多应用部署的注意点

- 多应用模式部署后，需要删除 app 目录下的 controller 目录*（系统根据该目录作为判断是否单应用的依据）*。


---

<div STYLE="page-break-after: always;"></div>

### 1.4.3	默认应用文件

##### 说明

- 默认安装后，`app`目录下会包含以下文件：

  ```
  ├─app           应用目录
  │  │
  │  ├─BaseController.php    默认基础控制器类
  │  ├─ExceptionHandle.php   应用异常定义文件
  │  ├─common.php            全局公共函数文件
  │  ├─middleware.php        全局中间件定义文件
  │  ├─provider.php          服务提供定义文件
  │  ├─Request.php           应用请求对象
  │  └─event.php             全局事件定义文件
  ```


##### 📌默认配置文件使用注意点

1. `BaseController.php`、`Request.php` 和`ExceptionHandle.php`三个文件是系统默认提供的基础文件，位置你可以随意移动，但注意要同步调整类的命名空间。
2. 如果不需要使用`Request.php` 和`ExceptionHandle.php`文件，或者要调整类名，必须同步调整`provider.php`文件中的容器对象绑定。


##### 📌provider.php

- `provider.php`服务提供定义文件只能全局定义，不支持在应用下单独定义。


---

<div STYLE="page-break-after: always;"></div>

## 1.5	配置文件

### 1.5.0	概述

##### ThinkPHP 配置文件

- **ThinkPHP 的配置文件有两种形式**：
  1. **.env 文件**：. env 环境变量用于本地开发测试，部署后会被忽略
  2. **根目录下的 config**：有很多类型的配置，适用于部署;

---

<div STYLE="page-break-after: always;"></div>

### 1.5.1	开启调试模式

##### 开启调试模式的方法

- **第一种方法**：直接将根目录下的 `.example.env` 文件修改为 `.env` 文件，该文件中默认开启了调试模式。
- 第二种方法：在 `.env` 文件中修改 `APP_DEBUG` 属性为 `true` 。

##### 开启调试模式后的好处

1. 记录系统运行流程的执行过程;
2. 展示错误和调试信息，并开启日志记录;
3. 模版修改可以及时生效(不会被缓存干扰);
4. 启动右下角的Trace调试功能，更加强大;
5. 发生异常时，也会显示异常信息。

##### 📌关闭调试模式时，显示简要的错误提示信息

1. 首先，关闭调试模式 `APP_ DEBUG = false`;
2. 然后，根目录下 `config` 的 `app. php` 最后一项设置为: `show_ error_ msg => true`

---

<div STYLE="page-break-after: always;"></div>

### 1.5.2	获取配置文件的值

##### 例——获取 .env 文件的值

```php
<?php
namespace app\controller;
use think\facade\Env;

class test
{
    public function index(){
        return Env::get('database.hostname');
    }

    //判断 .env 配置文件是否存在
    public function has(){
        echo Env::has('database.hostname');
    }
}
```

##### 例——获取 config 文件中的值

```php
<?php
namespace app\controller;
use think\facade\Config;

class test
{
    public function index(){
        return Config::get('database.connections.mysql.hostname');
    }
    
    //判断 .env 配置文件是否存在
    public function has(){
        echo Config::has('database.connections.mysql.hostname');
    }
}
```

---

<div STYLE="page-break-after: always;"></div>

# 2	框架架构

## 2.1	请求流程

##### 说明

- 对于一个HTTP应用来说，从用户发起请求到响应输出结束，大致的标准请求流程如下：
  1. 载入 `Composer` 的自动加载 `autoload` 文件
  2. 实例化系统应用基础类 `think\App`
  3. 获取应用目录等相关路径信息
  4. 加载全局的服务提供 `provider.php` 文件
  5. 设置容器实例及应用对象实例，确保当前容器对象唯一
  6. 从容器中获取 `HTTP` 应用类 `think\Http`
  7. 执行 `HTTP` 应用类的 `run` 方法启动一个 `HTTP` 应用
  8. 获取当前请求对象实例（默认为 `app\Request` 继承 `think\Request`）保存到容器
  9. 执行 `think\App` 类的初始化方法 `initialize`
  10. 加载环境变量文件 `.env` 和全局初始化文件
  11. 加载全局公共文件、系统助手函数、全局配置文件、全局事件定义和全局服务定义
  12. 判断应用模式（调试或者部署模式）
  13. 监听 `AppInit` 事件
  14. 注册异常处理
  15. 服务注册
  16. 启动注册的服务
  17. 加载全局中间件定义
  18. 监听 `HttpRun` 事件
  19. 执行全局中间件
  20. 执行路由调度（`Route`类`dispatch`方法）
  21. 如果开启路由则检查路由缓存
  22. 加载路由定义
  23. 监听`RouteLoaded`事件
  24. 如果开启注解路由则检测注解路由
  25. 路由检测（中间流程很复杂 略）
  26. 路由调度对象`think\route\Dispatch`初始化
  27. 设置当前请求的控制器和操作名
  28. 注册路由中间件
  29. 绑定数据模型
  30. 设置路由额外参数
  31. 执行数据自动验证
  32. 执行路由调度子类的`exec`方法返回响应`think\Response`对象
  33. 获取当前请求的控制器对象实例
  34. 利用反射机制注册控制器中间件
  35. 执行控制器方法以及前后置中间件
  36. 执行当前响应对象的`send`方法输出
  37. 执行HTTP应用对象的`end`方法善后
  38. 监听`HttpEnd`事件
  39. 执行中间件的`end`回调
  40. 写入当前请求的日志信息


---

<div STYLE="page-break-after: always;"></div>

## 2.2	架构总览

##### 入口文件

- **说明**：用户请求的 PHP 文件，负责处理请求*（注意，不一定是 HTTP 请求）*的生命周期，入口文件位于 `public` 目录下面。最常见的入口文件是 `index.php`。
- **多应用多入口**：`6.0` 支持多应用多入口，你可以给每个应用增加入口文件，例如给后台应用单独设置的一个入口文件 `admin.php`。但是，如果开启自动多应用的话，一般只需要一个入口文件`index.php`。


##### 多应用

- `6.0` 版本提供了对多应用的良好支持，每个应用是一个 `app` 目录的子目录*（或者指定的 `composer` 库）*，每个应用具有独立的路由、配置，以及 MVC 相关文件，这些应用可以公用框架核心以及扩展。而且可以支持 `composer` 应用加载。


##### 容器

- **容器的作用：**ThinkPHP 使用 **容器（对象容器）**统一管理对象实例及依赖注入。
- **容器的实现原理**：容器类的工作由 `think\Container` 类完成，但大多数情况下我们都是通过应用类（`think\App`类）或是`app`助手函数来完成容器操作，容器中所有的对象实例都可以通过容器标识单例调用，你可以给容器中的对象实例绑定一个对象标识，如果没有绑定则使用类名作为容器标识。


##### 系统服务

- **说明**：系统服务指 **在执行框架的某些组件或者功能的时候需要依赖的一些基础服务**。服务类通常可以继承系统的 `think\Service` 类，但并不强制。
- **利用系统服务完成相关依赖的注入**：你可以在系统服务中注册一个对象到容器，或者对某些对象进行相关的依赖注入。由于系统服务的执行优先级问题，可以确保相关组件在执行的时候已经完成相关依赖注入。


##### 路由

- **说明**：路由是用于规划*（一般同时也会进行简化）*请求的访问地址，在访问地址和实际操作方法之间建立一个 `路由规则 => 路由地址的映射` 关系。
- **在 ThinkPHP 中使用路由**：ThinkPHP 并非强制使用路由，如果没有定义路由，则可以直接使用“控制器/操作”的方式访问，如果定义了路由，则该路由对应的路由地址就被不能直接访问了。一旦开启强制路由参数，则必须为每个请求定义路由（包括首页）。
- **使用路由的优点**：使用路由有一定的性能损失，但随之也更加安全，因为每个路由都有自己的生效条件，如果不满足条件的请求是被过滤的。远比在控制器的操作中进行各种判断要实用的多。路由的作用不只有规范 URL，还可以实现验证、权限、参数绑定及响应设置等功能。


##### 控制器

- **说明**：每个应用下拥有独立的类库及配置文件，一个应用下面有多个控制器负责响应请求，而每个控制器其实就是一个独立的控制器类。

- **控制器的作用**：控制器主要负责请求的接收，并调用相关的模型处理，并最终通过视图输出。严格来说，控制器不应该过多的介入业务逻辑处理。

- **通过路由跳过控制器**：事实上，控制器是可以被跳过的，通过路由我们可以直接把请求调度到某个模型或者其他的类进行处理。

- **ThinkPHP 的控制器**：`ThinkPHP` 的控制器类比较灵活，可以无需继承任何基础类库。但是，一般建议继承一个基础的控制器，方便扩展。系统默认提供了一个`app\BaseController`控制器类。

- **一个典型的 `Index` 控制器类（单应用模式）**：

  ```php
  <?php
  namespace app\controller;
  
  class Index 
  {
      public function index()
      {
          return 'hello,thinkphp!';
      }
  }
  ```


##### 操作

- **说明**：一个控制器包含多个操作（方法），操作方法是一个 URL 访问的最小单元。

- **一个典型的 `Index` 控制器的操作方法定义**

  ```php
  <?php
  namespace app\controller;
  
  //包含两个操作方法的控制器
  class Index 
  {
      public function index()
      {
          return 'index';
      }
      
      public function hello(string $name)
      {
          return 'Hello,'.$name;
      }
  }
  ```

- **操作方法的参数**：操作方法可以不使用任何参数，如果定义了一个非可选参数，并且不是对象类型，则该参数必须通过用户请求传入，如果是URL请求，则通常是通过当前的请求传入，操作方法的参数支持依赖注入。


##### 模型

- **说明**：模型类通常完成实际的业务逻辑和数据封装，并返回和格式无关的数据。*（模型类并不一定要访问数据库，而且在 ThinkPHP 的架构设计中，只有进行实际的数据库查询操作的时候，才会进行数据库的连接，是真正的惰性连接。）*

- **模型层分层设计**：ThinkPHP 的模型层支持多层设计，你可以对模型层进行更细化的设计和分工，例如把模型层分为逻辑层/服务层/事件层等等。

- **模型类通常需要继承 `think\Model` 类，一个典型的 `User` 模型器类如下**

  ```php
  <?php
  namespace app\model;
  
  use think\Model;
  
  class User extends Model
  {
  }
  ```


##### 视图

- **视图的作用**：控制器调用模型类后，返回的数据通过视图组装成不同格式的输出。视图根据不同的需求，来决定<u>直接输出</u>还是<u>调用模板引擎进行内容解析后输出</u>。
- **视图与模板**：视图通常会有一系列的模板文件对应不同的控制器和操作方法，并且支持动态设置模板目录。


##### 模板引擎

- **模板引擎的作用**：模板文件中可以使用一些特殊的模板标签，这些标签的解析通常由模板引擎负责实现。
- **ThinkPHP 新版本不再内置模板引擎**：新版不再内置 `think-template` 模板引擎，如果需要使用 ThinkPHP 官方模板引擎，需要单独安装 `think-view` 模板引擎驱动扩展。


##### 驱动

- **驱动的作用**：系统很多的组件都采用驱动式设计，从而可以更灵活的扩展，驱动类的位置默认是放入核心类库目录下面，也可以重新定义驱动类库的命名空间而改变驱动的文件位置。
- **ThinkPHP 6.0 的驱动**：`6.0` 版本的驱动采用 `Composer` 的方式安装和管理。


##### 中间件

- 中间件主要用于拦截或过滤应用的 `HTTP` 请求，并进行必要的业务处理。*（新版部分核心功能使用中间件处理，你可以灵活关闭。包括Session功能、请求缓存和多语言功能。）*


##### 事件

- `6.0` 已经使用事件机制替代原来的行为和 Hook 机制，可以在应用中使用事件机制的特性来扩展功能。此外数据库操作和模型操作在完成数据操作的回调机制，也使用了事件机制。


##### 助手函数

- 系统为一些常用的操作提供了助手函数支持。使用助手函数和性能并无直接影响，只是某些时候无法享受IDE自动提醒的便利，但是否使用助手函数看项目自身规范，在应用的公共函数文件中也可以对系统提供的助手函数进行重写。


---

<div STYLE="page-break-after: always;"></div>

## 2.3	入口文件

##### 说明

- ThinkPHP 6.0 采用单一入口模式进行项目部署和访问，一个应用都有一个统一（但不一定是唯一）的入口。如果采用自动多应用部署的话，一个入口文件还可以自动对应多个应用。


##### 入口文件定义

- **入口文件的默认位置**：默认的应用入口文件位于`public/index.php`

- **入口文件的默认内容如下**：

  ```php
  // [ 应用入口文件 ]
  namespace think;
  
  require __DIR__ . '/../vendor/autoload.php';
  
  // 执行HTTP应用并响应
  $http = (new App())->http;
  $response = $http->run();
  $response->send();
  $http->end($response);
  ```

- 📌**注意**：

  1. 如果你没有特殊的自定义需求，无需对入口文件做任何的更改。
  2. 入口文件位置的设计是为了让应用部署更安全，请尽量遵循 public 目录为唯一的 web 可访问目录，其他的文件都可以放到非 WEB 访问目录下面。


##### 控制台入口文件

- **说明**：除了应用入口文件外，系统还提供了一个控制台入口文件，即位于项目根目录的 `think`（注意该文件没有任何的后缀）。

- **控制台入口文件的代码如下**：

  ```php
  #!/usr/bin/env php
  <?php
  namespace think;
  
  // 加载基础文件
  require __DIR__ . '/vendor/autoload.php';
  
  // 应用初始化
  (new App())->console->run();
  ```

- **控制台入口文件的作用**：控制台入口文件用于执行控制台指令（如 `php think version`）。系统内置了一些常用的控制台指令，如果你安装了额外的扩展，也会增加相应的控制台指令，都是通过该入口文件执行的。


---

<div STYLE="page-break-after: always;"></div>

## 2.4	多应用模式

##### 单应用模式的优点

- 单应用模式的优势是简单灵活，URL地址完全通过路由可控。配合路由分组功能可以实现类似多应用的灵活机制。


##### 使用多应用模式

1. 安装多应用模式扩展 `think-multi-app`。

2. 对应用目录结构做出调整，主要区别在 `app` 目录下增加了应用子目录，然后将配置文件和路由定义文件都纳入应用目录下。

   ```
   ├─app 应用目录
   │  ├─index              主应用
   │  │  ├─controller      控制器目录
   │  │  ├─model           模型目录
   │  │  ├─view            视图目录
   │  │  ├─config          配置目录
   │  │  ├─route           路由目录
   │  │  └─ ...            更多类库目录
   │  │ 
   │  ├─admin              后台应用
   │  │  ├─controller      控制器目录
   │  │  ├─model           模型目录
   │  │  ├─view            视图目录
   │  │  ├─config          配置目录
   │  │  ├─route           路由目录
   │  │  └─ ...            更多类库目录
   │
   ├─public                WEB目录（对外访问目录）
   │  ├─admin.php          后台入口文件
   │  ├─index.php          入口文件
   │  ├─router.php         快速测试文件
   │  └─.htaccess          用于apache的重写
   │
   ├─config                全局应用配置目录
   ├─runtime               运行时目录
   │  ├─index              index应用运行时目录
   │  └─admin              admin应用运行时目录
   ```


##### 自动多应用部署

- **自动多应用部署的触发条件**：ThinkPHP 6.0 支持在同一个入口文件中访问多个应用，并且支持应用的映射关系以及自定义。如果你通过 `index.php` 入口文件访问的话，并且没有设置应用 `name`，系统自动采用自动多应用模式。

- **自动多应用模式的默认 URL 地址为** ：

  ```http
  // 访问admin应用
  http://serverName/index.php/admin
  // 访问shop应用
  http://serverName/index.php/shop
  ```

  - 即 `pathinfo` 地址的第一个参数就表示当前的应用名，后面才是该应用的路由或者控制器/操作。

- **通过配置文件 `app.php` 的配置参数 `default_app` 指定默认应用 URL 地址**：

  ```php
  // 设置默认应用名称
  'default_app' => 'home',
  ```

- 📌**注意**：

  - 自动多应用模式下，每个应用的路由是独立的，所以你没法省略URL里面的应用参数。但可以使用域名绑定解决。


##### 多应用自动识别

- **多应用自动识别机制**：如果在没有绑定入口或者域名的情况下，URL 里面的应用不存在，此时系统会自动切换到单应用模式；如果定义了全局的路由，则会进行路由匹配检查。

- **访问默认路由**：如果你希望  应用不存在的时候，直接访问默认应用的路由，可以在`app.php`中配置：

  ```php
  // 开启应用快速访问
  'app_express'    =>    true,
  // 默认应用
  'default_app'    =>    'home',
  ```


##### 增加应用入口

- **通过应用各自的入口文件访问应用**：ThinkPHP 6.0  允许为每个应用创建单独的入口文件而不通过  `index.php`  入口文件访问多个应用，例如创建一个 `admin.php` 入口文件来访问 `admin` 应用：

  ```php
  // [ 应用入口文件 ]
  namespace think;
  
  require __DIR__ . '/../vendor/autoload.php';
  
  // 执行HTTP应用并响应
  $http = (new  App())->http;
  $response = $http->run();
  $response->send();
  $http->end($response);
  ```

- **使用多应用入口时的应用名**：多应用使用不同的入口的情况下，每个入口文件的内容都是一样的，默认入口文件名（不含后缀）就是应用名。

- **应用名与应用入口文件名不同时，需要进行的操作**：

  ```php
  // [ 应用入口文件 ]
  namespace think;
  
  require __DIR__ . '/../vendor/autoload.php';
  
  // 执行HTTP应用并响应
  $http = (new  App())->http;
  $response = $http->name('admin')->run();//❗❗❗主要改动
  $response->send();
  $http->end($response);
  ```


##### 获取当前应用

- 如果需要获取当前的应用名，可以使用：

  ```php
  app('http')->getName();
  ```

##### 📌ThinkPHP 6.0 种的重要系统路径

- 单应用和多应用模式会影响一些系统路径的值，为了更好的理解 ThinkPHP 6.0，你可能需要理解下面几个系统路径所表示的位置：

  | 目录位置   | 目录说明                                                     | 获取方法（助手函数） |
  | :--------- | :----------------------------------------------------------- | :------------------- |
  | 根目录     | 项目所在的目录，默认自动获取，可以在入口文件实例化`App`类的时候传入。 | `root_path()`        |
  | 基础目录   | 根目录下的`app`目录                                          | `base_path()`        |
  | 应用目录   | 当前应用所在的目录，如果是单应用模式则同基础目录，如果是多应用模式，则是`app`/应用子目录 | `app_path()`         |
  | 配置目录   | 根目录下的`config`目录                                       | `config_path()`      |
  | 运行时目录 | 框架运行时的目录，单应用模式就是根目录的`runtime`目录，多应用模式为`runtime`/应用子目录 | `runtime_path()`     |


##### 应用目录获取

- 对于非自动多应用部署的情况，如果要加载 `composer` 应用，需要在入口文件中设置应用路径：

  ```PHP
  // [ 应用入口文件 ]
  namespace think;
  
  require __DIR__ . '/../vendor/autoload.php';
  
  // 执行HTTP应用并响应
  $http = (new  App())->http;
  $response = $http->path('path/to/app')->run();
  $response->send();
  $http->end($response);
  ```

- 📌**注意**：

  - 由于应用支持使用`composer`包，此时目录可能是 `composer` 包的类库所在目录。


##### 应用映射

-  **说明**

  - 自动多应用模式下，支持在 `config/app.php` 配置文件中进行应用的别名映射，例如：

    ```php
    'app_map' => [
        'think'  =>  'admin',  // 把admin应用映射为think
    ],
    ```

- **泛解析**：

  - 应用映射支持泛解析，例如：

    ```
    'app_map' => [
        'think' =>  'admin',  
        'home'  =>  'index',  
        '*'     =>  'index',  
    ],
    ```

- 📌**注意**

  - 应用映射后，原来的应用名将不能被访问，例如上面的 `admin` 应用不能直接访问，只能通过 `think` 应用访问。
  - 表示如果 URL 访问的应用不在当前设置的映射里面，则自动映射为`index`应用。

- **使用 `composer` 加载应用需要进行的设置**

  ```
  'app_map'    =>    [
      'think' => function($app) {
          $app->http->path('path/to/composer/app');
      },
  ],
  ```


##### 域名绑定应用

- 如果你的多应用使用多个子域名或者独立域名访问，你可以在 `config/app.php` 配置文件中定义域名和应用的绑定。

  ```php
  'domain_bind' => [
      'blog'        =>  'blog',  //  blog子域名绑定到blog应用
      'shop.tp.com' =>  'shop',  //  完整域名绑定
      '*'           =>  'home', // 二级泛域名绑定到home应用
  ],
  ```


##### 禁止应用访问

- 你如果不希望某个应用通过URL访问，例如，你增加了一个`common`子目录用于放置一些公共类库，你可以设置

  ```php
  'deny_app_list' =>    ['common']
  ```


##### 自定义多应用模式

- 多应用模式并非核心内置模式，官方提供的多应用扩展更多是抛砖引玉，你完全可以通过中间件来扩展适合自己的多应用模式。


---

<div STYLE="page-break-after: always;"></div>

## 2.6	容器和依赖注入

##### 说明

- ThinkPHP 使用容器来更方便的管理类依赖及运行依赖注入，新版的容器支持 PSR-11 规范。


##### 容器操作

- 容器类的工作由 `think\Container` 类完成，但大多数情况我们只需要通过 `app` 助手函数或者 `think\App` 类即可容器操作，如果在服务类中可以直接调用 `this->app` 进行容器操作。


##### 依赖注入的本质

- **说明**：依赖注入其实本质上是指对类的依赖通过构造器完成自动注入，例如在控制器架构方法和操作方法中一旦对参数进行对象类型约束则会自动触发依赖注入，由于访问控制器的参数都来自于 URL 请求，普通变量就是通过参数绑定自动获取，对象变量则是通过依赖注入生成。

- **例**

  ```php
  <?php
  namespace app\controller;
  
  use think\Request;
  
  class Index
  {
      protected $request;
  
      public function __construct(Request $request)
      {
          $this->request = $request;
      }
  
      public function hello($name)
      {
          return 'Hello,' . $name . '！This is '. $this->request->action();
      }
  }
  ```

- 📌**注意**：

  - 依赖注入的对象参数支持多个，并且和顺序无关。


##### 支持使用依赖注入的场景包括（但不限于）

- 控制器架构方法；
- 控制器操作方法；
- 路由的闭包定义；
- 事件类的执行方法；
- 中间件的执行方法；


##### 依赖注入自定义的类以及方法

- **说明**：对于自定义的类以及方法，如果需要使用依赖注入，需要使用系统提供的`invoke`助手函数调用。

- **例**：

  ```php
  class Foo 
  {
      public function __construct(Bar $bar)
      {
      }
  }
  ```

  ```php
  //直接通过 new 实例化
  
  $bar = new Bar(); 
  //需要手动传入Bar对象实例
  $foo = new Foo($bar);
  ```

  ```php
  //使用容器实例化
  $foo = invoke('Foo');//自动进行依赖注入
  ```

  ```php
  
  class Foo 
  {
      public function bar(Bar $bar)
      {
          // ...
      }
  }
  //对方法进行依赖注入
  $result = invoke(['Foo', 'bar']);
  ```

  ```php
  //对函数或者闭包使用依赖注入
  $result = invoke(function(Bar $bar) {
      // ...
  });
  ```


##### 绑定

- **说明**依赖注入的类统一由容器进行管理，大多数情况下是在自动绑定并且实例化的。不过你可以随时手动绑定类到容器中（通常是在服务类的 register 方法中进行绑定），支持多种绑定方式。

- **绑定类标识**：可以对已有的类库绑定一个唯一标识，便于快速调用。*（绑定的类标识可以自定义，只要不会发生冲突即可。）*

  ```php
  // 绑定类库标识
  $this->app->bind('think\Cache', 'app\common\Cache');
  ```

  或者使用助手函数

  ```php
  // 绑定类库标识
  bind('cache', 'think\Cache');
  ```

- **绑定闭包**：可以绑定一个闭包到容器中：

  ```php
  bind('sayHello', function ($name) {
      return 'hello,' . $name;
  });
  ```

- **绑定实例**：也可以直接绑定一个类的实例：

  ```php
  $cache = new think\Cache;
  // 绑定类实例
  bind('cache', $cache);
  ```

- **绑定至接口实现**：对于依赖注入使用接口类的情况，我们需要告诉系统使用哪个具体的接口实现类来进行注入，这个使用可以把某个类绑定到接口：

  ```php
  // 绑定think\LoggerInterface接口实现到think\Log
  bind('think\LoggerInterface','think\Log');
  ```

  使用接口作为依赖注入的类型：

  ```php
  <?php
  namespace app\index\controller;
  
  use think\LoggerInterface;
  
  class Index
  {
      public function hello(LoggerInterface $log)
      {
      	$log->record('hello,world!');
      }	
  }
  ```

- **批量绑定**：在实际应用开发过程，不需要手动绑定，我们只需要在`app`目录下面定义`provider.php`文件（只能在全局定义，不支持应用单独定义），系统会自动批量绑定类库到容器中。

  ```php
  return [
      'route'      => \think\Route::class,
      'session'    => \think\Session::class,
      'url'        => \think\Url::class,
  ];
  ```

- **系统内置绑定的核心常用类库**：对于系统已经内置绑定的核心常用类库，无需重复绑定。系统内置绑定到容器中的类库包括：

  | 系统类库         | 容器绑定标识 |
  | :--------------- | :----------- |
  | think\App        | app          |
  | think\Cache      | cache        |
  | think\Config     | config       |
  | think\Cookie     | cookie       |
  | think\Console    | console      |
  | think\Db         | db           |
  | think\Debug      | debug        |
  | think\Env        | env          |
  | think\Event      | event        |
  | think\Http       | http         |
  | think\Lang       | lang         |
  | think\Log        | log          |
  | think\Middleware | middleware   |
  | think\Request    | request      |
  | think\Response   | response     |
  | think\Filesystem | filesystem   |
  | think\Route      | route        |
  | think\Session    | session      |
  | think\Validate   | validate     |
  | think\View       | view         |


##### 解析

- **解析的作用**：使用 app 助手函数进行容器中的类解析调用，对于已经绑定的类标识，会自动快速实例化。

  ```php
  $cache = app('cache');
  
  //带参数实例化调用
  $cache = app('cache',['file']);
  
  //对于没有绑定的类，也可以直接解析
  $arrayItem = app('org\utils\ArrayItem');
  ```

- **类自动使用单例**：容器中已经调用过的类会自动使用单例，除非你使用下面的方式强制重新实例化。

  ```php
  // 每次调用都会重新实例化
  $cache = app('cache', [], true);
  ```


##### 对象化调用

- **使用 `app` 助手函数获取容器中的对象实例（支持依赖注入）**

  ```php
  $app = app();
  // 判断对象实例是否存在
  isset($app->cache);
  
  // 注册容器对象实例
  $app->cache = think\Cache::class;
  
  // 获取容器中的对象实例
  $cache = $app->cache;
  ```


##### 📌推荐使用依赖注入

- 也就是说，你可以在任何地方使用 `app()` 方法调用容器中的任何类，但大多数情况下，我们更建议使用依赖注入。

  ```
  // 调用配置类
  app()->config->get('app_name');
  // 调用session类
  app()->session->get('user_name');
  ```


##### 自动注入

- **说明**：容器主要用于依赖注入，依赖注入会首先检查容器中是否注册过该对象实例，如果没有就会自动实例化，然后自动注入。

- **例——给路由绑定模型对象实例，然后在操作方法中自动注入User模型**

  ```php
  //给路由绑定模型对象实例
  Route::get('user/:id','index/Index/hello')
  	->model('\app\index\model\User');
  ```

  ```php
  //在操作方法中自动注入 User 模型
  <?php
  namespace app\index\controller;
  
  use app\index\model\User;
  
  class Index
  {
  
      public function hello(User $user)
      {
          return 'Hello,'.$user->name;
      }
  
  }
  ```


##### 自定义实例化

- **说明**：容器中的对象实例化支持自定义，可以在你需要依赖注入的对象中增加 __make 方法进行自定义。

- **例——使用自定义实例化的方式依赖注入 User 模型类**

  ```php
  <?php
  namespace app\index\model;
  
  use think\Model;
  use think\db\Query;
  
  class User extends Model
  {
  	public static function __make(Query $query)
      {
      	return (new self())->setQuery($query);
      }
  }
  ```


##### 容器对象回调机制

- **说明**：容器中的对象实例化之后，支持回调机制，利用该机制可以实现诸如注解功能等相关功能。

- **通过 `resolving` 方法注册一个全局回调**：

  ```php
  Container::getInstance()->resolving(function($instance,$container) {
      // ...
  });
  ```

  - 回调方法支持两个参数，第一个参数是容器对象实例，第二个参数是容器实例本身。

- **单独注册某个容器对象的回调：**

  ```php
  Container::getInstance()->resolving(\think\Cache::class,function($instance,$container) {
      // ...
  });
  ```



---

<div STYLE="page-break-after: always;"></div>

## 2.7	服务

##### 系统服务

- **说明**：系统服务的概念是指在执行框架的某些组件或者功能的时候需要依赖的一些基础服务。服务类通常可以继承系统的`think\Service`类，但并不强制（如果继承 `think\Service` 的话可以直接调用 `this->app` 获取应用实例）。
- **系统服务的应用**
  - 你可以在系统服务中注册一个对象到容器，或者对某些对象进行相关的依赖注入。由于系统服务的执行优先级问题，可以确保相关组件在执行的时候已经完成相关依赖注入。


##### 服务定义

1. **通过命令行生成一个服务类：**

   ```php
   php think make:service  FileSystemService
   ```

   - 默认生成的服务类会继承系统的`think\Service`，并且自动生成系统服务类最常用的两个空方法：`register` 和 `boot` 方法。

2. **注册方法 register**（`register`方法通常用于注册系统服务，也就是将服务绑定到容器中）：

   ```php
   <?php
   namespace app\service;
   
   use my\util\FileSystem;
   
   class FileSystemService extends Service
   {
       public function register()
       {
           $this->app->bind('file_system', FileSystem::class);
       }
   }
   ```

3. **启动方法 boot**

   - `boot` 方法是在所有的系统服务注册完成之后调用，用于定义启动某个系统服务之前需要做的操作。例如：

     ```php
     <?php
     namespace think\captcha;
     
     use think\Route;
     use think\Service;
     use think\Validate;
     
     class CaptchaService extends Service
     {
         public function boot(Route $route)
         {
             $route->get('captcha/[:config]', "\\think\\captcha\\CaptchaController@index");
     
             Validate::maker(function ($validate) {
                 $validate->extend('captcha', function ($value) {
                     return captcha_check($value);
                 }, ':attribute错误!');
             });
         }
     }
     ```


##### 服务注册

- **说明**：定义好系统服务后，你还需要注册服务到你的应用实例中。

- **定义需要注册的系统服务**：可以在应用的全局公共文件 `service.php` 中定义需要注册的系统服务，系统会自动完成注册以及启动。例如：

  ```php
  return [w
      '\app\service\ConfigService',
      '\app\service\CacheService',
  ];
  ```

- **在扩展[^?1]中注册系统服务**：如果你需要在你的扩展中注册系统服务，首先在扩展中增加一个服务类，然后在扩展的`composer.json`文件中增加如下定义：

  ```php
  "extra": {
      "think": {
          "services": [
              "think\\captcha\\CaptchaService"
          ]
      }
  },
  ```

- **安装扩展后系统服务会自动注册**：在安装扩展后会系统会自动执行 `service:discover` 指令用于生成服务列表，并在系统初始化过程中自动注册。


##### 内置服务

- 为了更好的完成核心组件的单元测试，框架内置了一些系统服务类，主要都是用于核心类的依赖注入，包括 `ModelService`、`PaginatorService` 和 `ValidateService` 类。这些服务不需要注册，并且也不能卸载。


---

<div STYLE="page-break-after: always;"></div>

## 2.8	门面

##### 说明

- 门面为容器中的类（动态类）提供了一个静态调用接口，相比于传统的静态方法调用， 带来了更好的可测试性和扩展性，你可以为任何的非静态类库定义一个`facade`类。


##### Facade 的作用

- Facade 功能可以让类无需实例化而直接进行静态方式调用。


##### 例

```php
//app\common\Test 类
<?php
namespace app\common;

class Test
{
	//动态方法 hello
    public function hello($name)
    {
        return 'hello,' . $name;
    }
}
```

```
//给 Test 类定义一个静态代理类 app\facade\Test （这个类名不一定要和 Test 类一致，但通常为了便于管理，建议保持名称统一）
<?php
namespace app\facade;

use think\Facade;

//这个类库继承 think\Facade，就可以使用静态方式调用动态类`app\common\Test`的动态方法
class Test extends Facade
{
    protected static function getFacadeClass()
    {
    	return 'app\common\Test';
    }
}
```

```
// 无需进行实例化 直接以静态方法方式调用 hello
echo \app\facade\Test::hello('thinkphp');//输出 hello，thinkphp
```


##### 核心 Facade 类库

- **说明**：系统已经为大部分核心类库定义了 Facade，所以你可以通过 Facade 来访问这些系统类。

- **系统给内置的常用类库定义的 Facade类库**：

  | （动态）类库     | Facade类                |
  | :--------------- | :---------------------- |
  | think\App        | think\facade\App        |
  | think\Cache      | think\facade\Cache      |
  | think\Config     | think\facade\Config     |
  | think\Cookie     | think\facade\Cookie     |
  | think\Db         | think\facade\Db         |
  | think\Env        | think\facade\Env        |
  | think\Event      | think\facade\Event      |
  | think\Filesystem | think\facade\Filesystem |
  | think\Lang       | think\facade\Lang       |
  | think\Log        | think\facade\Log        |
  | think\Middleware | think\facade\Middleware |
  | think\Request    | think\facade\Request    |
  | think\Response   | think\facade\Response   |
  | think\Route      | think\facade\Route      |
  | think\Session    | think\facade\Session    |
  | think\Validate   | think\facade\Validate   |
  | think\View       | think\facade\View       |


##### 例——调用系统类库

```php
use think\facade\Cache;

Cache::set('name','value');
echo Cache::get('name');
```

##### 📌在进行依赖注入的时候，不要使用 `Facade` 类作为类型约束

- **说明**在进行依赖注入的时候，请不要使用 `Facade` 类作为类型约束，而是建议使用原来的动态类。

- **错误用法示例**：

  ```php
  <?php
  namespace app\index\controller;
  
  use think\facade\App;
  
  class Index
  {
      public function index(App $app)
      {
      }
  }
  ```

- **正确用法示例**：

  ```php
  <?php
  namespace app\index\controller;
  
  use think\App;
  
  class Index
  {
      public function index(App $app)
      {
      }
  }
  ```

- **依赖注入和 Facade 在效果大多情况下相同**：事实上，**依赖注入和使用 `Facade` 代理的效果大多数情况下是一样的**，都是从容器中获取对象实例。例如：

  ```
  <?php
  namespace app\index\controller;
  
  use think\Request;
  
  class Index
  {
      public function index(Request $request)
      {
          echo $request->controller();
      }
  }
  ```

  和下面的作用是一样的：

  ```
  <?php
  namespace app\index\controller;
  
  use think\facade\Request;
  
  class Index
  {
      public function index()
      {
          echo Request::controller();
      }
  }
  ```

- **依赖注入的优势**：依赖注入的优势是**支持接口的注入**，而`Facade`则无法完成。
- 📌**注意**
  
  - **两种方式之间的区别**：一定要注意两种方式的 `use` 引入类库的区别。


---

<div STYLE="page-break-after: always;"></div>

## 2.9	中间件

### 2.9.0	概述

##### 说明

- 中间件主要用于拦截或过滤应用的 `HTTP` 请求，并进行必要的业务处理。*（新版部分核心功能使用中间件处理，你可以灵活关闭。包括Session功能、请求缓存和多语言功能。）*


---

<div STYLE="page-break-after: always;"></div>

### 2.9.1	定义中间件

##### 通过命令行指令快速生成中间件

```shell
php think make:middleware Check
```

- 这个指令会 `app/middleware` 目录下面生成一个 `Check` 中间件。


##### 使用上述命令后指令生成的 Check 中间件

```php+HTML
<?php

namespace app\middleware;

class Check
{
    public function handle($request, \Closure $next)
    {
        if ($request->param('name') == 'think') {
            return redirect('index/think');
        }

        return $next($request);
    }
}
```

- 在这个中间件中我们判断当前请求的 `name` 参数等于`think`的时候进行重定向处理。否则，请求将进一步传递到应用中。要让请求继续传递到应用程序中，只需使用 `$request` 作为参数去调用回调函数 `$next` 。


##### 中间件的入口执行方法

- **说明**：中间件的入口执行方法必须是`handle`方法，而且第一个参数是 `Request` 对象，第二个参数是一个闭包。在默写需求下，可以使用第三个参数传入额外的参数。中间件 `handle` 方法的返回值必须是一个 `Response` 对象。

- **例——传入额外参数的 handle 方法**

  ```php
  <?php
  
  namespace app\middleware;
  
  class Check
  {
      public function handle($request, \Closure $next, $name)
      {
          if ($name == 'think') {
              return redirect('index/think');
          }
  
          return $next($request);
      }
  }
  ```


##### 结束调度

- **说明**：中间件支持定义请求结束前的回调机制，你只需要在中间件类中添加`end`方法。

- **例**

  ```php
  public function end(\think\Response $response)
  {
      // 回调行为
  }
  ```

- 📌**注意**

  - 在`end`方法里面不能有任何的响应输出。因为回调触发的时候请求响应输出已经完成了。


##### 前置/后置中间件

- **说明**：中间件是在请求具体的操作之前还是之后执行，完全取决于中间件的定义本身。

- ##### 例——前置中间件

  ```
  <?php
  
  namespace app\middleware;
  
  class Before
  {
      public function handle($request, \Closure $next)
      {
          // 添加中间件执行代码
  
          return $next($request);
      }
  }
  ```

- ##### 例——后置中间件

  ```
  <?php
  
  namespace app\middleware;
  
  class After
  {
      public function handle($request, \Closure $next)
      {
  		$response = $next($request);
  
          // 添加中间件执行代码
  
          return $response;
      }
  }
  ```

##### 例——中间件方法使用依赖注入（判断当前浏览器环境）

```
namespace app\middleware;

/**
 * 访问环境检查，判断当前浏览器环境是微信还是支付宝等
 */
class InAppCheck
{
    public function handle($request, \Closure $next)
    {
        if (preg_match('~micromessenger~i', $request->header('user-agent'))) {
            $request->InApp = 'WeChat';
        } else if (preg_match('~alipay~i', $request->header('user-agent'))) {
            $request->InApp = 'Alipay';
        }
        return $next($request);
    }
}
```

```
//在移动版的应用里添加一个 middleware.php 文件，例如 /path/app/mobile/middleware.php`
return [
    app\middleware\InAppCheck::class,
];
```

- 然后在你的 `controller` 中可以通过 `request()->InApp` 获取相关的值


##### 定义中间件别名

- **说明**：可以直接在应用配置目录下的`middleware.php`中先预定义中间件（其实就是增加别名标识），例如：

  ```
  return [
      'alias' => [
          'auth'  => app\middleware\Auth::class,
          'check' => app\middleware\Check::class,
      ],
  ];
  ```

- **Think PHP支持使用别名定义一组中间件，例如**：

  ```
  return [
      'alias' => [
          'check' => [
              app\middleware\Auth::class,
              app\middleware\Check::class,
          ],
      ],
  ];
  ```


---

<div STYLE="page-break-after: always;"></div>

### 2.9.2	中间件的分类与注册

**ThinkPHP 6.0 中间件**

- 新版的中间件分为全局中间件、应用中间件（多应用模式下有效）、路由中间件以及控制器中间件四个组。执行顺序分别为：`全局中间件 → 应用中间件 → 路由中间件 → 控制器中间件`。

- 📌**注意**
  - 中间件的注册应该使用完整的类名，如果已经定义了中间件别名（或者分组）则可以直接使用。


##### 全局中间件

- **定义全局中间件**：全局中间件在 `app` 目录下面 `middleware.php` 文件中定义，使用下面的方式

  ```
  <?php
  
  return [
  	\app\middleware\Auth::class,
      'check',
      'Hello',
  ];
  ```

- **全局中间件的执行顺序**：全局中间件的执行顺序就是定义顺序。可以在定义全局中间件的时候传入中间件参数，支持两种方式传入。

  ```
  <?php
  
  return [
  	[\app\http\middleware\Auth::class, 'admin'],
      'Check',
      ['hello','thinkphp'],
  ];
  ```

  - 上面的定义表示 给`Auth`中间件传入`admin`参数，给`Hello`中间件传入`thinkphp`参数。


##### 应用中间件

- **说明**：如果你使用了多应用模式，则支持应用中间件定义，你可以直接在应用目录下面增加`middleware.php`文件，定义方式和全局中间件定义一样，只是只会在该应用下面生效。


##### 路由中间件

- **说明**：最常用的中间件注册方式是注册路由中间件。

- **基本使用**：

  ```php
  Route::rule('hello/:name','hello')
  	->middleware(\app\middleware\Auth::class);
  ```

- **注册多个中间件**：

  ```php
  Route::rule('hello/:name','hello')
  	->middleware([\app\middleware\Auth::class, \app\middleware\Check::class]);
  ```

- **直接注册中间件：**

  ```php
  Route::rule('hello/:name','hello')
  	->middleware('check');
  ```

- **对路由分组注册中间件：**

  ```php
  Route::group('hello', function(){
  	Route::rule('hello/:name','hello');
  })->middleware('auth');
  ```

- **对某个域名注册中间件**：

  ```
  Route::domain('admin', function(){
  	// 注册域名下的路由规则
  })->middleware('auth');
  ```

- **向中间件传入额外参数**：

  ```php
  Route::rule('hello/:name','hello')
  	->middleware('auth', 'admin');
  ```

- **同时定义多个中间件**：

  ```php
  Route::rule('hello/:name','hello')
  	->middleware([Auth::class, 'Check']);
  ```

  可以统一传入同一个额外参数：

  ```php
  Route::rule('hello/:name','hello')
  	->middleware(['auth', 'check'], 'admin');
  ```

  或者分开多次调用，指定不同的参数：

  ```php
  Route::rule('hello/:name','hello')
  	->middleware('auth', 'admin')
          ->middleware('hello', 'thinkphp');
  ```

- **定义全局执行的路由中间件**：如果你希望某个路由中间件是全局执行（不管路由是否匹配），可以不需要在路由里面定义，支持直接在路由配置文件中定义，例如在 `config/route.php` 配置文件中添加：

  ```
  'middleware'    =>    [
      app\middleware\Auth::class,
      app\middleware\Check::class,
  ],
  ```

  - 这样，所有该应用下的请求都会执行`Auth`和`Check`中间件。


##### 使用闭包定义中间件

- **说明**：你不一定要使用中间件类，在某些简单的场合你可以使用闭包定义中间件，但闭包函数必须返回`Response`对象实例。

- **例**

  ```php
  Route::group('hello', function(){
  	Route::rule('hello/:name','hello');
  })->middleware(function($request,\Closure $next){
      if ($request->param('name') == 'think') {
          return redirect('index/think');
      }
      
  	return $next($request);
  });
  ```


##### 控制器中间件

- **说明**：支持为控制器定义中间件，只需要在控制器中定义`middleware`属性。

- **例**

  ```php
  <?php
  namespace app\controller;
  
  class Index
  {
      protected $middleware = ['auth'];
  
      public function index()
      {
          return 'index';
      }
  
      public function hello()
      {
          return 'hello';
      }
  }
  ```

  - 当执行 `index` 控制器的时候就会调用 `auth` 中间件，控制器中间件一样支持使用完整的命名空间定义。

- **例——设置控制器中间的生效操作**

  ```php
  <?php
  namespace app\controller;
  
  
  class Index
  {
      protected $middleware = [ 
      	'auth' 	=> ['except' 	=> ['hello'] ],
          'check' => ['only' 		=> ['hello'] ],
      ];
  
      public function index()
      {
          return 'index';
      }
  
      public function hello()
      {
          return 'hello';
      }
  }
  ```


##### 中间件向控制器传参

- **说明**：可以通过给请求对象赋值的方式传参给控制器（或者其它地方）。

- **例**

  ```
  <?php
  
  namespace app\middleware;
  
  class Hello
  {
      public function handle($request, \Closure $next)
      {
          $request->hello = 'ThinkPHP';
          
          return $next($request);
      }
  }
  ```

  ```
  //在控制器的方法里面可以直接使用
  public function index(Request $request)
  {
  	return $request->hello; // ThinkPHP
  }
  ```


##### 内置中间件

- 新版内置了几个系统中间件，包括：

  | 中间件类                           | 描述          |
  | :--------------------------------- | :------------ |
  | think\middleware\AllowCrossDomain  | 跨域请求支持  |
  | think\middleware\CheckRequestCache | 请求缓存      |
  | think\middleware\LoadLangPack      | 多语言加载    |
  | think\middleware\SessionInit       | Session初始化 |
  | think\middleware\FormTokenCheck    | 表单令牌      |

  - 这些内置中间件默认都没有定义，你可以在应用的`middleware.php`文件中、路由或者控制器中定义这些中间件，如果不需要使用的话，取消定义即可。


---

<div STYLE="page-break-after: always;"></div>

### 2.9.3	中间件的执行优先级

##### 说明

- 如果对中间件的执行顺序有严格的要求，可以定义中间件的执行优先级。在配置文件中添加：

  ```
  return [
      'alias'    => [
          'check' => [
              app\middleware\Auth::class,
              app\middleware\Check::class,
          ],
      ],
      'priority' => [
          think\middleware\SessionInit::class,
          app\middleware\Auth::class,
          app\middleware\Check::class,
      ],
  ];
  ```


---

<div STYLE="page-break-after: always;"></div>

## 2.10	事件

### 2.10.0	概述

##### 说明

- 新版的事件系统可以看成是 `5.1` 版本行为系统的升级版，事件系统相比行为系统强大的地方在于事件本身可以是一个类，并且可以更好的支持事件订阅者。


##### 事件相比中间件的优势

- 事件相比较中间件的优势是事件比中间件更加精准定位（或者说粒度更细），并且更适合一些业务场景的扩展。例如，我们通常会遇到用户注册或者登录后需要做一系列操作，通过事件系统可以做到不侵入原有代码完成登录的操作扩展，降低系统的耦合性的同时，也降低了BUG的可能性。


##### 事件的实现原理

- 事件系统的所有操作都通过`think\facade\Event`类进行静态调用


##### 事件不能关闭

- `V6.0.3+`版本开始，事件机制不能关闭


---

<div STYLE="page-break-after: always;"></div>

### 2.10.1	定义事件

##### 说明

- 事件系统使用了观察者模式，提供了解耦应用的更好方式。在你需要监听事件的位置，例如下面我们在用户完成登录操作之后添加如下事件触发代码：

  ```
  // 触发UserLogin事件 用于执行用户登录后的一系列操作
  Event::trigger('UserLogin');
  ```

  或者使用助手函数

  ```
  //这里UserLogin表示一个事件标识，如果你定义了单独的事件类，你可以使用事件类名（甚至可以传入一个事件类实例）。
  event('UserLogin');
  
  // 直接使用事件类触发
  event('app\event\UserLogin');
  ```

  你可以在`event`方法中传入一个事件参数

  ```
  // user是当前登录用户对象实例
  event('UserLogin', $user);
  ```

  如果是定义了事件类，可以直接传入事件对象实例

  ```
  // user是当前登录用户对象实例
  event(new UserLogin($user));
  ```


##### 生成事件类

- **说明**：事件类可以通过命令行快速生成。一般事件类无需继承任何其它类。

- **例**

  ```
  php think make:event UserLogin
  ```

  - 会默认生成一个 `app\event\UserLogin` 事件类，也可以指定完整类名生成。

- **给事件类添加方法**

  ```php
  namespace app\event;
  
  use app\model\User;
  
  class UserLogin
  {
      public $user;
  
      public function __construct(User $user)
      {
          $this->user = $user;
      }
  }
  ```


##### 事件标识

- **说明**：你可以给事件类绑定一个事件标识，一般建议直接在应用的 `event.php` 事件定义文件中批量绑定。

- **事件标识的作用**：ThinkPHP 的事件系统不依赖事件类，如果没有额外的需求，仅通过事件标识也可以使用，可以省去定义事件类的麻烦。如果你没有定义事件类的话，则无需绑定。对于大部分的场景，可能确实不需要定义事件类。

- **例**

  ```php
  return [
      'bind'    =>    [
          'UserLogin' => 'app\event\UserLogin',
          // 更多事件绑定
      ],
  ];
  ```

- **例——动态绑定事件标识**

  ```
  Event::bind(['UserLogin' => 'app\event\UserLogin']);
  ```


---

<div STYLE="page-break-after: always;"></div>

### 2.10.2	事件监听

##### 说明

- 注册事件监听有多种方式，包括：
  1. 手动注册事件监听
  2. 使用监听类执行监听


##### 手动注册事件监听

```
Event::listen('UserLogin', function($user) {
    // 
});
```


##### 使用监听类来执行监听

1. 生成事件监听类，可以通过命令行快速生成一个事件监听类

   ```
   php think make:listener UserLogin
   ```

   - 默认会生成一个`app\listener\UserLogin`事件监听类，也可以指定完整类名生成。

2. 事件监听类只需要定义一个`handle`方法，支持依赖注入。

   ```
   <?php
   namespace app\listener;
   
   class UserLogin
   {
       public function handle($user)
       {
           // 事件监听处理
       }   
   }
   ```

   - 在 `handle` 方法中如果返回了 `false`，则表示监听中止，将不再执行该事件后面的监听。

   - 一般建议直接在事件定义文件中定义对应事件的监听。

     ```php
     return [
         'bind'    =>    [
             'UserLogin' => 'app\event\UserLogin',
             // 更多事件绑定
         ],
         'listen'  =>    [
             'UserLogin'    =>    ['app\listener\UserLogin'],
             // 更多事件监听
         ],
     ];
     ```

3. 使用监听类来执行监听

   ```php
   Event::listen('UserLogin', 'app\listener\UserLogin');
   ```


---

<div STYLE="page-break-after: always;"></div>

### 2.10.3	事件订阅

##### 说明

- 通过事件订阅机制，可以在一个监听器中监听多个事件。


##### 生成事件订阅类

1. 通过命令行生成一个事件订阅类

   ```
   php think make:subscribe User
   ```

   - 默认会生成 `app\subscribe\User` 类，或者你可以指定完整类名生成。

2. 在事件订阅类中添加不同事件的监听方法，例如：

   ```php
   <?php
   namespace app\subscribe;
   
   class User
   {
       public function onUserLogin($user)
       {
           // UserLogin事件响应处理
       }
   
       public function onUserLogout($user)
       {
           // UserLogout事件响应处理
       }
   }
   ```


##### 📌监听事件的方法命名规范

- **说明**：监听事件的方法命名规范是`on`+事件标识（驼峰命名），如果希望统一添加事件前缀标识，可以定义 `eventPrefix` 属性。

- **例**

  ```php
  <?php
  namespace app\subscribe;
  
  class User
  {
      protected $eventPrefix = 'User';
  
      public function onLogin($user)
      {
          // UserLogin事件响应处理
      }
  
      public function onLogout($user)
      {
          // UserLogout事件响应处理
      }
  }
  ```


##### 自定义订阅方式

- **说明**：如果希望自定义订阅方式（或者方法规范），可以定义 `subscribe` 方法实现。

- **例**

  ```php
  <?php
  namespace app\subscribe;
  
  use think\Event;
  
  class User
  {
      public function onUserLogin($user)
      {
          // UserLogin事件响应处理
      }
  
      public function onUserLogout($user)
      {
          // UserLogout事件响应处理
      }
  
      public function subscribe(Event $event)
      {
          $event->listen('UserLogin', [$this,'onUserLogin']);
          $event->listen('UserLogout',[$this,'onUserLogout']);
      }
  }
  ```

  然后在事件定义文件注册事件订阅者

  ```php
  return [
      'bind'    =>    [
          'UserLogin' => 'app\event\UserLogin',
          // 更多事件绑定
      ],
      'listen'  =>    [
          'UserLogin'    =>    ['app\listener\UserLogin'],
          // 更多事件监听
      ],
      'subscribe'    =>    [
         'app\subscribe\User',
          // 更多事件订阅
      ],
  ];
  ```

  如果需要动态注册，可以使用

  ```php
  Event::subscribe('app\subscribe\User');
  ```


---

<div STYLE="page-break-after: always;"></div>

### 2.10.4	内置事件

##### 内置的系统事件包括

| 事件        | 描述                | 参数               |
| :---------- | :------------------ | :----------------- |
| AppInit     | 应用初始化标签位    | 无                 |
| HttpRun     | 应用开始标签位      | 无                 |
| HttpEnd     | 应用结束标签位      | 当前响应对象实例   |
| LogWrite    | 日志write方法标签位 | 当前写入的日志信息 |
| RouteLoaded | 路由加载完成        | 无                 |

- `AppInit`事件定义必须在全局事件定义文件中定义，其它事件支持在应用的事件定义文件中定义。

- 原来`5.1`的一些行为标签已经废弃，所有取消的标签都可以使用中间件更好的替代。可以把中间件看成处理请求以及响应输出相关的特殊事件。事实上，中间件的 `handler` 方法只是具有特殊的参数以及返回值而已。


##### 数据库操作回调

- **说明**：数据库操作的回调也称为查询事件，是针对数据库的CURD操作而设计的回调方法，主要包括：

  | 事件          | 描述                   |
  | :------------ | :--------------------- |
  | before_select | `select`查询前回调     |
  | before_find   | `find`查询前回调       |
  | after_insert  | `insert`操作成功后回调 |
  | after_update  | `update`操作成功后回调 |
  | after_delete  | `delete`操作成功后回调 |

  - 查询事件的参数就是当前的查询对象实例。


##### 模型事件包含

| 钩子          | 对应操作 |
| :------------ | :------- |
| after_read    | 查询后   |
| before_insert | 新增前   |
| after_insert  | 新增后   |
| before_update | 更新前   |
| after_update  | 更新后   |
| before_write  | 写入前   |
| after_write   | 写入后   |
| before_delete | 删除前   |
| after_delete  | 删除后   |

- `before_write`和`after_write`事件无论是新增还是更新都会执行。


---

<div STYLE="page-break-after: always;"></div>

# 3	URL 解析

## 3.0	概述

##### PHP 中的 URL

- ThinkPHP 框架中的很多操作都是通过 URL 来实现的。ThinkPHP 6.0 中的 URL 访问受路由影响，如果没有开启强制路由模式，并且没有定义或匹配路由，则使用 **默认的 URL 形式**。

---

<div STYLE="page-break-after: always;"></div>

## 3.1	默认 URL

##### 单应用模式下的默认 URL 的基本格式

```
http://serverName/index.php（或者其它入口文件）/控制器/操作/参数名/值…
```

- **`http://serverName`** ：域名地址。<font size=1>（例如 `http://localhost:8000` 或 `http://localhost/ThinkPHP/public`）</font>
- **index.php** ：public 目录下的 index. php 文件。
- **控制器**：app/controller 目录下的 .php 文件。
- **操作**：操作即控制器类里面的方法<font size=1>（比如 `index()` 或 `hello()`）</font>。
- **参数与值**：如果操作拥有参数，那么通过 **参数名/具体值** 的形式进行传参

##### 例——访问简单的 URL

```php
<?php
namespace app\controller;

class test
{
    public function index(){
        return request()->controller();//返回当前 Controller 的名称
    }

    public function hello($value = ''){
        echo "Hello ".$value;
        $value."!";
    }
}
```

- 输入地址 `http://localhost:8000/test/hello/value/world`：

![image-20210323182224753](img/image-20210323182224753.png)

- 输入地址 `http://localhost:8000/test`：

![image-20210323182347936](img/image-20210323182347936.png)

##### 自动多应用模式下的默认 URL格式

```
http://serverName/index.php/应用/控制器/操作/参数/值...
```

##### 📌对于不支持 PATHINFO 的服务器可以使用兼容模式的 URL

```
http://serverName/index.php?s=/控制器/操作/[参数名/参数值...]
```

---

<div style="page-break-after: always;"></div>

## 3.2	URL 重写

##### 作用

- URL 重写可以隐藏 URL 中的应用入口文件部分 `index.php`<font size=1>（虽然也可以是其它的入口文件，但 URL 重写通常只能设置一个入口文件）</font>。

##### Apache 服务器的 URL 重写

1. 在 `httpd.conf` 配置文件中加载 `mod_rewrite.so` 模块；

2. 在 `httpd.conf` 配置文件中将 `AllowOverride None` 将 `None` 改为 `All`<font size=1>（有多项 AllowOverride 需要全部修改）</font>；

3. 把下面的内容保存为 `.htaccess` 文件放到应用入口文件的同级目录下

   ```
   <IfModule mod_rewrite.c>
     Options +FollowSymlinks -Multiviews
     RewriteEngine On
   
     RewriteCond %{REQUEST_FILENAME} !-d
     RewriteCond %{REQUEST_FILENAME} !-f
     RewriteRule ^(.*)$ index.php/$1 [QSA,PT,L]
   </IfModule>
   ```

4. 重启服务器，完成修改。

##### IIS 服务器的 URL 重写

- 如果你的服务器环境支持 `ISAPI_Rewrite` 的话，可以配置`httpd.ini`文件，添加下面的内容：

  ```
  RewriteRule (.*)$ /index\.php\?s=$1 [I]
  ```

- 在IIS的高版本下面可以配置`web.Config`，在中间添加`rewrite`节点：

  ```
  <rewrite>
   <rules>
   <rule name="OrgPage" stopProcessing="true">
   <match url="^(.*)$" />
   <conditions logicalGrouping="MatchAll">
   <add input="{HTTP_HOST}" pattern="^(.*)$" />
   <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />
   <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />
   </conditions>
   <action type="Rewrite" url="index.php/{R:1}" />
   </rule>
   </rules>
   </rewrite>
  ```

##### Nginx 服务器下的 URL 重写

- 在 Nginx 低版本中，是不支持 PATHINFO 的，但是可以通过在 `Nginx.conf` 中配置转发规则实现：

  ```
  location / { // …..省略部分代码
     if (!-e $request_filename) {
     		rewrite  ^(.*)$  /index.php?s=/$1  last;
      }
  }
  ```

  - 其实内部是转发到了 ThinkPHP 提供的兼容 URL，利用这种方式，可以解决其他不支持 PATHINFO 的 WEB 服务器环境。

---

<div style="page-break-after: always;"></div>

# 4	控制器

## 4.0	概述

##### 控制器简介

- 控制器，即 controller，控制器文件存放在 controller 目录下;

##### 修改默认的控制器文件目录

- 如果想改变系统默认的控制器文件目录，可以在 config/route . php 中进行配置。

```php
<?php
// +----------------------------------------------------------------------
// | 路由设置
// +----------------------------------------------------------------------

return [
    ...
    // 访问控制器层名称
    'controller_layer'      => 'controller',
    ...
];
```

---

<div STYLE="page-break-after: always;"></div>

## 4.1	定义控制器

##### 语法——定义控制器

- **例——定义一个名为 Test 的 Controller**

  ```
  namespace app\controller;
  
  class Test {
      //默认操作
      public function index(){
          return request()->controller();//返回当前 Controller 的名称
      }
  }
  ```

- **控制器的命名规则**：类名和文件名大小写保持一致，并采用驼峰式（首字母大写）;

- **控制器的实际位置**：Test 控制器实际位置在 `app\controller\Test.php` 中。

- **默认操作**：直接访问该控制器时调用的操作（方法），该操作（方法）的名称为 index。

##### 📌控制器名由多个单词组成时，访问控制器的 URL

- **访问名为 HelloWorld 的控制器**：

  ```php
  namespace app\controller;
  
  class HelloWorld  {
      public function index(){
          return request()->controller();//返回当前 Controller 的名称
      }
  }
  ```

- **使用 URL 格式**：

  ```
  http://localhost:8000/helloworld
  或
  http://localhost:8000/hello_world
  ```

##### 📌避免同类名冲突

- 如果你想避免引入同类名时的冲突，可以在 config/route.php 中设置：

  ```php
  <?php
  // +----------------------------------------------------------------------
  // | 路由设置
  // +----------------------------------------------------------------------
  
  return [
      ...
      // 是否使用控制器后缀
      'controller_suffix'     => false,
      ...
  ];
  ```

  - 此时，Test.php 文件就必须更名为 TestController.php，并且类名也需要增加后缀。

---

<div style="page-break-after: always;"></div>

## 4.2	控制器渲染输出

##### 说明

- 控制器使用 return 返回结果，但是对于对象、数组等数据结构无法直接返回<font size=1>（会报错）</font>。

##### 使用 JSON 函数输出

- **例——使用 JSON 函数输出数组**

  ```php
  class Test
  {
      public function index(){
          $arr = [1=>'a',2=>'b',3=>'c'];
          return json($arr);//返回当前 Controller 的名称
      }
  }
  ```

---

<div style="page-break-after: always;"></div>

## 4.3	基础控制器

##### 说明

- 一般来说，创建控制器后，推荐继承基础控制器来获得更多的方法。基础控制器仅仅提供了控制器验证功能，并注入了 think\App 对象和 think\Request 对象。

##### 例——使用基础控制器

```php
<?php
namespace app\controller;

use app\BaseController;

class Test extends BaseController
{
    public function index(){
        //返回控制器的绝对路径
        return $this->app->getBasePath();
    }

    public function hello(){
        //返回当前操作（方法）名
        return $this->request->action();
    }

}
```

---

<div style="page-break-after: always;"></div>

## 4.4	Error 控制器

##### 说明

- 在单应用模式下，我们可以给项目定义一个 Error 控制器类，用于提醒错误。

##### 例——定义 Error 控制器

```
<?php
namespace app\controller;

class Error{
	    public function index(){
        return "ERROR";//返回自定义的错误消息
    }
}
```

##### 📌Error 控制器会覆盖调试模式的错误信息

- 开启 Erro 控制器后，不管是生成环境还是开发环境下，都会显示 Error 控制器中的错误信息，DEBUG 模式将会被覆盖。

---

<div style="page-break-after: always;"></div>

## 4.5	多级控制器

##### 说明

- 在 controller 目录下创建子目录，子目录中创建的 Controller 就是多级控制器。

##### 语法——定义多级控制器

```php
<?php
//从命名空间可以看出，该控制器的位置为 app\controller\grroup\Test.php。
namespace app\controller\group;

class Test
{
    public function index(){
        return request()->controller();//返回当前 Controller 的名称
    }

    public function hello($value = 'World'){
        return "Hello ".$value;
    }
}
```

- **访问多级控制器**：多级控制器的目录名与类名之间采用 `.`进行连接。 访问该多级控制器使用的 URL 为 `http://localhost:8000/group.test`，访问该控制器下的 `hello()` 操作的 URL 为 `http://localhost:8000/group.test/hello`。

---

<div style="page-break-after: always;"></div>

# 5	数据库



---

<div style="page-break-after: always;"></div>

# 附录

##### 最后编辑时间

- 2021/03/24

##### 环境

- Apache 2.4.46 Win64
- php-7.4.15-Win32-vc15-x64
- PhpStorm 2020.3.2

- ThinkPHP v6.0.7

##### 参考资料

- 【李炎恢】【ThinkPHP6.x / PHP框架】【十天精品课堂系列】

##### 相关资料

- 

##### 代码链接

[1]:

##### 锚点

[](#1) 

##### 质疑

[^!1]: 

##### 疑问

[^?1]: 什么是扩展

##### 脚注

[^Composer]: Composer 是 PHP 的一个依赖管理工具。它允许你申明项目所依赖的代码库，它会在你的项目中为你安装他们。