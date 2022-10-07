<div STYLE="page-break-after: always;">
	<br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
	<center><h3><font size="20px">
        JavaScript
    </font></h3></center>
	<br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
</div>

# 1	JavaScript 概述

## 1.1	JavaScript 简介

#### 什么是 JavaScript 

JavaScript（简称 JS） 是一种具有函数优先的 **轻量级**、**解释型或即时编译型** 的编程语言。虽然它是作为开发 Web 页面的脚本语言而出名，但是它也被用到了很多非浏览器环境中。JavaScript 是基于原型编程、多范式的动态脚本语言，并且支持面向对象、命令式、声明式、函数式编程范式。 

JavaScript 在1995年由 Netscape （网景）公司的工程师 Brendan Eich，在网景导航者浏览器上首次设计实现而成。因为 Netscape 与 Sun 合作，Netscape 管理层希望它外观看起来像 Java，因此取名为 JavaScript。但实际上它的语法风格与 Self 及 Scheme 较为接近。

<br>

#### JavaScript 的主要功能

1. 嵌入动态文本于 HTML 页面。
2. 对浏览器事件做出响应。
3. 读写 HTML 元素。
4. 在数据被提交到服务器之前验证数据。 
5. 检测访客的浏览器信息。
6. 控制 cookies，包括创建和修改等。
7. 基于 Node.js 技术进行服务器端编程。 

<br>

#### JavaScript 标准

JavaScript的标准是 ECMAScript （ES 标准）。ES标准中不包含 DOM 和 BOM的定义，只涵盖基本数据类型、关键字、语句、运算符、内建对象、内建函数等通用语法。

截至 2012 年，所有浏览器都完整的支持 ECMAScript 5.1，旧版本的浏览器至少支持 ECMAScript 3 标准。2015 年 6 月 17 日，ECMA 国际组织发布了 ECMAScript 的第六版，该版本正式名称为 ECMAScript 2015，但通常被称为 ECMAScript 6 或者 ES2015。

<br>

#### ECMAScript 6

ECMAScript 6.0（简称 ES6）是 JavaScript 语言的下一代标准，在 2015 年 6 月正式发布。它的目标是使 **JavaScript 语言可以用来编写复杂的大型应用程序，成为企业级开发语言**。

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

## 1.2	JavaScript 的引入方式

#### 引入 JavaScript

JavaScript 程序不能独立运行，它需要被嵌入 HTML 中，然后浏览器才能执行 JavaScript 代码。通过 `<script>` 标签将 JavaScript 代码引入到 HTML 中，有两种方式：

1. 内部形式
2. 外部形式

<br>

#### 内部形式

通过 `script` 标签包裹 JavaScript 代码：

```html

<body>
  <!-- 内联形式：通过 script 标签包裹 JavaScript 代码 -->
  <script>
    alert('嗨，欢迎来传智播学习前端技术！');
  </script>
</body>
```

<br>

#### 外部形式 

一般将 JavaScript 代码写在独立的以 .js 结尾的文件中，然后通过 `script` 标签的 `src` 属性引入

```javascript
// demo.js
document.write('Hello World！');
```

```html
<body>
  <!-- 外部形式：通过 script 的 src 属性引入独立的 .js 文件 -->
  <script src="demo.js"></script>
</body>
```

###### 注意

如果 `<script>` 标签使用 src 属性引入了某个 .js 文件，那么这个标签中的 JS 代码会被忽略，如下代码所示：

```html

<body>
  <script src="demo.js">
    // 此处的代码会被忽略
  	alert(666);  
  </script>
</body>
</html>
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

# 2	基本语法

## 2.1	注释和结束符

#### 单行注释

使用 `// ` 注释单行代码

```js
// 这种是单行注释的语法
// 一次只能注释一行
// 可以重复注释
document.write('Hello World');
```

<br>

#### 多行注释

使用 `/* */` 注释多行代码

```js
/* 这种的是多行注释的语法 */
/*
	更常见的多行注释是这种写法
	在些可以任意换行
	多少行都可以
  */
document.write('Hello World');
```

<br>

##### 结束符

