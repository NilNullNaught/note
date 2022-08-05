# 1	WPF

## 1.1	概述



##### WPF 的用途

- 使用 Windows Presentation Foundation（WPF），你可以创建适用于 Windows 且具有非凡视觉效果的 **桌面客户端应用程序**。

---

<div STYLE="page-break-after: always;"></div>

# 2	

---

<div STYLE="page-break-after: always;"></div>

# Ⅰ	数据绑定

## Ⅰ.1	MVVM 模式

---

<div STYLE="page-break-after: always;"></div>

## Ⅰ.2	单向绑定与双向绑定

---

<div STYLE="page-break-after: always;"></div>

## Ⅰ.3	MVVM Light

---

<div STYLE="page-break-after: always;"></div>

## Ⅰ.4	Microsoft.Toolkit.Mvvm 高性能包



---

<div STYLE="page-break-after: always;"></div>

# Ⅱ	使用技巧

## Ⅱ.1	自定义应用程序入口

##### 步骤

1. 创建程序入口类<font size=1>（入口类的类名可以自定义，但是建议使用 Program.cs）</font>

2. 将入口类修改为静态类，并写入以下代码：

   ```c#
   namespace WPFDemo
   {
       public static class Program
       {
           /// <summary>
           /// Application Entry Point.
           /// </summary>
           [System.STAThreadAttribute()]
           [System.Diagnostics.DebuggerNonUserCodeAttribute()]
           [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
           public static void Main()
           {
               WPFDemo.App app = new WPFDemo.App();//创建 WPF 项目的 Application 实例，用来启动WPF项目
               app.InitializeComponent();
               app.Run();
           }
       }
   }
   ```

   - WPFDemo 为项目名，同时也是默认命名空间

3. 打开项目属性 → 应用程序 → 启动对象 ，设置启动对象为自定义的程序入口类。

---

 <div STYLE="page-break-after: always;"></div>

## Ⅱ.2	使用 App.config 作为配置文件



---

<div STYLE="page-break-after: always;"></div>

## Ⅱ.3	修改项目的起始窗口

在

---

<div STYLE="page-break-after: always;"></div>

## 窗口

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

