

## Ⅰ.2	基本语法



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
