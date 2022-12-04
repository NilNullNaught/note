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

<div STYLE="page-break-after: always;"></div>


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

<div STYLE="page-break-after: always;"></div>

## 1.3	Babel 转码器

#### 什么是 Babel

Babel 是一个广泛使用的转码器，可以将 ES6 代码转为 ES5 代码，从而在现有不支持 ES6 的环境下执行。这意味着，你可以现在就用 ES6 编写程序，而不用担心现有环境是否支持。

<br>

#### 安装命令行转码工具

Babel 提供babel-cli工具，用于命令行转码。它的安装命令如下：

```sh
#使用 npm 全局安装 Babel
npm install --global babel-cli

#查看是否安装成功
babel --version
```

<br>

#### Babel 基本使用步骤

###### 第一步

初始化项目：

```sh
npm init -y
```

###### 第二步

创建文件 `src/example.js`，内容为：

```js
// 转码前
// 定义数据
let input = [1, 2, 3]
// 将数组的每个元素 +1
input = input.map(item => item + 1)
console.log(input)
```

###### 第三步

配置 `.babelrc` 文件，=，`.babelrc` 是 Babel 的配置文件，存放在项目的根目录下，该文件用来设置转码规则和插件，基本格式如下：

```js
{
    "presets": [],
    "plugins": []
}
```

使用 presets 字段设定转码规则，将 es2015 规则加入 `.babelrc`：

```js
{
    "presets": ["es2015"],
    "plugins": []
}
```

###### 第四步

在项目中安装转码器：

```sh
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

<div STYLE="page-break-after: always;"></div>


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

<div STYLE="page-break-after: always;"></div>

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

<div STYLE="page-break-after: always;"></div>

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

#### 变量与常量的命名规则

关于变量的名称（标识符）有一系列的规则需要遵守：

1. 只能是字母、数字、下划线、$，且不能能数字开头；
2. 字母区分大小写，如 Age 和 age 是不同的变量；
3. JavaScript 内部的关键字或保留字不允许作为变量名使用；
4. 尽量保证变量具有一定的语义，见字知义。

<br>

---

<div STYLE="page-break-after: always;"></div>
## 2.4	关键字与保留字

#### 关键字

关键字指 JS 本身已经使用了的字符，不能再用它们充当变量名或方法名。

###### JS 现有的关键字

break、case、catch、continue、default、delete、do、else、finally、for、function、if、in、instanceof、new、return、switch、this、throw、try、typeof、var、void、while、with 等。

<br>

####  保留字

保留字实际上就是预留的“关键字”，意思是现在虽然还不是关键字，但是未来可能会成为关键字，同样不能使用它们当变量名或方法名。

###### JS 现有的保留字

boolean、byte、char、class、const、debugger、double、enum、export、extends、fimal、float、goto、implements、import、int、interface、long、mative、package、private、protected、public、short、static、super、synchronized、throws、transient、volatile 等。

###### 注意

如果将保留字用作变量名或函数名，那么除非将来的浏览器实现了该保留字，否则很可能收不到任何错误消息。当浏览器将其实现后，该单词将被看做关键字，如此将出现关键字错误。

<br>

---

<div STYLE="page-break-after: always;"></div>

## 2.5	数据类型

#### 检测数据类型——typeof 关键字

JS 中通过 **关键字 `typeof` ** 检测数据类型。

<br>

#### 数值类型 number

JS 中的数值类型包括 **整数、小数（浮点数）、正数、负数**。

###### 例

```js
let score = 100; // 正整数
let price = 12.345; // 小数
let temperature = -40; // 负数

document.write(typeof score); // 结果为 number
document.write(typeof price); // 结果为 number
document.write(typeof temperature); // 结果为 number
```

<br>

#### 字符串类型 string

通过单引号（ `''`） 、双引号（ `""`）或反引号包裹的数据都叫字符串，一般推荐使用单引号。

###### 例

```js
let user_name = '小明'; // 使用单引号
let gender = "男"; // 使用双引号
let str = '123'; // 看上去是数字，但是用引号包裹了就成了字符串了
let str1 = ''; // 这种情况叫空字符串
	
documeent.write(typeof user_name); // 结果为 string
documeent.write(typeof gender); // 结果为 string
documeent.write(typeof str); // 结果为 string
```

<br>

#### 布尔类型 boolean

表示肯定或否定时在计算机中对应的是布尔类型数据，它有两个固定的值 `true` 和 `false`。

###### 例

```js
let flag = true; 
flag = false; 

document.write(typeof flag); // 结果为 boolean
```

<br>

#### 未定义 undefined

`undefined` 是特殊的类型，只有一个值 undefined。如果只声明变量，不进行赋值，变量的默认值为 `undefined`。

###### 例

```js
// 只声明了变量，并末赋值
let tmp;
document.write(typeof tmp); // 结果为 undefined
```

<br>

---

<div STYLE="page-break-after: always;"></div>

## 2.6	类型转换

#### 隐式转换

某些运算符被执行时，系统内部自动将数据类型进行转换，这种转换称为隐式转换。

###### 例——使用数值与字符串进行算术运算

```
let num = 13; // 数值
let num2 = '2'; // 字符串

// 结果为 132
// 原因是将数值 num 转换成了字符串，相当于 '13'
// 然后 + 将两个字符串拼接到了一起
console.log(num + num2);

// 结果为 11
// 原因是将字符串 num2 转换成了数值，相当于 2
// 然后数值 13 减去 数值 2
console.log(num - num2);
```

<br>

#### 显式转换

编写程序时过度依靠系统内部的隐式转换是不严谨的。为了避免因隐式转换带来的问题，通常需要对数据进行显示转换。

###### 转换为数值类型——Number()

`Number()` 可以将变量显示转换成数值类型，转换失败时结果为 `NaN`（Not a Number，即不是一个数字）：

```js
let t = '12';
let f = 8;

