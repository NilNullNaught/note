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
        Mybatis
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


# 1	Mybatis 概述

## 1.1	Mybaits 的优缺点

#### Mybaits 的优点

1. **简单**：简单易学，容易上手（相比于 Hibernate）基于 SQL 编程；
2. **减少了代码量**：与传统 JDBC 编程相比，减少了50%以上的代码量，消除了 JDBC 大量冗余的代码，不需要手动开关连接。
3. **与各种数据库兼容**：因为 MyBatis 使用 JDBC 来连接数据库，所以只要 JDBC 支持的数据库 MyBatis 都支持，而 JDBC 提供了可扩展性，所以只要这个数据库有针对 Java 的 jar 包就可以就可以与 MyBatis 兼容，开发人员不需要考虑数据库的差异性；
4. **支持第三方插件**：Mybait 提供了很多第三方插件（比如分页插件、逆向工程等）；
5. **易与 Spring 集成**：能够与 Spring 很好的集成；
6. **侵入性低、解耦合、重用性高**：MyBatis 相当灵活，不会对应用程序或者数据库的现有设计强加任何影响，SQL 写在 XML 里， 从程序代码中彻底分离，解除 SQL 与程序代码的耦合，便于统一管理和优化，并可重用。
7. **支持动态 SQL** ：提供 XML 标签，支持编写动态 SQL 语句。
8. **支持 ORM 映射**：提供映射标签，支持对象与数据库的 ORM 字段关系映射。
9. **支持对象关系映射**：提供对象关系映射标签，支持对象关系组件维护。

<br>

#### MyBatis 的缺点

1. SQL 语句的编写工作量较大，尤其是字段多、关联表多时，更是如此，**对开发人员编写 SQL 语句的功底有一定要求**；
2. SQL 语句依赖于数据库，导致 **数据库移植性差**，不能随意更换数据库。

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

## 1.2	Mybatis 和 hibernate 有什么区别

#### 相同点

1. Hibernate 与 MyBatis 都是通过 SessionFactoryBuider 根据 XML 配置文件生成 SessionFactory，然后由 SessionFactory 生成 Session，最后由 Session 来开启执行事务和 SQL 语句。其中 SessionFactoryBuider，SessionFactory，Session 的生命周期大致相同。
2. Hibernate 和 MyBatis 都支持 JDBC 和 JTA 事务处理。

<br>

#### 不同点

1. **Hibernate 是全自动， 而 MyBatis是半自动**：Hibernate 完全可以通过对象关系模型实现对数据库的操作，拥有完整的 JavaBean 对象与数据库的映射结构来自动生成 SQL。而 MyBatis 仅有基本的字段映射，对象数据以及对象实际关系仍然需要通过手写 SQL 来实现和管理。
2. **Hibernate 数据库移植性远大于 MyBatis**：Hibernate 通过它强大的映射结构和 HQL 语言，大大降低了对象与数据库（Oracle、 MySQL等） 的耦合性，而 MyBatis 由于需要手写 SQL，因此与数据库的耦合性直接取决于程序员写 SQL 的方法，如果 SQL 不具通用性而用了很多某数据库特性的 SQL 语句，移植性也会降低很多。
3. **Hibernate 拥有完整的日志系统，MyBatis 则欠缺一些**：Hibernate 的日志系统非常健全，涉及广泛，包括：SQL 记录、关系异常、优化警告、缓存提示、脏数据警告等；而 MyBatis 除了基本记录功能外，功能薄弱很多。
4. **MyBatis 相比 Hibernate 需要关心很多细节**：Hibernate 配置要比 MyBatis 复杂的多，学习成本也比 MyBatis 高。但也正因为 MyBatis 使用简单，才导致它要比 Hibernate 关心很多技术细节。MyBatis 由于不用考虑很多细节，开发模式上与传统 JDBC 区别很小，因此很容易上手并开发项目，但忽略细节会导致项目前期 bug 较多，因而开发出相对稳定的软件很慢，而开发出软件却很快。Hibernate 则正好与之相反。但是如果使用 Hibernate 很熟练的话，实际上开发效率丝毫不低于甚至高于 MyBatis。
5. **SQL 直接优化上，MyBatis 要比 Hibernate 方便很多**：由于 MyBatis 的 SQL 都是写在 xml 里，因此优化 SQL 比 Hibernate 方便很多。Hibernate 的 SQL 很多都是自动生成的，无法直接维护 SQL ，虽有 HQL ，但功能还是不及 SQL 强大，见到报表等变态需求时，HQL 也歇菜，也就是说 HQL 是有局限的；Hibernate 虽然也支持原生 SQL，但开发模式上却与 orm 不同，需要转换思维，因此使用上不是非常方便。总之写 SQL 的灵活度上 Hibernate 不及 MyBatis ；
6. **缓存机制上，Hibernate 要比 MyBatis 更好一些**：MyBatis 的二级缓存配置都是在每个具体的表对象映射中进行详细配置，这样针对不同的表可以自定义不同的缓存机制。并且 MyBatis 可以在命名空间中共享相同的缓存配置和实例，通过 Cache-ref 来实现。而 Hibernate 对查询对象有着良好的管理机制，用户无需关心 SQL。所以在使用二级缓存时如果出现脏数据，系统会报出错误并提示。

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

## 1.3	MyBatis 四大对象与插件

#### 什么是 MyBatis 四大对象

MyBatis 的四大对象指的是：

1. executor：MyBatis 的执行器，用于执行增删改查操作；
2. statementHandler：数据库的处理对象，用于执行SQL语句；
3. parameterHandler：处理 SQL 的参数对象；
4. resultHandler：处理 SQL 的返回结果集。

Mybatis 对持久层的操作是借助于这四大核心对象进行的。

<br>

#### MyBatis 插件的实现原理

MyBatis 支持用插件对四大核心对象进行拦截，对 mybatis 来说插件就是拦截器，用来增强核心对象的功能（比如包装对象、额外添加内容），增强功能本质上是借助于底层的动态代理实现的，换句话说，MyBatis 中的四大对象都是代理对象。

<br>

#### 编写插件

1. 实现 Mybatis 的 Interceptor 接口，并复写 intercept() 方法（该方法提供了 invocation 参数，可以通过该参数获取被拦截的参数、业务逻辑等信息）；
2. 给插件编写注解，指定要拦截哪一个接口的哪些方法；
3. 在配置文件中配置编写的插件。

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

## 1.5	MyBatis 中 #{} 和 ${} 的区别是什么?

#### 区别

对参数的处理方式不同，\#{} 是预编译处理，${} 是直接进行字符串替换：

1. MyBatis 在处理 #{} 时，会将 SQL 中的 #{} 替换为 ? 号，调用 PreparedStatement 的 set 方法来赋值；
2. MyBatis 在处理 \${} 时，就是把 \${} 替换成变量的值；

推荐使用 \#{}，\#{} 可以有效的防止 SQL 注入，提高系统安全性，

<br>

##### 📌为什么 \#{} 可以防止 SQL  注入

\#{} 允许数据库进行 **参数化查询**。在使用参数化查询的情况下，数据库不会将参数的内容视为 SQL 语句的一部分，而是作为一个字段的属性值来处理，参数中可能存在的破坏性 SQL（比如 or ‘1=1’ ）不会被执行。

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

# 附录

##### 参考资料

- [1.1	二级标题](#1.1	二级标题)——[参考资料名](地址) 发布于 【0000/00/00】；

<br>