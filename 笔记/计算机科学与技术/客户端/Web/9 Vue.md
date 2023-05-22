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
        Vue
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

# 1	Vue 概述

## 1.1	Vue 简介

<br>

----

<div STYLE="page-break-after: always;"></div>

## 1.2	使用 Vue-cli 构建 Vue 项目

#### 步骤

1. 全局安装 Vue-cli：

   ```npm
   npm install --global vue-cli 
   ```

2. 在任意路径下使用以下命令：

   ```
   vue init webpack ${项目名称}
   ```

3. 项目基本设置：

   ![](./assets/Vue/9.2/1.png)

<br>

---

<div STYLE="page-break-after: always;"></div>

## vue

#### this.$set

#### render 函数

#### 混入模式

#### asynic 和 synchro

#### watch 与 computed

---

<div STYLE="page-break-after: always;"></div>

## this.$set

当你发现你给对象加了一个属性，在控制台能打印出来，但是却没有更新到视图上时，也许这个时候就需要用到this.$set（）这个方法了

官方解释：向响应式对象中添加一个属性，并确保这个新属性同样是响应式的，且触发视图更新。它必须用于向响应式对象上添加新属性，因为 Vue 无法探测普通的新增属性

<br>

#### 语法

```vue
Vue.set( target , key , value)
```

1. `target`：要更改的数据源（可以是一个对象或者数组）
2. `key`：要更改的具体数据 （索引）
3. `value`：重新赋的值

<br>

---

<div STYLE="page-break-after: always;"></div>

# 附录

##### 参考资料

1. 主要参考资料——[参考资料名](地址) 发布于 【0000/00/00】最后更新于【0000/00/00】；
1. [1.1	二级标题](#1.1	二级标题)——[参考资料名](地址) 发布于 【0000/00/00】；

<br>

#### ❗❓

