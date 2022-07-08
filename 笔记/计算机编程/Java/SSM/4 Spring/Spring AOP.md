# 1	概述

## 1.1	AOP

##### 什么是 AOP

AOP （Aspect Orient Programming，即  **面向切面编程**） 是一种编程思想，是面向对象编程（OOP）的一种补充。面向对象编程将程序抽象成各个层次的对象，而**面向切面编程是将程序抽象成各个切面**。

![img](img/758949-20190529225344641-152289598.png)

从上图可以很形象地看出，所谓切面，相当于应用对象间的横切点，我们可以将其单独抽象为单独的模块。

<br>

##### 为什么需要 AOP 

在传统的面向过程编程中，如果在多个模块间有某段重复的代码，通常会将这段代码，抽象成一个方法，然后在需要的地方分别调用这个方法。这样当这段代码需要修改时，我们只需要改变这个方法就可以了。

然而需求总是变化的，有一天，新增了一个需求，需要再多出做修改，我们需要再抽象出一个方法，然后再在需要的地方分别调用这个方法，又或者我们不需要这个方法了，我们还是得删除掉每一处调用该方法的地方。实际上涉及到多个地方具有相同的修改的问题我们都可以通过 AOP 来解决。

<br>

##### AOP 的作用

AOP 要达到的效果是，**在不修改源代码的前提下，为系统中的业务组件添加某种通用功能**。AOP 的本质是由 AOP 框架修改业务组件的多个方法的源代码，实际上，AOP 其实就是代理模式的典型应用。

<br>

##### AOP 实现分类

按照 AOP 框架修改源代码的时机，可以将其分为两类：

- **静态 AOP 实现**： AOP 框架在编译阶段对程序源代码进行修改，生成了静态的 AOP 代理类（生成的 *.class 文件已经被改掉了，需要使用特定的编译器），比如 AspectJ。
- **动态 AOP 实现**： AOP 框架在运行阶段对动态生成代理对象（在内存中以 JDK 动态代理，或 CGlib 动态地生成 AOP 代理类），如 SpringAOP。

常用 AOP 实现方式比较：

| 类别           | 机制         | 原理                                                         | 优点                     | 缺点                                             |
| -------------- | ------------ | ------------------------------------------------------------ | ------------------------ | ------------------------------------------------ |
| 静态AOP        | 静态织入     | 在编译期，切面直接以字节码的形式编译到目标字节码文件中。     | 对系统无性能影响         | 灵活性不够。                                     |
| 动态AOP        | JDK 动态代理 | 在运行期，目标类加载后，为接口动态生成代理类，将切面织入到代理类中。 | 相对于静态AOP更加灵活    | 切入的关注点需要实现接口。对系统有一定性能影响。 |
| 动态字节码生成 | CGLIB        | 在运行期，目标类加载后，动态生成目标类的子类，将切面逻辑加入到子类中 | 没有接口也可以织入       | 扩展类的实例方法用 final 修饰时，则无法进行织入  |
| 自定义类加载器 |              | 在运行期，目标类加载前，将切面逻辑加到目标字节码里           | 可以对绝大部分类进行织入 | 代码中如果使用了其他类加载器，则这些类将不会织入 |
| 字节码转换     |              | 在运行期，所有类加载器加载字节码前，进行拦截                 | 可以对所有类进行织入     |                                                  |

<br>

##### AOP 术语

AOP 领域中的特性术语：

- **通知（Advice）**: AOP 框架中的增强处理。通知描述了切面何时执行以及如何执行增强处理。
- **连接点（join point）**: 连接点表示应用执行过程中能够插入切面的一个点，这个点可以是方法的调用、异常的抛出。在 Spring AOP 中，连接点总是方法的调用。
- **切点（PointCut）**: 可以插入增强处理的连接点。
- **切面（Aspect）**: 切面是通知和切点的结合。
- **引入（Introduction）**：引入允许我们向现有的类添加新的方法或者属性。
- **织入（Weaving）**: 将增强处理添加到目标对象中，并创建一个被增强的对象，这个过程就是织入。

