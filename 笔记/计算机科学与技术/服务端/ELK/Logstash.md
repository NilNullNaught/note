# 1	概述

## 1.1	Logstash

##### Logstash 简介

Logstash 是ES技术栈中的一个技术，它是一个数据采集引擎，可以从数据库采集数据到ES中。我们可以通过设置自增id主键或者时间来控制数据的自动同步，这个ID或者时间就是用于给Logstash进行识别的。

**通过 ID 同步**：假设现在有1000条数据，Logstatsh识别后会进行一次同步，同步完会记录这个 id 为 1000，以后数据库新增数据，那么 id 会一直累加， Logstatsh 会有定时任务，发现有id大于1000了，则增量加入到 es 中。

**通过时间同步**：同理，一开始同步1000条数据，每条数据都有一个字段，为time，初次同步完毕后，记录这个time，下次同步的时候进行时间比对，如果有超过这个时间的，那么就可以做同步，这里可以同步新增数据，或者修改元数据，因为同一条数据的时间更改会被识别，而id则不会。

<br>

----

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>
## 1.2	在 Linux 上安装 Logstash

##### 使用 Logstash 的前提条件

- **相同的版本号**：Logstash 的版本号必须与 ElasticSearch 需要保持一致。
- **插件 -logstash-input-jdbc**：本插件用于同步，ES6.x 起自带，这个是集成在 Logstash 中的。所以直接配置同步数据库的配置文件即可。
- **创建索引**：同步数据到ES中，前提是要有索引，索引需要手动创建。

<br>

##### Logstash 下载地址

https://www.elastic.co/cn/downloads/past-releases。

<br>

##### 配置并启动 Logstash

###### 1 - 将下载好的 Logstash 解压，并移动到 usr/local 文件夹下

```
tar -zxvf logstash-7.16.3-linux-x86_64.tar.gz
```

```
mv logstash-7.16.3 usr/local
```

###### 2 - 下载与 Mysql 版本对应的数据库驱动 mysql-connector-java 并创建 mysql 文件夹，将驱动放入该文件夹

###### 3 - 创建 logstash.conf 配置文件

进行如下配置：

```groovy
input {  
    jdbc {
		# 设置 MySql/MariaDB 数据库url以及数据库名称    
        jdbc_connection_string => "jdbc:mysql://localhost:3306/news?useUnicode=true&characterEncoding=utf-8&useSSL=true&serverTimezone=UTC"  
        # 用户名
        jdbc_user => "root"  
		# 密码
        jdbc_password => "root" 
        
        # 数据库驱动所在位置，可以是绝对路径或者相对路径
        jdbc_driver_library => "/usr/local/logstash-7.16.3/mysql/mysql-connector-java-8.0.27.jar"  
        
        # 驱动类名
        jdbc_driver_class => "com.mysql.jdbc.Driver" 
        
        # 开启分页
        jdbc_paging_enabled => "true"  
        
        # 分页每页数量，可以自定义
        jdbc_page_size => "50000"
        
        # 执行的 sql 语句
        statement => "SELECT * FROM news_article WHERE update_time >= :sql_last_value" 
        
        # 设置定时任务间隔  含义：分、时、天、月、年，全部为*默认含义为每分钟j
        schedule => "* * * * *"  
        
        # 是否开启记录上次追踪的结果，也就是上次更新的时间，这个会记录到 last_run_metadata_path 的文件
        use_column_value => true  

        
        # 如果 use_column_value 为true， 配置本参数，追踪的 column 名，可以是自增id或者时间
        tracking_column => "update_time" 
        
        # tracking_column 对应字段的类型
        tracking_column_type => "timestamp"
        
        # 记录上一次追踪的结果值
        last_run_metadata_path => "/usr/local/logstash-5.4.1/sync/track_time"
        
        # 是否清除 last_run_metadata_path 的记录，true则每次都从头开始查询所有的数据库记录
        clean_run => false
        
        type => "news_article"  
        }  
    jdbc {  
        jdbc_connection_string => "jdbc:mysql://localhost:3306/news?useUnicode=true&characterEncoding=utf-8&useSSL=true&serverTimezone=UTC"  
        jdbc_user => "root"  
        jdbc_password => "root"  
        jdbc_driver_library => "F:\elasticsearch-6.4.2_cluster\logstash-6.4.2\bin\mysql\mysql-connector-java-5.1.18.jar"  
        jdbc_driver_class => "com.mysql.jdbc.Driver"  
        jdbc_paging_enabled => "true"  
        jdbc_page_size => "50000"  
        statement => "SELECT * FROM users WHERE update_time >= :sql_last_value"     
        schedule => "*/5 * * * * *"  
        use_column_value => true  
        tracking_column_type => "timestamp"  
        tracking_column => "update_time"  
        type => "users"  
    }  
}  
output {  
    if [type]=="news_article" {  
        elasticsearch {  
        	hosts => ["http://localhost:9200"]  
        	index => "news_article_inx"  
        	document_id => "%{id}"  
        }  
    }  
    if [type]=="users" {  
        elasticsearch {  
        	hosts => ["http://localhost:9200"]  
        	index => "users_inx"  
        	document_id => "%{id}"  
        }  
    }
    # 日志输出
    stdout {
        codec => json_lines
    }}
}  
```

