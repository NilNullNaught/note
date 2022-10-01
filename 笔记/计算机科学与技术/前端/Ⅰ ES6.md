# Ⅰ	ES6

## Ⅰ.1	ECMAScript 6 概述

##### 什么是 ES6

ECMAScript 6.0（简称 ES6）是 JavaScript 语言的下一代标准，在 2015 年 6 月正式发布。它的目标，是使得 JavaScript 语言可以用来编写复杂的大型应用程序，成为企业级开发语言。

<br>

##### ECMAScript 和 JavaScript 的关系

一个常见的问题是，ECMAScript 和 JavaScript 到底是什么关系？

要讲清楚这个问题，需要回顾历史。1996 年 11 月，JavaScript 的创造者 Netscape 公司，决定将 JavaScript 提交给标准化组织 ECMA，希望这种语言能够成为国际标准。次年，ECMA 发布 262 号标准文件（ECMA-262）的第一版，规定了浏览器脚本语言的标准，并将这种语言称为 ECMAScript，这个版本就是 1.0 版。

因此，**ECMAScript 和 JavaScript 的关系是，前者是后者的规格，后者是前者的一种实现**（另外的 ECMAScript 方言还有 Jscript 和 ActionScript）

<br>

##### ES6 与 ECMAScript 2015 的关系

ECMAScript 2015（简称 ES2015）这个词，也是经常可以看到的。它与 ES6 是什么关系呢？

2011 年，ECMAScript 5.1 版发布后，就开始制定 6.0 版了。因此，ES6 这个词的原意，就是指 JavaScript 语言的下一个版本。

ES6 的第一个版本，在 2015 年 6 月发布，正式名称是《ECMAScript 2015 标准》（简称 ES2015）。

2016 年 6 月，小幅修订的《ECMAScript 2016 标准》（简称 ES2016）如期发布，这个版本可以看作是 ES6.1 版，因为两者的差异非常小，基本上是同一个标准。根据计划，2017 年 6 月发布 ES2017 标准。

因此，ES6 既是一个历史名词，也是一个泛指，含义是 5.1 版以后的 JavaScript 的下一代标准，涵盖了 ES2015、ES2016、ES2017 等等，而 ES2015 则是正式名称，特指该年发布的正式版本的语言标准。本书中提到 ES6 的地方，一般是指 ES2015 标准，但有时也是泛指“下一代 JavaScript 语言”。

<br>

##### ES 标准的包含范围

ES标准中不包含 DOM 和 BOM的定义，只涵盖基本数据类型、关键字、语句、运算符、内建对象、内建函数等通用语法。

<br>

----

<div STYLE="page-break-after: always;">
    <br>
	<br>
	<br>
	<br>
	<br>
</div>
## Ⅰ.2	基本语法

##### 声明局部变量——let

```js
let a = 0
```

对于同一个变量名，let 只能声明一次：

```js
let a = 1
let a = 2
console.log(a)  // Identifier 'n' has already been declared
```

<br>

##### 声明全局变量——var

```
var b = 0
```

对于同一个变量名，var 可以声明多次

```
var b = 1
var b = 2
console.log(b)  // 2
```

<br>

##### 声明常量——const

```
const e =2.718281828
```

常量声明之后不允许改变：

```
//    
const PI = 3.1415926535
PI = 3  // TypeError: Assignment to constant variable.
```

常量一但声明，必须初始化，否则会报错：

```
const MY_AGE  // SyntaxError: Missing initializer in const declaration
```

<br>

##### 解构赋值

###### 什么是解构赋值

解构赋值是 **对赋值运算符的扩展**，可以针对数组或者对象进行模式匹配，然后对其中的变量进行赋值。

解构赋值在代码书写上简洁且易读，语义更加清晰明了；也方便了复杂对象中数据字段获取。

###### 例——数组解构

```java
// 传统
let a = 1, b = 2, c = 3
console.log(a, b, c)
// ES6
let [x, y, z] = [1, 2, 3]
console.log(x, y, z)
```

###### 例——对象解构

```java
//2、对象解构
let user = {name: 'Helen', age: 18}
// 传统
let name1 = user.name
let age1 = user.age
console.log(name1, age1)
// ES6
let { name, age } =  user//注意：结构的变量必须是user中的属性
console.log(name, age)
```

<br>

##### 模板字符串

模板字符串相当于加强版的字符串，使用反引号 `` `。

模板字符串除了作为普通字符串，还可以用来定义多行字符串，还可以在字符串中加入变量和表达式。

###### 例——定义多行字符串

```js
let string1 =  `Hey,
can you stop angry now?`
console.log(string1)
// Hey,
// can you stop angry now?
```

###### 例——在字符串中插入变量和表达式

可以在 `${}` 中放入变量和 JavaScript 表达式。

```java
let name = "Mike"
let age = 27
let info = `My Name is ${name},I am ${age+1} years old next year.`
console.log(info)
// My Name is Mike,I am 28 years old next year.
```

###### 例——在字符串中调用函数

```js
function f(){
    return "have fun!"
}
let string2 = `Game start,${f()}`
console.log(string2);  // Game start,have fun!
```

<br>

##### 简化声明对象

```js
const age = 12
const name = "Amy"

// 传统
const person1 = {age: age, name: name}
console.log(person1)

// ES6
const person2 = {age, name}
console.log(person2) //{age: 12, name: "Amy"}
```



##### 简化方法定义

```js
// 传统
const person1 = {
    sayHi:function(){
        console.log("Hi")
    }
}
person1.sayHi();//"Hi"