<br>

---

<div STYLE="page-break-after: always;">
    <br>
	<br>
	<br>
	<br>
	<br>
</div>

## 1.2	Spring AOP

##### Spring AOP 的特点

###### 实现原理

Spring 中的 AOP 是通过动态代理实现的。

###### 局限

Spring AOP 不能拦截对对象字段的修改，也不支持构造器连接点[^1.2.-1]，无法在 Bean 创建时应用通知。

<br>

##### 例 - Spring AOP

###### 1 - 依赖

```xml
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-context</artifactId>
    <version>5.3.16</version>
</dependency>

<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-aspects</artifactId>
    <version>5.3.16</version>
</dependency>
```

###### 2 - 代码

1. 创建 IBuy 接口

```java
public interface IBuy {
    String buy();
}
```

2. 创建 Boy 类和 Gril 类分别实现 IBuy 接口：

```java
@Component
public class Boy implements IBuy {
    @Override
    public String buy() {
        System.out.println("男孩买了一个游戏机");
        return "游戏机";
    }
}
```

```java

import org.springframework.stereotype.Component;

@Component
public class Girl implements IBuy {
    @Override
    public String buy() {
        System.out.println("女孩买了一件漂亮的衣服");
        return "衣服";
    }
}
```

3. 配置文件

```java
@Configuration
@ComponentScan(basePackageClasses = {com.sharpcj.aopdemo.test1.IBuy.class})
@EnableAspectJAutoProxy(proxyTargetClass = true)// 启用 AOP 切面功能
public class AppConfig {
	// 该配置类不需要内容
}
```

4. 定义切面类

```
@Aspect
@Component
public class BuyAspectJ {
    @Before("execution(* com.sharpcj.aopdemo.test1.IBuy.buy(..))")
    public void haha(){
        System.out.println("男孩女孩都买自己喜欢的东西");
    }
}
```



4. 测试类

```java
public class AppTest {
    public static void main(String[] args) {
        AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);
        Boy boy = context.getBean("boy",Boy.class);
        Girl girl = (Girl) context.getBean("girl");
        boy.buy();
        girl.buy();
    }
}
```

###### 3 - 运行结果

![img](img/758949-20190529225446321-1741506938.png)

<br>

---

[^1.2-1]: AOP 框架有很多种，不同的 AOP 框架支持的连接点也有所区别，例如，AspectJ 和 JBoss，除了支持方法切点，它们还支持字段和构造器的连接点。

<div STYLE="page-break-after: always;">
    <br>
	<br>
	<br>
	<br>
	<br>
</div>

# 2	通过注解配置 Spring AOP

## 2.1 通过注解声明切点指示器

Spring AOP 所支持的 AspectJ 切点指示器
![img](img/758949-20190529225507103-314276426.png)
在spring中尝试使用AspectJ其他指示器时，将会抛出IllegalArgumentException异常。

当我们查看上面展示的这些spring支持的指示器时，注意只有execution指示器是唯一的执行匹配，而其他的指示器都是用于限制匹配的。这说明execution指示器是我们在编写切点定义时最主要使用的指示器，在此基础上，我们使用其他指示器来限制所匹配的切点。

下图的切点表达式表示当Instrument的play方法执行时会触发通知。
![img](img/758949-20190529225530124-1714809272.png)
我们使用execution指示器选择Instrument的play方法，方法表达式以 `*` 号开始，标识我们不关心方法的返回值类型。然后我们指定了全限定类名和方法名。对于方法参数列表，我们使用 `..` 标识切点选择任意的play方法，无论该方法的入参是什么。
多个匹配之间我们可以使用链接符 `&&`、`||`、`！`来表示 “且”、“或”、“非”的关系。但是在使用 XML 文件配置时，这些符号有特殊的含义，所以我们使用 “and”、“or”、“not”来表示。