// 显式将字符串 12 转换成数值 12
t = Number(t);

// 检测转换后的类型
// console.log(typeof t);
console.log(t + f); // 结果为 20

// 并不是所有的值都可以被转成数值类型
let str = 'hello';
// 将 hello 转成数值是不现实的，当无法转换成
// 数值时，得到的结果为 NaN （Not a Number）
console.log(Number(str));
```

<br>

---

<div STYLE="page-break-after: always;"></div>

## 2.7	模板字符串

#### 模板字符串

使用反引号 ``` ` 包裹的字符串就是模板字符串，模板字符串相当于加强版的字符串。

模板字符串中可以插入变量和表达式，还可以用来定义多行字符串。

###### 例——定义多行字符串

```js
let string1 =  `Hey,
can you stop angry now?`
console.log(string1)
// 输出：
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

---

<div STYLE="page-break-after: always;"></div>

## 2.8	运算符

#### 算术运算符

数学运算符也叫算术运算符，包括：

1. `+`：求和
2. `-`：求差
3. `*`：求积
4. `/`：求商
5. `%`：取模（取余数）

###### 算术运算符的优先级

同时使用多个运算符时，会按照一定顺序先后执行，我们称为优先级：

1. JavaScript 中优先级越高越先被执行；
2. 优先级相同时从左向右执行；
3.  乘、除、取余优先级相同；
4. 加、减优先级相同；
5. 乘、除、取余优先级大于加、减；
6. 使用 `()` 可以提升优先级。

<br>

#### 赋值运算符

赋值运算符是对变量进行赋值的运算符，包括：

1. `=`：将等号右边的值赋予给左边；
2. `+=`
3. `-=`
4. `*=`
5. `/=`
6. `%=`

###### 例 - 使用赋值运算符简化代码

```js
let n = 0
n+=1
console.log(n)
```

<br>

#### 自增/减运算符

自增/减运算符包括：

1. `++`：自增，让变量的值 +1；
2. `--`：自减，让变量的值 -1，

###### 使用场景

自增/减运算符经常用于程序计数。

###### 自增/减运算符前置与后置的差异

1. 前置自增：先自增/减再参与其他运算：

   ```js
   let n = 0
   console.log(++n)// 输出 1
   ```

2. 后置自增：先参与其他运算再自增/减

   ```js
   let n = 0
   console.log(n++)// 输出 0
   ```

<br>

#### 比较运算符

比较运算符用于比较两个数据大小或者是否相等，包括：

1. `>` ：大于
2. `<`： 小于
3. `>=`： 大于或等于
4. `<=`：小于或等于
5. `==`：比较值是否相等，若类型不同，会尝试转换类型；
6. `!=`：比较值是否不相等，若类型不同，会尝试转换类型；
7. `===`： 比较类型和值是否都相等，如果两边值相同，但类型不同则返回 `false`；
8. `!==`：比较类型和值是否不全等，如果两边值相同，但类型不同则返回 `true`；

######  📌比较运算符使用时的注意点

1. 字符串比较，是比较的字符对应的 ASCII 码：
   1. 从左往右依次比较
   2. 如果第一位一样再比较第二位，以此类推
2. NaN 不等于任何值，包括它本身
3. 尽量不要比较小数，因为小数有精度问题
4. 不同类型之间比较会发生隐式转换，最终把数据隐式转换转成 number 类型再比较
5. 开发中，如果需要进行准确的比较，应该使用 `===` 和 `!==`。

<br>

#### 逻辑运算符

逻辑运算符用来解决多重条件判断:

1. `&&`：逻辑与， 符号两边都为 `true`，结果才为 `true`（一假必假）；
2. `||`：逻辑或，符号两边有一个 `true` 就为 `true`（一真必真）；
3. `!`：逻辑非，取反（真变假，假变真）。

##### 逻辑运算符里的短路

短路只存在于 `&&` 和 `||` 中，当满足一定条件会让右边代码不执行，因为通过左边能得到整个式子的结果，因此没必要再判断右边。

短路条件：

1. `&&`：左边为 false 就短路；
2. `||`：左边为 true 就短路。

<br>

#### 运算符优先级

1. `()`：如果有 `()` 则一定先运算括号中的表达式；
2. 一元运算符：一元运算符包括：`++`、`--`、`!`；
3. 算数运算符：算数运算符之间的优先级——`*` 、`/` 、`%` 优先级高于 `+`、`-`；
4. 比较运算符：比较运算符之间的优先级——`>`、`>=`、` <` 、 `<=` 优先级高于 `==`、`!=`、`===`、`!==`；
5. 逻辑运算符：逻辑运算符之间的优先级——`&&` 的优先级高于 `||`；
6.  赋值运算符（`=`）；
7. 逗号运算符（`=`）。

<br>

---

<div STYLE="page-break-after: always;"></div>

# 附录

##### 参考资料

1. 主要参考资料——[前端开发入门教程，web前端零基础html5 +css3+前端项目视频教程](https://www.bilibili.com/video/BV1Kg411T7t9/?p=2&spm_id_from=pageDriver&vd_source=87ed5edcdc8042ca0c34ee5bbeeda7b3) 发布于 2021/11/16；
2. [2.3	变量与常量](#2.3	变量与常量)——[var和let的区别](https://zhuanlan.zhihu.com/p/265002815) 发布于 2020/10/12 最后编辑于 2022/01/17；

<br>