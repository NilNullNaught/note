# x	一次执行多条 SQL 语句

##### 前提条件

修改数据库连接参数，加上 `allowMultiQueries=true`

```sql
jdbc:mysql://主机地址:3306/数据库?useSSL=false&allowMultiQueries=true
```

<br>

##### 实现

直接在单个标签内写多条语句，用“；”隔开即可

```xml
<delete id="deleteUserById" parameterType="String">
    delete from sec_user_role where userId=#{id};
    delete from sec_user where id=#{id};
</delete>
```

<br>

----

<div STYLE="page-break-after: always;">
    <br>
	<br>
	<br>
	<br>
	<br>
</div>
