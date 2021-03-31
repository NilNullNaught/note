# X	存储过程

## X.0	存储过程概述

**SQL Serve 存储过程：**

- SQL Server 中的存储过程是由一个或多个 Transact-SQL 语句或对 Microsoft .NET Framework 公共语言运行时 (CLR) 方法的引用所构成的一个组。

**存储过程与其他编程语言中方法的相同点：**

- 接受输入参数并以输出参数的格式向调用程序返回多个值。
- 包含用于在数据库中执行操作的编程语句。 这包括调用其他存储过程。
- 向调用程序返回状态值，以指明成功或失败（以及失败的原因）。

**存储过程的优点：**

- **减少了服务器/客户端网络流量**：
  - 存储过程中的命令作为代码的单个批处理执行。 这可以显著减少服务器和客户端之间的网络流量，因为只有对执行存储过程的调用才会跨网络发送。 如果没有存储过程提供的代码封装，每个单独的代码行都不得不跨网络发送。
- **更强的安全性：**
  - 多个用户和客户端程序可以通过存储过程对基础数据库对象执行操作，即使用户和程序对这些基础对象没有直接权限。 存储过程控制执行哪些进程和活动，并且保护基础数据库对象。 这消除在了单独的对象级别授予权限的要求，并且简化了安全层。
  - 可在 CREATE PROCEDURE 语句中指定 [EXECUTE AS](https://docs.microsoft.com/zh-cn/sql/t-sql/statements/execute-as-clause-transact-sql?view=sql-server-ver15) 子句以便实现对其他用户的模拟，或者使用户或应用程序无需针对基础对象和命令的直接权限，即可执行某些数据库活动。 例如，某些操作（如 TRUNCATE TABLE）没有可授予的权限。 若要执行 TRUNCATE TABLE，用户必须对指定表具有 ALTER 权限。 授予用户对表的 ALTER 权限可能不是最佳方法，因为用户将拥有超出截断表的能力的权限。 通过将 TRUNCATE TABLE 语句纳入模块中并指定该模块作为一个有权修改表的用户执行，您可以将截断表的权限扩展至授予其对模块的 EXECUTE 权限的用户。
  - 在通过网络调用存储过程时，只有对执行存储过程的调用是可见的。 因此，恶意用户无法看到表和数据库对象名称、嵌入自己的 Transact-SQL 语句或搜索关键数据。
  - 使用存储过程参数有助于避免 SQL 注入攻击。 因为参数输入被视作文字值而非可执行代码，所以，攻击者将命令插入存储过程内的 Transact-SQL 语句并损害安全性将更为困难。
  - 可以对存储过程进行加密，这有助于对源代码进行模糊处理。
- **代码的重复使用：**
  - 任何重复的数据库操作的代码都非常适合于在存储过程中进行封装。 这消除了不必要地重复编写相同的代码、降低了代码不一致性，并且允许拥有所需权限的任何用户或应用程序访问和执行代码。
- **更容易维护：**
  - 在客户端应用程序调用存储过程并且将数据库操作保持在数据层中时，对于基础数据库中的任何更改，只有存储过程是必须更新的。 应用程序层保持独立，并且不必知道对数据库布局、关系或进程的任何更改的情况。
- **提高了性能：**
  - 默认情况下，在首次执行存储过程时将编译存储过程，并且创建一个执行计划，供以后的执行重复使用。 因为查询处理器不必创建新计划，所以，它通常用更少的时间来处理存储过程。
  - 如果存储过程引用的表或数据有显著变化，则预编译的计划可能实际上会导致存储过程的执行速度减慢。 在此情况下，重新编译存储过程和强制新的执行计划可提高性能。

**存储过程的类型：**

- **用户定义**：
  - 用户定义的过程可在用户定义的数据库中创建，或者在除了 **Resource** 数据库之外的所有系统数据库中创建。 该过程可在 Transact-SQL 中开发，或者作为对 Microsoft .NET Framework 公共语言运行时 (CLR) 方法的引用开发。
- **临时**：
  - 临时过程是用户定义过程的一种形式。 临时过程与永久过程相似，只是临时过程存储于 **tempdb** 中。 临时过程有两种类型：本地过程和全局过程。 它们在名称、可见性以及可用性上有区别。 本地临时过程的名称以单个数字符号 (#) 开头；它们仅对当前的用户连接是可见的；当用户关闭连接时被删除。 全局临时过程的名称以两个数字符号 (##) 开头，创建后对任何用户都是可见的，并且在使用该过程的最后一个会话结束时被删除。
- **系统**：
  - 系统过程是 SQL Server随附的。 它们物理上存储在内部隐藏的 **Resource** 数据库中，但逻辑上出现在每个系统定义数据库和用户定义数据库的 **sys** 架构中。 此外， **msdb** 数据库还在 **dbo** 架构中包含用于计划警报和作业的系统存储过程。 因为系统过程以前缀 **sp_** 开头，所以，我们建议你在命名用户定义过程时不要使用此前缀。 有关系统过程的完整列表，请参阅[系统存储过程 (Transact-SQL)](https://docs.microsoft.com/zh-cn/sql/relational-databases/system-stored-procedures/system-stored-procedures-transact-sql?view=sql-server-ver15)。
  - SQL Server 支持在 SQL Server 和外部程序之间提供一个接口以实现各种维护活动的系统过程。 这些扩展过程使用 xp_ 前缀。 有关扩展过程的完整列表，请参阅[常规扩展存储过程 (Transact-SQL)](https://docs.microsoft.com/zh-cn/sql/relational-databases/system-stored-procedures/general-extended-stored-procedures-transact-sql?view=sql-server-ver15)。
- **扩展的用户定义[^1]**：
  - 扩展过程允许你使用编程语言（例如 C）创建外部例程。这些过程是指 SQL Server 的实例可以动态加载和运行的 DLL。

**📌创建存储过程需要权限：**

- 创建存储过程需要在数据库中有 CREATE PROCEDURE 权限，在 schema  中有 ALTER 权限。

---

<br>

## x.1 创建存储过程

### x.1.1	通过 SQL Server Management Studio 创建

**步骤**：

1. 在 **“对象资源管理器”** 中，连接到 **数据库引擎** 的实例，然后展开该实例。

2. 依次展开 **“数据库”** 、AdventureWorks2012 数据库和 **“可编程性”** 。

3. 右键单击“存储过程”，再单击“新建存储过程”。

4. 在 **“查询”** 菜单上，单击 **“指定模板参数的值”** 。

5. 在 **“指定模板参数的值”** 对话框中，输入下列所示的参数值。

   | 参数                     | 值                                 |
   | :----------------------- | :--------------------------------- |
   | 作者                     | *您的姓名*                         |
   | 创建日期                 | *今天的日期*                       |
   | 说明                     | 返回雇员数据。                     |
   | Procedure_name           | HumanResources.uspGetEmployeesTest |
   | @Param1                  | @LastName                          |
   | @Datatype_For_Param1     | **nvarchar**(50)                   |
   | Default_Value_For_Param1 | Null                               |
   | @Param2                  | @FirstName                         |
   | @Datatype_For_Param2     | **nvarchar**(50)                   |
   | Default_Value_For_Param2 | Null                               |

6. 单击“确定”。

7. 在 **“查询编辑器”** 中，使用以下语句替换 SELECT 语句：

   SQL复制

   ```sql
   SELECT FirstName, LastName, Department  
   FROM HumanResources.vEmployeeDepartmentHistory  
   WHERE FirstName = @FirstName AND LastName = @LastName  
       AND EndDate IS NULL;  
   ```

8. 若要测试语法，请在 **“查询”** 菜单上，单击 **“分析”** 。 如果返回错误消息，则请将这些语句与上述信息进行比较，并视需要进行更正。

9. 若要创建该过程，请在 **“查询”** 菜单上单击 **“执行”** 。 该过程作为数据库中的对象创建。

10. 若要查看在对象资源管理器中列出的过程，请右键单击“存储过程”，然后选择“刷新”。

11. 若要运行该过程，请在对象资源管理器中右键单击存储过程名称 **HumanResources.uspGetEmployeesTest**，然后选择“执行存储过程”。

12. 在“执行过程”窗口中，输入 Margheim 作为参数 @LastName 的值，并输入值 Diane 作为参数 @FirstName 的值。

---

<br>

### x.1.2	使用 Transact-SQL 创建存储过程

**步骤**：

1. 在 **“对象资源管理器”** 中，连接到 数据库引擎的实例。

2. 从 **“文件”** 菜单中，单击 **“新建查询”** 。

3. 将以下示例复制并粘贴到查询窗口中，然后单击“执行” 。 该示例将使用其他过程名称创建与上述相同的存储过程。

   复制

   ```
   USE AdventureWorks2012;  
   GO  
   CREATE PROCEDURE HumanResources.uspGetEmployeesTest2   
       @LastName nvarchar(50),   
       @FirstName nvarchar(50)   
   AS   
   
       SET NOCOUNT ON;  
       SELECT FirstName, LastName, Department  
       FROM HumanResources.vEmployeeDepartmentHistory  
       WHERE FirstName = @FirstName AND LastName = @LastName  
       AND EndDate IS NULL;  
   GO  
   ```

4. 若要运行该过程，请将以下示例复制并粘贴到一个新的查询窗口中，然后单击 **“执行”** 。 请注意，将显示指定参数值的不同方法。

   复制

   ```
   EXECUTE HumanResources.uspGetEmployeesTest2 N'Ackerman', N'Pilar';  
   -- Or  
   EXEC HumanResources.uspGetEmployeesTest2 @LastName = N'Ackerman', @FirstName = N'Pilar';  
   GO  
   -- Or  
   EXECUTE HumanResources.uspGetEmployeesTest2 @FirstName = N'Pilar', @LastName = N'Ackerman';  
   GO  
   ```

---

<br>

## x.2	修改存储过程

---

<br>

## x.3	删除存储过程

---

<br>

## x.4	执行存储过程



---

<br>

# 附录

**最后编辑时间：**

- 2021/2/9

**适用版本：**

- SQL Server 2017

**参考资料：**

- [Microsoft SQL 文档](https://docs.microsoft.com/zh-cn/sql/?view=sql-server-ver15)
- 

**脚注：**

[^1]: SQL Server的未来版本中将删除扩展存储过程。 请不要在新的开发工作中使用该功能，并尽快修改当前还在使用该功能的应用程序。 请改为创建 CLR 过程。 此方法提供了更为可靠和安全的替代方法来编写扩展过程。

**注意点：**

[^!1]: 

**疑问：**

[^?1]: 

