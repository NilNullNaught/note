

# Ⅲ	Node.js

## Ⅲ.1	Node.js 概述

##### 什么是 Node.js

浏览器的内核包括两部分核心：

- DOM渲染引擎；
- js解析器（js引擎）
- js运行在浏览器中的内核中的js引擎内部

Node.js 是脱离浏览器环境运行的 JavaScript 程序，基于 V8 引擎（Chrome 的 JavaScript 的引擎）

简单的说 Node.js 就是运行在服务端的 JavaScript。Node.js 是一个事件驱动 I/O 服务端 **JavaScript 环境**，基于 Google 的 V8 引擎，V8 引擎执行 Javascript 的速度非常快，性能非常好。



<br>

##### Node.js 的作用

如果你是一个前端程序员，你不懂得像PHP、Python或Ruby等动态编程语言，然后你想创建自己的服务，那么Node.js是一个非常好的选择。

Node.js 是运行在服务端的 JavaScript，如果你熟悉Javascript，那么你将会很容易的学会Node.js。

当然，如果你是后端程序员，想部署一些高性能的服务，那么学习Node.js也是一个非常好的选择。

<br>

----

<div STYLE="page-break-after: always;">
    <br>
	<br>
	<br>
	<br>
	<br>
</div>
## Ⅲ.2	安装

##### 官网

https://nodejs.org/en/

<br>

##### LTS 与 Current

- LTS：长期支持版本

- Current：最新版

<br>

##### 安装

使用安装包安装即可。

##### 检查

打开 cmd，输入下列命令：

```shell
node -v
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

## Ⅲ.3	快速入门



---

<div STYLE="page-break-after: always;">
    <br>
	<br>
	<br>
	<br>
	<br>
</div>
## Ⅲ.4	NPM 包管理

##### 什么是 NPM

NPM 全称 Node Package Manager，是Node.js包管理工具，是全球最大的模块生态系统，里面所有的模块都是开源免费的；也是 Node.js 的包管理工具，相当于前端的 Maven 。

通过 npm 可以很方便地下载js库，管理前端工程。

<br>

##### Node.js 默认安装的 npm 包和工具的位置

Node.js 根目录\node_modules，在这个目录下你可以看见 npm 目录，npm 本身也是是被 NPM 包管理器管理的一个工具，即 Node.js 已经集成了 npm 工具。

<br>

##### 查看当前npm版

```
npm -v
```

<br>

##### 使用 npm 初始化项目

###### 第一步

创建文件夹npm

###### 第二步

在 npm 文件夹下进行项目初始化：

```shell
#建立一个空文件夹，在命令提示符进入该文件夹  执行命令初始化
npm init
#按照提示输入相关信息，如果是用默认值则直接回车即可。
#name: 项目名称
#version: 项目版本号
#description: 项目描述
#keywords: {Array}关键词，便于用户搜索到我们的项目
#最后会生成 package.json 文件，这个是包的配置文件，相当于maven的pom.xml
#我们之后也可以根据需要进行修改。
#如果想直接生成 package.json 文件，那么可以使用命令
npm init -y
```

<br>

##### 修改npm镜像

NPM 官方的管理的包都是从 http://npmjs.com下载的，但是这个网站在国内速度很慢。这里推荐使用淘宝 NPM 镜像 http://npm.taobao.org/ ，淘宝 NPM 镜像是一个完整 npmjs.com 镜像，同步频率目前为 10分钟一次，以保证尽量与官方服务同步。

**设置镜像地址：**

```
#经过下面的配置，以后所有的 npm install 都会经过淘宝的镜像地址下载
npm config set registry https://registry.npm.taobao.org 

#查看npm配置信息
npm config list
```

<br>

##### 使用 npm install 安装依赖

```shell
#使用 npm install 安装依赖包的最新版，
#模块安装的位置：项目目录\node_modules
#安装会自动在项目目录下添加 package-lock.json文件，这个文件帮助锁定安装包的版本
#同时package.json 文件中，依赖包会被添加到dependencies节点下，类似maven中的 <dependencies>
npm install jquery


#npm管理的项目在备份和传输的时候一般不携带node_modules文件夹
npm install #根据package.json中的配置下载依赖，初始化项目