举例：
限定该切点仅匹配的包是 `com.sharpcj.aopdemo.test1`,可以使用
`execution(* com.sharpcj.aopdemo.test1.IBuy.buy(..)) && within(com.sharpcj.aopdemo.test1.*)`
在切点中选择 bean,可以使用
`execution(* com.sharpcj.aopdemo.test1.IBuy.buy(..)) && bean(girl)`
修改 BuyAspectJ.java

```java
package com.sharpcj.aopdemo.test1;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class BuyAspectJ {
    @Before("execution(* com.sharpcj.aopdemo.test1.IBuy.buy(..)) && within(com.sharpcj.aopdemo.test1.*) && bean(girl)")
    public void hehe(){
        System.out.println("男孩女孩都买自己喜欢的东西");
    }
}
```

此时，切面只会对 `Girl.java` 这个类生效，执行结果：
![img](img/758949-20190529225548745-1785519580.png)

细心的你，可能发现了，切面中的方法名，已经被我悄悄地从`haha`改成了`hehe`，丝毫没有影响结果，说明方法名没有影响。和 Spring IOC 中用 java 配置文件装配 Bean 时，用`@Bean` 注解修饰的方法名一样，没有影响。

## 4.2 通过注解声明 5 种通知类型

Spring AOP 中有 5 中通知类型，分别如下：
![img](img/758949-20190529225613898-1522094074.png)

下面修改切面类：

```java
package com.sharpcj.aopdemo.test1;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class BuyAspectJ {
    @Before("execution(* com.sharpcj.aopdemo.test1.IBuy.buy(..))")
    public void hehe() {
        System.out.println("before ...");
    }

    @After("execution(* com.sharpcj.aopdemo.test1.IBuy.buy(..))")
    public void haha() {
        System.out.println("After ...");
    }

    @AfterReturning("execution(* com.sharpcj.aopdemo.test1.IBuy.buy(..))")
    public void xixi() {
        System.out.println("AfterReturning ...");
    }

    @Around("execution(* com.sharpcj.aopdemo.test1.IBuy.buy(..))")
    public void xxx(ProceedingJoinPoint pj) {
        try {
            System.out.println("Around aaa ...");
            pj.proceed();
            System.out.println("Around bbb ...");
        } catch (Throwable throwable) {
            throwable.printStackTrace();
        }
    }

}
```

为了方便看效果,我们测试类中，只要 Boy 类:

```java
package com.sharpcj.aopdemo;

import com.sharpcj.aopdemo.test1.Boy;
import com.sharpcj.aopdemo.test1.Girl;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class AppTest {
    public static void main(String[] args) {
        AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);
        Boy boy = context.getBean("boy",Boy.class);
        Girl girl = (Girl) context.getBean("girl");
        boy.buy();
        // girl.buy();
    }
}
```

执行结果如下：
![img](img/758949-20190529225633682-474468038.png)

结果显而易见。指的注意的是 `@Around` 修饰的环绕通知类型，是将整个目标方法封装起来了，在使用时，我们传入了 `ProceedingJoinPoint` 类型的参数，这个对象是必须要有的，并且需要调用 `ProceedingJoinPoint` 的 `proceed()` 方法。 如果没有调用 该方法，执行结果为 ：

```erlang
Around aaa ...
Around bbb ...
After ...
AfterReturning ...
```

可见，如果不调用该对象的 proceed() 方法，表示原目标方法被阻塞调用，当然也有可能你的实际需求就是这样。

## 4.3 通过注解声明切点表达式

如你看到的，上面我们写的多个通知使用了相同的切点表达式，对于像这样频繁出现的相同的表达式，我们可以使用 `@Pointcut`注解声明切点表达式，然后使用表达式，修改代码如下：
BuyAspectJ.java

```java
package com.sharpcj.aopdemo.test1;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class BuyAspectJ {

    @Pointcut("execution(* com.sharpcj.aopdemo.test1.IBuy.buy(..))")
    public void point(){}

    @Before("point()")
    public void hehe() {
        System.out.println("before ...");
    }

    @After("point()")
    public void haha() {
        System.out.println("After ...");
    }

    @AfterReturning("point()")
    public void xixi() {
        System.out.println("AfterReturning ...");
    }

    @Around("point()")
    public void xxx(ProceedingJoinPoint pj) {
        try {
            System.out.println("Around aaa ...");
            pj.proceed();
            System.out.println("Around bbb ...");
        } catch (Throwable throwable) {
            throwable.printStackTrace();
        }
    }
}
```

