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
        Apache POI

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

# 1	Apache poi 概述

## 1.1	Apache poi 简介

#### Apache POI

Apache POI[^1.1-1] 是用 Java 编写的免费开源的跨平台的 Java API，具有创建和维护各种符合 Office OpenXML（OOXML）和 OLE 2 复合文档格式的功能，可对 Word、Excel、PowerPoint 进行读写操作。

<br>



---

[^1.1-1]: 全称 Poor Obfuscation Implementation，意为“简陋又模糊的实现”

<div STYLE="page-break-after: always;"></div>

## 1.2	项目导入

#### 📌根据需要处理的 Excel 文件类型导入依赖

Excel 文档分为 XLS（针对 Excel 97-2003）格式和 XLSX（针对 Excel 2007 及以后版本）格式，不同格式所需的 JAR 包依赖是不一样的。

下面的依赖仅支持 XLS 格式：

```xml
<dependency>
    <groupId>org.apache.poi</groupId>
    <artifactId>poi</artifactId>
    <version>${version}</version>
</dependency>
```

以下依赖既支持 XLS 格式，也支持 XLSX 格式：

```xml
<dependency>
    <groupId>org.apache.poi</groupId>
    <artifactId>poi-ooxml</artifactId>
    <version>${version}</version>
</dependency>
```

<br>

---

<div STYLE="page-break-after: always;"></div>

## 1.3	POI Excel 处理基本流程

#### 📌注意

1. Excel 文件有两种格式：`.xls` 和 `.xlsx`，需要分别进行处理。

<br>

#### 步骤

###### 1 - 读取模板 Excel 文件

###### 2 - 解析 Excel 文件并替换单元格

###### 3 - 创建新的 Excel 文件并写入

<br>

---

<div STYLE="page-break-after: always;"></div>

# 附录

##### 参考资料

1. 主要参考资料——[参考资料名](地址) 发布于 【0000/00/00】最后更新于【0000/00/00】；
1. [1.1	二级标题](#1.1	二级标题)——[参考资料名](地址) 发布于 【0000/00/00】；

<br>

#### ❗❓