// ES6
const person2 = {
    sayHi(){
        console.log("Hi")
    }
}
person2.sayHi()  //"Hi"
```

<br>

##### 对象拓展运算符

拓展运算符（...）用于取出参数对象所有可遍历属性然后拷贝到当前对象。

###### 使用对象拓展运算符拷贝对象

```js
// 拷贝对象
let person1 = {name: "Amy", age: 15}
let someone = { ...person1 }
console.log(someone)  //{name: "Amy", age: 15}
```

###### 使用对象拓展运算符合并对象

```js
let age = {age: 15}
let name = {name: "Amy"}
let person2 = {...age, ...name}
console.log(person2)  //{age: 15, name: "Amy"}
```

<br>

##### 箭头函数

箭头函数提供了一种更加简洁的函数书写方式。

###### 基本语法

```
参数 => 函数体
```

###### 作用

箭头函数多用于匿名函数的定义。

###### 例

```
// 传统
var f1 = function(a){
    return a
}
console.log(f1(1))


// ES6
var f2 = a => a
console.log(f2(1))
```

```
// 当箭头函数没有参数或者有多个参数，要用 () 括起来。
// 当箭头函数函数体有多行语句，用 {} 包裹起来，表示代码块，
// 当只有一行语句，并且需要返回结果时，可以省略 {} , 结果会自动返回。
var f3 = (a,b) => {
    let result = a+b
    return result
}
console.log(f3(6,2))  // 8

// 前面代码相当于：
var f4 = (a,b) => a+b
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
## Ⅰ.3	Babel 转码器

##### Babel 简介 

Babel是一个广泛使用的转码器，可以将ES6代码转为ES5代码，从而在现有不支持 ES6 的环境下执行。这意味着，你可以现在就用 ES6 编写程序，而不用担心现有环境是否支持。

<br>

##### 安装命令行转码工具

Babel 提供babel-cli工具，用于命令行转码。它的安装命令如下：

```
#使用 npm 全局安装 Babel
npm install --global babel-cli

#查看是否安装成功
babel --version
#错误请看：https://www.cnblogs.com/Courage129/p/13968820.html
```

<br>

##### 使用 Babel

###### 第一步

初始化项目

```
npm init -y
```

###### 第二步

创建文件 src/example.js，内容为

```
// 转码前
// 定义数据
let input = [1, 2, 3]
// 将数组的每个元素 +1
input = input.map(item => item + 1)
console.log(input)
```

###### 第三步

配置.babelrc。abel的配置文件是.babelrc，存放在项目的根目录下，该文件用来设置转码规则和插件，基本格式如下：

```
{
    "presets": [],
    "plugins": []
}
```

presets字段设定转码规则，将es2015规则加入 .babelrc：

```
{
    "presets": ["es2015"],
    "plugins": []
}
```

###### 第四步

在项目中安装转码器

```
npm install --save-dev babel-preset-es2015
```

###### 第五步

转码：

```shell
# 转码结果写入一个文件
mkdir dist1
# --out-file 或 -o 参数指定输出文件
babel src/example.js --out-file dist1/compiled.js
# 或者
babel src/example.js -o dist1/compiled.js

# 整个目录转码
mkdir dist2
# --out-dir 或 -d 参数指定输出目录
babel src --out-dir dist2
# 或者
babel src -d dist2
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
## Ⅰ.4	模块化

### Ⅰ.4.1	模块化概述

##### 模块化产生的背景

随着网站逐渐变成"互联网应用程序"，嵌入网页的Javascript代码越来越庞大，越来越复杂。

Javascript模块化编程，已经成为一个迫切的需求。理想情况下，开发者只需要实现核心的业务逻辑，其他都可以加载别人已经写好的模块。

但是，Javascript不是一种模块化编程语言，它不支持"类"（class），包（package）等概念，更遑论"模块"（module）了。

<br>

##### 传统非模块化开发的缺点：

- 命名冲突
- 文件依赖

<br>

##### 模块化规范：

- CommonJS模块化规范
- ES6模块化规范

<br>

---

<div STYLE="page-break-after: always;">
    <br>
	<br>
	<br>
	<br>
	<br>
</div>

### Ⅰ4.2	CommonJS 模块规范

##### CommonJS 的模块规范

CommonJS 使用 exports 和 require 来导出、导入模块。

每个文件就是一个模块，有自己的作用域。在一个文件里面定义的变量、函数、类，都是私有的，对其他文件不可见。

<br>

##### 实现步骤

###### 第一步

创建 module 文件夹

###### 第二步

在 module 文件夹下创建 `common-js模块化/四则运算.js`

```js
// 定义成员：
const sum = function(a,b){
    return parseInt(a) + parseInt(b)
}
const subtract = function(a,b){
    return parseInt(a) - parseInt(b)
}
const multiply = function(a,b){
    return parseInt(a) * parseInt(b)
}
const divide = function(a,b){
    return parseInt(a) / parseInt(b)
}

// 导出成员：
module.exports = {
    sum: sum,
    subtract: subtract,
    multiply: multiply,
    divide: divide
}
//或者使用简写
module.exports = {
    sum,
    subtract,
    multiply,
    divide
}
```

###### 第四步

导入模块，创建文件 `common-js模块化/引入模块.js`：

```
//引入模块，注意：当前路径必须写 ./
const m = require('./四则运算.js')
console.log(m)

const result1 = m.sum(1, 2)
const result2 = m.subtract(1, 2)
console.log(result1, result2)
```

###### 第五步

运行程序：

```
node common-js模块化/引入模块.js
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

### Ⅰ.4.3	ES6模块化的另一种写法

##### 导出模块

创建文件 `es6模块化/userApi2.js`

```
export default {
    getList() {
        console.log('获取数据列表2')
    },

    save() {
        console.log('保存数据2')
    }
}
```

<br>

##### 导入模块

创建文件 es6模块化/userComponent2.js

```
import user from "./userApi2.js"
user.getList()
user.save()
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