程序运行结果没有变化。
这里，我们使用

```java
@Pointcut("execution(* com.sharpcj.aopdemo.test1.IBuy.buy(..))")
public void point(){}
```

声明了一个切点表达式，该方法 point 的内容并不重要，方法名也不重要，实际上它只是作为一个标识，供通知使用。

## 4.4 通过注解处理通知中的参数

上面的例子，我们要进行增强处理的目标方法没有参数，下面我们来说说有参数的情况，并且在增强处理中使用该参数。
下面我们给接口增加一个参数，表示购买所花的金钱。通过AOP 增强处理，如果女孩买衣服超过了 68 元，就可以赠送一双袜子。
更改代码如下：
IBuy.java

```java
package com.sharpcj.aopdemo.test1;

public interface IBuy {
    String buy(double price);
}
```

Girl.java

```typescript
package com.sharpcj.aopdemo.test1;

import org.springframework.stereotype.Component;

@Component
public class Girl implements IBuy {
    @Override
    public String buy(double price) {
        System.out.println(String.format("女孩花了%s元买了一件漂亮的衣服", price));
        return "衣服";
    }
}
```

Boy.java

```typescript
package com.sharpcj.aopdemo.test1;

import org.springframework.stereotype.Component;

@Component
public class Boy implements IBuy {
    @Override
    public String buy(double price) {
        System.out.println(String.format("男孩花了%s元买了一个游戏机", price));
        return "游戏机";
    }
}
```

再看 BuyAspectJ 类，我们将之前的通知都注释掉。用一个环绕通知来实现这个功能：

```python
package com.sharpcj.aopdemo.test1;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class BuyAspectJ {

    /*
    @Pointcut("execution(* com.sharpcj.aopdemo.test1.IBuy.buy(..))")
    public void point(){}

    @Before("point()")
    public void hehe() {
        System.out.println("before ...");
    }

    @After("point()")
    public void haha() {
        System.out.println("After ...");
    }

    @AfterReturning("point()")
    public void xixi() {
        System.out.println("AfterReturning ...");
    }

    @Around("point()")
    public void xxx(ProceedingJoinPoint pj) {
        try {
            System.out.println("Around aaa ...");
            pj.proceed();
            System.out.println("Around bbb ...");
        } catch (Throwable throwable) {
            throwable.printStackTrace();
        }
    }
    */


    @Pointcut("execution(String com.sharpcj.aopdemo.test1.IBuy.buy(double)) && args(price) && bean(girl)")
    public void gif(double price) {
    }

    @Around("gif(price)")
    public String hehe(ProceedingJoinPoint pj, double price){
        try {
            pj.proceed();
            if (price > 68) {
                System.out.println("女孩买衣服超过了68元，赠送一双袜子");
                return "衣服和袜子";
            }
        } catch (Throwable throwable) {
            throwable.printStackTrace();
        }
        return "衣服";
    }
}
```

前文提到，当不关心方法返回值的时候，我们在编写切点指示器的时候使用了 `*` ， 当不关心方法参数的时候，我们使用了 `..`。现在如果我们需要传入参数，并且有返回值的时候，则需要使用对应的类型。在编写通知的时候，我们也需要声明对应的返回值类型和参数类型。

测试类：AppTest.java

```java
package com.sharpcj.aopdemo;

import com.sharpcj.aopdemo.test1.Boy;
import com.sharpcj.aopdemo.test1.Girl;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class AppTest {
    public static void main(String[] args) {
        AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);
        Boy boy = context.getBean("boy",Boy.class);
        Girl girl = (Girl) context.getBean("girl");
        String boyBought = boy.buy(35);
        String girlBought = girl.buy(99.8);

        System.out.println("男孩买到了：" + boyBought);
        System.out.println("女孩买到了：" + girlBought);
    }
}
```