statement 可以通过创建 .sql 文件并通过路径引入

```sql
## 创建emp.sql
select emp_no,birth_date,first_name,last_name,gender,hire_date 
from employees
where hire_date>=:sql_last_value
```

```
input {
    jdbc {
    ...
        # 执行的sql文件路径
        statement_filepath => "/usr/local/logstash-5.4.1/sync/emp.sql"
    ...
    }
}
```

###### 4 - 启动 logstash

```
cd /usr/local/logstash-7.16.3 

./bin/logstash -f config/logstash.conf &
```

- **-f**：代表指定文件路径
- **config/logstash.conf**：配置文件的相对路径（配置文件也可以直接放在根目录下）
- **&**：代表后台启动

<br>

---

<div STYLE="page-break-after: always;">
    <br>
    <br>
    <br>
    <br>
    <br></div>
##### 问题

logstash 中 mysql-connector 驱动突然变为 0kb

```

```



# logstash中同步mysql到elastic常见问题总结

mysql查询字段中有 type字段
问题原因

select语句中查到了type, 但es中会默认有一个type, 这使得两个type冲突.会导致同步失败，且没有报错

GET my_index/_mapping

返回的数据中包含一个type字段如下：

"type" : {
          "type" : "text",
          "fields" : {
            "keyword" : {
              "type" : "keyword",
              "ignore_above" : 256
          }
      }
}
解决办法
去掉type或者改名为其它字段table_type即可, 问题解决

 

2.当配置了保存最后更新记录的情况下，直接删除不能重新同步
record_last_run => true
last_run_metadata_path => "/usr/local/logstash/config/run/ru
n_last_record_id"
当配置是上面这种情况时，如果直接删掉/usr/local/logstash/config/run/run_last_record_id是无法直接重新同步的，还是需要重启下

 

3.logstash向es中导入mysql数据,tinyint字段导入过程中抛出mapper_parsing_exception类型异常
场景：

使用logstash向elasticsearch导入mysql数据，有一个is_top的字段，数据库类型为tinyint(1)，在logstash导入过程中,报错

错误信息为：

Current token (VALUE_FALSE) not numeric, can not use numeric value accessors\n at 
[Source: org.elasticsearch.common.bytes.BytesReference$MarkSupportingStreamInputWrapper@4ad19246; line: 1, column: 355]
es中的mapping为：

{
    "is_top": {
        "type": "long"
    }
}
解决方案：

mysql的导出Jar会默认将tinyint(1)转换为boolean，0则为false，大于0则为true。
解决方法是 将tinyint(1)数据库改为tinyint(2)，tinyint(2)就会默认转成数字，es的mapping用long接受即可。
 另：如果无法改动数据库字段，我查看其它帖子，说是查询时将tinyint(1)字段乘以1后，再作为结果输出
————————————————
版权声明：本文为CSDN博主「私念」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/tiancityycf/article/details/113746415