在 JavaScript 中 `;` 代表一段代码的结束。多数情况下可以省略 `;` ，使用回车（enter）替代。

```js
alert(1);
alert(2);
alert(1)
alert(2)
```

###### 注意

JavaScript 跟 HTML 和 CSS 一样，会忽略一些空白符号，但是换行符（回车）会被识别成结束符 `;`，因此在实际开发中有许多人主张书写 JavaScript 代码时省略结束符 `;`。

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

## 2.2	输入和输出

##### 输入

向 `prompt()` 输入任意内容会以弹窗形式出现在浏览器中，一般提示用户输入一些内容。

```js
// 1. 输入的任意数字，都会以弹窗形式展示
document.write('要输出的内容');
alert('要输出的内容');

// 2. 以弹窗形式提示用户输入姓名，注意这里的文字使用英文的引号
prompt('请输入您的姓名:');
```

<br>

##### 输出

JavaScript 可以接收用户的输入，然后再将输入的结果输出。

###### 输出函数

`alert()` 和 `document.wirte()` 会以弹窗形式将内容展示（输出）给用户。

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

## 2.3	变量与常量

#### 变量的声明和赋值

###### 局部变量 let

```js
let age;
```

###### 声明全局变量——var

```js
var b
```

###### 变量赋值

声明（定义）变量相当于创造了一个空的 “容器”，还需要通过赋值向这个容器中添加数据，例如：

```js
// 声明
let age
var name

// 赋值
age = 18
name = '赵大'

// 输出 18
document.write(age);
// 输出 赵大
document.write(name);
```

声明和赋值可以同时进行：

```js
let str = 'hello world!';
alert(str);
```

###### let 和 var 的不同点

1. 作用域不同：
   1. `let` 是块作用域，所以在块作用域内（比如 `for` 循环内）定义的 `let` 变量，在其外面是不可被访问的（所以 `for` 循环推荐用 `let`）；
   2. `var` 是函数作用域，在函数中声明了 `var`，整个函数内都是有效的，比如说在 `for` 循环内定义的一个 `var` 变量，实际上其在 `for` 循环以外也是可以访问的。

1. `let` 不能在定义之前访问该变量，但是 `var` 可以（此时变量的值为 `undefined`）；
3. `let` 不能被重新定义（声明），但是 `var` 可以；

```js
// 对于同一个变量名，let 只能声明一次：
let a = 1
let a = 2
console.log(a)  // Identifier 'n' has already been declared

// 对于同一个变量名，var 可以声明多次
var b = 1
var b = 2
console.log(b)  // 2
```


###### 注意

大部分情况使用 `let` 和 `var` 区别不大，但是 `let` 相较 `var` 更严谨，因此推荐使用 `let`。

<br>

#### 变量名命名规则

关于变量的名称（标识符）有一系列的规则需要遵守：

1. 只能是字母、数字、下划线、$，且不能能数字开头；
2. 字母区分大小写，如 Age 和 age 是不同的变量；
3. JavaScript 内部的关键字或保留字不允许作为变量名使用；
4. 尽量保证变量具有一定的语义，见字知义。

<br>

#### 常量

常量在声明之后不允许改变，且声明后必须立即初始化。

###### 例——声明变量

```
const e =2.718281828
```

###### 例——变量不能重新赋值

```
//    
const PI = 3.1415926535
PI = 3  // TypeError: Assignment to constant variable.
```

###### 例——变量声明后必须立即初始化

```
const MY_AGE  // SyntaxError: Missing initializer in const declaration
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

## 2.4	

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

# 附录

##### 参考资料

1. 主要参考资料——[前端开发入门教程，web前端零基础html5 +css3+前端项目视频教程](https://www.bilibili.com/video/BV1Kg411T7t9/?p=2&spm_id_from=pageDriver&vd_source=87ed5edcdc8042ca0c34ee5bbeeda7b3) 发布于 2021/11/16；
2. [2.3	变量与常量](#2.3	变量与常量)——[var和let的区别](https://zhuanlan.zhihu.com/p/265002815) 发布于 2020/10/12 最后编辑于 2022/01/17；

<br>