测试结果：
![img](img/758949-20190529225709155-1683416178.png)
可以看到，我们成功通过 AOP 实现了需求，并将结果打印了出来。

## 4.5 通过注解配置织入的方式

前面还有一个遗留问题，在配置文件中，我们用注解 `@EnableAspectJAutoProxy()` 启用Spring AOP 的时候，我们给参数 `proxyTargetClass` 赋值为 `true`,如果我们不写参数，默认为 false。这个时候运行程序，程序抛出异常
![img](img/758949-20190529225724860-1448694025.png)

这是一个强制类型转换异常。为什么会抛出这个异常呢？或许已经能够想到，这跟Spring AOP 动态代理的机制有关，这个 `proxyTargetClass` 参数决定了代理的机制。当这个参数为 false 时，
通过jdk的基于接口的方式进行织入，这时候代理生成的是一个接口对象，将这个接口对象强制转换为实现该接口的一个类，自然就抛出了上述类型转换异常。
反之，`proxyTargetClass` 为 `true`，则会使用 cglib 的动态代理方式。这种方式的缺点是拓展类的方法被`final`修饰时，无法进行织入。
测试一下，我们将 `proxyTargetClass` 参数设为 `true`，同时将 Girl.java 的 Buy 方法用 `final` 修饰：
AppConfig.java

```kotlin
package com.sharpcj.aopdemo;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

@Configuration
@ComponentScan(basePackageClasses = {com.sharpcj.aopdemo.test1.IBuy.class})
@EnableAspectJAutoProxy(proxyTargetClass = true)
public class AppConfig {
}
```

Girl.java

```java
package com.sharpcj.aopdemo.test1;

import org.springframework.stereotype.Component;

@Component
public class Girl implements IBuy {
    @Override
    public final String buy(double price) {
        System.out.println(String.format("女孩花了%s元买了一件漂亮的衣服", price));
        return "衣服";
    }
}
```

此时运行结果：
![img](img/758949-20190529225755992-1036671637.png)

可以看到，我们的切面并没有织入生效。

# 五、通过 XML 配置文件声明切面

前面的示例中，我们已经展示了如何通过注解配置去声明切面，下面我们看看如何在 XML 文件中声明切面。下面先列出 XML 中声明 AOP 的常用元素：
![img](img/758949-20190529232014979-1838628294.png)

我们依然可以使用 `<aop:aspectj-autoproxy>` 元素，他能够自动代理AspectJ注解的通知类。

## 5.1 XML 配置文件中切点指示器

在XML配置文件中，切点指示器表达式与通过注解配置的写法基本一致，区别前面有提到，即XML文件中需要使用 “and”、“or”、“not”来表示 “且”、“或”、“非”的关系。

## 5.2 XML 文件配置 AOP 实例

下面我们不使用任何注解改造上面的例子：
BuyAspectJ.java

```csharp
package com.sharpcj.aopdemo.test2;

import org.aspectj.lang.ProceedingJoinPoint;

public class BuyAspectJ {

    public void hehe() {
        System.out.println("before ...");
    }

    public void haha() {
        System.out.println("After ...");
    }

    public void xixi() {
        System.out.println("AfterReturning ...");
    }

    public void xxx(ProceedingJoinPoint pj) {
        try {
            System.out.println("Around aaa ...");
            pj.proceed();
            System.out.println("Around bbb ...");
        } catch (Throwable throwable) {
            throwable.printStackTrace();
        }
    }
}
```