#如果安装时想指定特定的版本
npm install jquery@2.1.x


#devDependencies节点：开发时的依赖包，项目打包到生产环境的时候不包含的依赖
#使用 -D参数将依赖添加到devDependencies节点
npm install --save-dev eslint
#或
npm install -D eslint


#全局安装
#Node.js全局安装的npm包和工具的位置：用户目录\AppData\Roaming\npm\node_modules
#一些命令行工具常使用全局安装的方式
npm install -g webpack
```

<br>

##### 其它命令

```shell
#更新包（更新到最新版本）
npm update 包名
#全局更新
npm update -g 包名

#卸载包
npm uninstall 包名
#全局卸载
npm uninstall -g 包名
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
## Ⅲ.5	Webpack

##### 什么是 Webpack

Webpack 是一个前端资源加载/打包工具。它将根据模块的依赖关系进行静态分析，然后将这些模块按照指定的规则生成对应的静态资源。

![img](img/what-is-webpack.png)

从图中我们可以看出，**Webpack 可以将多种静态资源  js、css、less 转换成一个静态文件，减少了页面的请求**。 

<br>

##### 安装 webpack

```shell
#全局安装
npm install -g webpack webpack-cli

#安装后查看版本号
webpack -v
```

<br>

##### 初始化项目

###### 第一步

创建 webpack 文件夹，进入webpack目录，执行命令

```
npm init -y
```

###### 第二步

创建src文件夹

###### 第三步

在src下创建common.js：

```
exports.info = function (str) {
    document.write(str);
}
```

###### 第四步

在 src下创建utils.js：

```
exports.add = function (a, b) {
    return a + b;
}
```

###### 第五步

在 src下创建main.js

```
const common = require('./common');
const utils = require('./utils');

common.info('Hello world!' + utils.add(100, 200));
```

<br>

##### JS打包

###### 第一步

webpack目录下创建配置文件webpack.config.js：

```js
//以下配置的意思是：
//	读取当前项目目录下src文件夹中的main.js（入口文件）内容，分析资源依赖，把相关的js文件打包，
//	打包后的文件放入当前目录的dist文件夹下
//	打包后的js文件名为bundle.js

const path = require("path"); //Node.js内置模块
module.exports = {
    entry: './src/main.js', //配置入口文件
    output: {
        path: path.resolve(__dirname, './dist'), //输出路径，__dirname：当前文件所在路径
        filename: 'bundle.js' //输出文件
    }
}
```

###### 第二步

命令行执行编译命令进行打包：

```
webpack #有黄色警告
webpack --mode=development #没有警告
#执行后查看bundle.js 里面包含了上面两个js文件的内容并惊醒了代码压缩
```

也可以配置项目的npm运行命令，修改package.json文件

```
"scripts": {
    //...,
    "dev": "webpack --mode=development"
 }
```

并且运行npm命令执行打包：

```
npm run dev
```

###### 第三步

在 webpack目录下创建index.html，并引用bundle.js

```
<body>
    <script src="dist/bundle.js"></script>
</body>
```

<br>

##### CSS 打包

###### 第一步

安装style-loader和 css-loader，因为Webpack 本身只能处理 JavaScript 模块，如果要处理其他类型的文件，就需要使用 loader 进行转换。

Loader 可以理解为是模块和资源的转换器。

首先我们需要安装相关Loader插件，css-loader 是将 css 装载到 javascript；style-loader 是让 javascript 认识css。

```
npm install --save-dev style-loader css-loader 
```

###### 第二步

修改webpack.config.js

```
const path = require("path"); //Node.js内置模块
module.exports = {
    //...,
    output:{},
    module: {
        rules: [  
            {  
                test: /\.css$/,    //打包规则应用到以css结尾的文件上
                use: ['style-loader', 'css-loader']
            }  
        ]  
    }
}
```

###### 第三步

在src文件夹创建style.css

```
body{
    background:pink;
}
```

###### 第四步

修改main.js ，在第一行引入style.css

```
require('./style.css');
```

###### 第五步

在浏览器中查看 index.html

<br>

---

<div STYLE="page-break-after: always;">
    <br>
	<br>
	<br>
	<br>
	<br>
</div>
