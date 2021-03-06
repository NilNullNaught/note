##### 以下为附录模板

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











##### 文档编辑基本思想

- 类似于字典，可以快速的查阅相关的知识点
- 将查阅速度作为重点的同时，尽量保证可读性
- 在保证正确性和易懂的前提下，尽可能地简化（单段文字最好不要超过三行，如果可以分段最好分段）

<br>

##### 章节与标题级别

- 采用三级目录，最好采用二级目录（非必要不得使用三级目录）
- 标题必须进行编号
- 特殊情况（补充章节）可以使用四级目录
- 五级标题和六级标题不可使用

<br>

##### 标题命名标准

- 标题必须在保证长度不过长的情况下 ，清晰的描述章节的内容

<br>

##### 0 号章节

- 0 号章节一般为引出本大章的内容，可以在其中添加本章节的注意点。（第一大章不使用 0 号章节）

<br>

##### 章节子节点——概念

- 子节点的正文使用无序列表划分段落（*对于有明确数量和顺序的段落，使用有序列表进行划分*）
- 最好能为在每个子节点的段落前面添加总结性的描述（*难以完全实现，因此需要尽量消减段落的长度*）
- 子节点中的如果包含多个概念，必须进行分段。
- 如果子节点中包含的概念过于复杂，应该创建创建新的子节点或者增加新的章节（新章节比父章节小一点）。
- 节点概念复杂导致出现的子章节称为 **补充章节**，不进行正式编号，使用 `+` 加号代替编号，（如 1.1.1 的第一个补充章节为 1.1.1.+）

##### 章节子节点——列表

- 可以不使用

<br>

##### 代码块

- 代码块内部不要添加大段地说明（可以添加单行注释），可以在代码块的后面附加列表进行说明（因为在代码块中不能使用 md 语法，无法标记重点）
- 对于多个文件组成的代码块，在第一行使用注释添加文件名
- 对于过于巨大的代码块，使用外部链接形式展示

<br>

##### 图片

- 图片存放在 md 文件同级的 /img 目录下

##### 未完成章节

- 对于未完成都章节，需要在标题后使用**（未完成）**进行标记

<br>

##### 重点标记

- 对于十分重要的知识点，需要使用 📌 符号进行标记，称为重点标记
- 重点标记通常是容易出现错误的概念
- 重点标记的位置如果位于子节点中，使用  📌**注意**： 的形式进行标记

<br>

##### 补充说明

- 一般用于补充说明，如举例等。
- 使用中文括号包括，并设置内容为斜体。

<br>

##### 英语字段与特殊符号

- 英文字段的前后需要添加空格。
- 如果英文字段表示属性、方法、关键字、链接、文件名、路径名以及固有名词，需要使用短文字形式。
- 对于英语单词、缩写，不需要使用短文字形式
- 但是如果因为字段出现在章节名中，不要使用短文字形式。
- 如果在文中出现了单独的特殊符号，与英文字段做相似的处理。

<br>

##### 锚点

- **定义锚**：

  ```markdown
  <span id="1" style="display:none">⚓</span>
  ```

- **跳转**：

  ```markdown
  [xxx](#1)
  ```

##### 脚注

- 对于需要解释的概念，直接以概念名作为脚注名
- 对于有疑问的知识点，使用 `?` 开头进行标记
- 对于有质疑的知识点，使用 `!`开头进行标记

<br>



# 章节结构参考

##### 说明

- 对本章节知识点进行简要的介绍

##### 为什么需要 XXX

- 本章节介绍的知识点所要解决的问题
- 该子节的大致格式为
  1. xxxx 存在的问题
  2. 解决问题的思路
  3. 为了解决这个问题，引入了 xxx（xxx 正是为了解决这个问题而出现的）

##### XXX 的应用范围

- 

##### XXX 的局限性（缺点）

- 

##### XXX 的语法

```

```

##### 例：XXX 的使用

```

```

##### 📌注意点

##### 属于章节下的概念

- 第一点进行简要说明，不进行分行。
- 从第二点开始，是对章节的补充说明，需要定义标题并且以子列表形式展现，如下：
  - 