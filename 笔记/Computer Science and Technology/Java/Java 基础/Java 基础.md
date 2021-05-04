# 1	概述

## 1.1	Java

##### 什么是 Java

- Java 是一种广泛使用的计算机编程语言，拥有 **跨平台**、**面向对象**、**泛型编程** 的特性，广泛应用于 **企业级 Web 应用开发** 和 **移动应用开发**。

<br>

##### Java 与 C++

- Java 编程语言的风格十分接近 C++。继承了 C++ 面向对象技术的核心，舍弃了容易引起错误的指针，以引用取代；移除了C++中的运算符重载和多重继承特性，用接口取代；增加垃圾回收器功能。

<br>

##### Java 语言的特殊之处

- **Java 不同于一般的编译语言或解释型语言**。它首先将源代码编译成字节码，再依赖各种不同平台上的虚拟机来解释执行字节码，从而具有 **一次编写，到处运行** 的跨平台特性。在早期 JVM 中，这在一定程度上降低了 Java 程序的运行效率。但在J2SE1.4.2发布后，Java的运行速度有了大幅提升。

<br>

##### Java 的语言特性

1. 面向对象
2. 跨平台性
3. 自动垃圾回收（Garbage Collection）

---

<div STYLE="page-break-after: always;"><br></div>

## 1.2	Hello World

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello World!"); // Prints the string to the console.
    }
}
```

---

<div STYLE="page-break-after: always;"><br></div>

# 2	基本语法

## 2.1	标识符的命名规则

##### 大小写敏感

- Java 是大小写敏感的，这就意味着标识符 Hello 与 hello 是不同的。

<br>

##### 类名

- 对于所有的类来说，类名的首字母应该大写。如果类名由若干单词组成，那么每个单词的首字母应该大写<font size=1>（例如 MyFirstJavaClass）</font>。

<br>

##### 方法名

- 所有的方法名都应该以小写字母开头。如果方法名含有若干单词，则后面的每个单词首字母大写<font size=1>（例如 myFirstJavaMethod）</font>。

<br>

##### 源文件名

- 源文件名必须和文件内名字唯一且公开 (即由 public 关键词修饰) 的类名相同。当保存文件的时候，你应该使用该类名作为文件名保存，文件名的后缀为.java。（如果文件名和类名不相同则会导致编译错误）。

<br>

---

<div STYLE="page-break-after: always;"><br></div>

## 2.2	Java 关键字

##### 说明

1. 关键字（keyword），有时也叫保留字（Reserved word），是编程语言中的一类语法结构。在特定的编程语言里，这些保留字具有较为特殊的意义，并且在语言的格式说明里被预先定义。
2. 关键字不能用于常量、变量、和任何标识符的名称。

<br>

##### Java 关键字

|         类别         |            关键字            |         说明         |
| :------------------: | :--------------------------: | :------------------: |
|       访问控制       |           private            |        私有的        |
|      protected       |           受保护的           |                      |
|        public        |            公共的            |                      |
| 类、方法和变量修饰符 |           abstract           |       声明抽象       |
|        class         |              类              |                      |
|       extends        |          扩充,继承           |                      |
|        final         |      最终值,不可改变的       |                      |
|      implements      |         实现（接口）         |                      |
|      interface       |             接口             |                      |
|        native        | 本地，原生方法（非Java实现） |                      |
|         new          |           新,创建            |                      |
|        static        |             静态             |                      |
|       strictfp       |          严格,精准           |                      |
|     synchronized     |          线程,同步           |                      |
|      transient       |             短暂             |                      |
|       volatile       |             易失             |                      |
|     程序控制语句     |            break             |       跳出循环       |
|         case         |   定义一个值以供switch选择   |                      |
|       continue       |             继续             |                      |
|       default        |             默认             |                      |
|          do          |             运行             |                      |
|         else         |             否则             |                      |
|         for          |             循环             |                      |
|          if          |             如果             |                      |
|      instanceof      |             实例             |                      |
|        return        |             返回             |                      |
|        switch        |        根据值选择执行        |                      |
|        while         |             循环             |                      |
|       错误处理       |            assert            |  断言表达式是否为真  |
|        catch         |           捕捉异常           |                      |
|       finally        |       有没有异常都执行       |                      |
|        throw         |       抛出一个异常对象       |                      |
|        throws        |    声明一个异常可能被抛出    |                      |
|         try          |           捕获异常           |                      |
|        包相关        |            import            |         引入         |
|       package        |              包              |                      |
|       基本类型       |           boolean            |        布尔型        |
|         byte         |            字节型            |                      |
|         char         |            字符型            |                      |
|        double        |          双精度浮点          |                      |
|        float         |          单精度浮点          |                      |
|         int          |             整型             |                      |
|         long         |            长整型            |                      |
|        short         |            短整型            |                      |
|         null         |              空              |                      |
|       变量引用       |            super             |      父类,超类       |
|         this         |             本类             |                      |
|         void         |           无返回值           |                      |
|      保留关键字      |             goto             | 是关键字，但不能使用 |
|        const         |     是关键字，但不能使用     |                      |

<br>

---

<div STYLE="page-break-after: always;"><br></div>

## 2.3	主方法入口

##### 主方法入口

- 所有的 Java 程序由 `public static void main(String[] args)` 方法开始执行。

---

<div STYLE="page-break-after: always;"><br></div>

# 3	运算符与表达式

---

<div STYLE="page-break-after: always;"><br></div>

# 4	基本数据类型

---

<div STYLE="page-break-after: always;"><br></div>

# 5	程序流程结构

---

<div STYLE="page-break-after: always;"><br></div>

# 6	引用数据类型

## 6.0

---

<div STYLE="page-break-after: always;"><br></div>

## 6.1	字符串

---

<div STYLE="page-break-after: always;"><br></div>

## 6.2	数组



---

<div STYLE="page-break-after: always;"><br></div>

## 6.3	对象



---

<div STYLE="page-break-after: always;"><br></div>

# 附录

##### 最后编辑时间

- 0000/00/00

##### 环境

- 

##### 参考资料

- 

##### 相关资料

- 

##### 代码链接

[1]:

##### 锚点

[](#1) 

##### 脚注

[^xxx]: 