在 Resource 目录下新建一个配置文件 aopdemo.xml ：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd">

    <bean id="boy" class="com.sharpcj.aopdemo.test2.Boy"></bean>
    <bean id="girl" class="com.sharpcj.aopdemo.test2.Girl"></bean>
    <bean id="buyAspectJ" class="com.sharpcj.aopdemo.test2.BuyAspectJ"></bean>

    <aop:config proxy-target-class="true">
        <aop:aspect id="qiemian" ref="buyAspectJ">
            <aop:before pointcut="execution(* com.sharpcj.aopdemo.test2.IBuy.buy(..))" method="hehe"/>
            <aop:after pointcut="execution(* com.sharpcj.aopdemo.test2.IBuy.buy(..))" method="haha"/>
            <aop:after-returning pointcut="execution(* com.sharpcj.aopdemo.test2.IBuy.buy(..))" method="xixi"/>
            <aop:around pointcut="execution(* com.sharpcj.aopdemo.test2.IBuy.buy(..))" method="xxx"/>
        </aop:aspect>
    </aop:config>
</beans>
```

这里分别定义了一个切面，里面包含四种类型的通知。
测试文件中，使用

```java
ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("aopdemo.xml");
```

来获取 ApplicationContext，其它代码不变。

## 5.3 XML 文件配置声明切点

对于频繁重复使用的切点表达式，我们也可以声明成切点。
配置文件如下：aopdemo.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd">

    <bean id="boy" class="com.sharpcj.aopdemo.test2.Boy"></bean>
    <bean id="girl" class="com.sharpcj.aopdemo.test2.Girl"></bean>
    <bean id="buyAspectJ" class="com.sharpcj.aopdemo.test2.BuyAspectJ"></bean>

    <aop:config proxy-target-class="true">
        <aop:pointcut id="apoint" expression="execution(* com.sharpcj.aopdemo.test2.IBuy.buy(..))"/>
        <aop:aspect id="qiemian" ref="buyAspectJ">
            <aop:before pointcut-ref="apoint" method="hehe"/>
            <aop:after pointcut-ref="apoint" method="haha"/>
            <aop:after-returning pointcut-ref="apoint" method="xixi"/>
            <aop:around pointcut-ref="apoint" method="xxx"/>
        </aop:aspect>
    </aop:config>
</beans>
```

## 5.4 XML文件配置为通知传递参数

BuyAspectJ.java

```kotlin
package com.sharpcj.aopdemo.test2;

import org.aspectj.lang.ProceedingJoinPoint;

public class BuyAspectJ {
public String hehe(ProceedingJoinPoint pj, double price){
        try {
            pj.proceed();
            if (price > 68) {
                System.out.println("女孩买衣服超过了68元，赠送一双袜子");
                return "衣服和袜子";
            }
        } catch (Throwable throwable) {
            throwable.printStackTrace();
        }
        return "衣服";
    }
}
```

aopdemo.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd">

    <bean id="boy" class="com.sharpcj.aopdemo.test2.Boy"></bean>
    <bean id="girl" class="com.sharpcj.aopdemo.test2.Girl"></bean>
    <bean id="buyAspectJ" class="com.sharpcj.aopdemo.test2.BuyAspectJ"></bean>

    <aop:config proxy-target-class="true">
        <aop:pointcut id="apoint" expression="execution(String com.sharpcj.aopdemo.test2.IBuy.buy(double)) and args(price) and bean(girl)"/>
        <aop:aspect id="qiemian" ref="buyAspectJ">
            <aop:around pointcut-ref="apoint" method="hehe"/>
        </aop:aspect>
    </aop:config>
</beans>
```

## 5.5 Xml 文件配置织入的方式

同注解配置类似,
CGlib 代理方式：

```verilog
<aop:config proxy-target-class="true"> </aop:config>
```

JDK 代理方式：

```verilog
<aop:config proxy-target-class="false"> </aop:config>
```

# 六、总结

本文简单记录了 AOP 的编程思想，然后介绍了 Spring 中 AOP 的相关概念，以及通过注解方式和XML配置文件两种方式使用 Spring AOP进行编程。 相比于 AspectJ 的面向切面编程，Spring AOP 也有一些局限性，但是已经可以解决开发中的绝大多数问题了，如果确实遇到了 Spring AOP 解决不了的场景，我们依然可以在 Spring 中使用 AspectJ 来解决。

<br>

----

<div STYLE="page-break-after: always;">
    <br>
	<br>
	<br>
	<br>
	<br>
</div>
