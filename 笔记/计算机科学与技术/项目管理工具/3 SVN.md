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
        SVN
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

# 1	SVN 概述

## 1.1	SVN 简介

#### 什么是 SVN

SVN 全称 Subversion，是一个开源版本控制系统，管理着随时间改变的数据。这些数据放置在一个中央资料档案库（repository） 中。 这个档案库很像一个普通的文件服务器, 不过它会记住每一次文件的变动。 这样你就可以把档案恢复到旧的版本, 或是浏览文件的变动历史。说得简单一点SVN就是用于多个人共同开发同一个项目，共用资源的目的。

<br>

#### SVN 的主要功能

1. **目录版本控制**：Subversion 实现了一个 “虚拟” 的版本控管文件系统，能够依据时间跟踪整个目录的变动。 目录和文件都能进行版本控制。
2. **真实的版本历史**：Subversion中，可以增加（add）、删除（delete）、复制（copy）和重命名（rename），无论是文件还是目录。所有的新加的文件都从一个新的、干净的版本开始。
3. **自动提交**：一个提交动作，不是全部更新到了档案库中，就是完全不更新。这允许开发人员以逻辑区间建立并提交变动，以防止只有部分提交成功时出现的问题。

<br>

#### SVN 相关概念

1. Repository（源代码库）：源代码统一存放的地方；
2. Checkout（提取）：当你手上没有源代码的时候，你需要从 repository checkout 一份；
3. Commit（提交）：当你已经修改了代码，你就需要 Commit 到 repository；
4. Update（更新）：Checkout 源代码后，如果其他开发人员更新了源代码，可以通过 Update 将 Repository 上的源代码同步到本地。

<br>

#### SVN 基本使用流程

1. 从服务器下载项目组最新代码（Checkout）。
2. 如果已经 Checkout 并且有人已 Commit 了代码，你可以更新（Update）以获得最新代码。
3. 进入自己的分支，进行工作，每隔一个小时向服务器自己的分支提交一次代码（很多人都有这个习惯。因为有时候自己对代码改来改去，最后又想还原到前一个小时的版本，或者看看前一个小时自己修改了哪些代码，就需要这样做了）。（Commit）
4. 下班时间快到了，把自己的分支合并到服务器主分支上，一天的工作完成，并反映给服务器。（Commit）

<br>

##### SVN 的生命周期

![](img/SVN/1.1/1.png)

###### 创建版本库

版本库相当于一个集中的空间，用于存放开发者所有的工作成果。版本库不仅存放文件，还保存了每次修改的历史，即每个文件的变动历史。

Create 操作用来创建一个新的版本库。大多数情况下这个操作只会执行一次。当你创建一个新的版本库的时候，你的版本控制系统会让你提供一些信息来标识版本库，例如创建的位置和版本库的名字。

###### 检出

Checkout 操作是用来从版本库创建一个工作副本。工作副本是开发者私人的工作空间，可以进行内容的修改，然后提交到版本库中。

###### 更新

顾名思义，update 操作是用来更新版本库的。这个操作将工作副本与版本库进行同步。由于版本库是由整个团队共用的，当其他人提交了他们的改动之后，你的工作副本就会过期。

让我们假设 Tom 和 Jerry 是一个项目的两个开发者。他们同时从版本库中检出了最新的版本并开始工作。此时，工作副本是与版本库完全同步的。然后，Jerry 很高效的完成了他的工作并提交了更改到版本库中。

此时 Tom 的工作副本就过期了。更新操作将会从版本库中拉取 Jerry 的最新改动并将 Tom 的工作副本进行更新。

###### 执行变更

当检出之后，你就可以做很多操作来执行变更。编辑是最常用的操作。你可以编辑已存在的文件来，例如进行文件的添加/删除操作。

你可以添加文件/目录。但是这些添加的文件目录不会立刻成为版本库的一部分，而是被添加进待变更列表中，直到执行了 commit 操作后才会成为版本库的一部分。

同样地你可以删除文件/目录。删除操作立刻将文件从工作副本中删除掉，但该文件的实际删除只是被添加到了待变更列表中，直到执行了 commit 操作后才会真正删除。

Rename 操作可以更改文件/目录的名字。"移动"操作用来将文件/目录从一处移动到版本库中的另一处。

###### 复查变化

当你检出工作副本或者更新工作副本后，你的工作副本就跟版本库完全同步了。但是当你对工作副本进行一些修改之后，你的工作副本会比版本库要新。在 commit 操作之前复查下你的修改是一个很好的习惯。

Status 操作列出了工作副本中所进行的变动。正如我们之前提到的，你对工作副本的任何改动都会成为待变更列表的一部分。Status 操作就是用来查看这个待变更列表。

Status 操作只是提供了一个变动列表，但并不提供变动的详细信息。你可以用 diff 操作来查看这些变动的详细信息。

###### 修复错误

我们来假设你对工作副本做了许多修改，但是现在你不想要这些修改了，这时候 revert 操作将会帮助你。

Revert 操作重置了对工作副本的修改。它可以重置一个或多个文件/目录。当然它也可以重置整个工作副本。在这种情况下，revert 操作将会销毁待变更列表并将工作副本恢复到原始状态。

###### 解决冲突

合并的时候可能会发生冲突。Merge 操作会自动处理可以安全合并的东西。其它的会被当做冲突。例如，“hello.c” 文件在一个分支上被修改，在另一个分支上被删除了。这种情况就需要人为处理。 Resolve 操作就是用来帮助用户找出冲突并告诉版本库如何处理这些冲突。

###### 提交更改

Commit 操作是用来将更改从工作副本到版本库。这个操作会修改版本库的内容，其它开发者可以通过更新他们的工作副本来查看这些修改。

在提交之前，你必须将文件/目录添加到待变更列表中。列表中记录了将会被提交的改动。当提交的时候，我们通常会提供一个注释来说明为什么会进行这些改动。这个注释也会成为版本库历史记录的一部分。Commit 是一个原子操作，也就是说要么完全提交成功，要么失败回滚。用户不会看到成功提交一半的情况。

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

## 1.2	安装 SVN

#### 下载地址

- 客户端：https://tortoisesvn.net/downloads.html
- 服务端：https://www.visualsvn.com/downloads/

<br>

#### 服务端安装步骤

1. 双击安装程序：

   ![](img/SVN/1.2/1.png)

2. 勾选复选框选择同意，然后选择 Next：

   ![](img/SVN/1.2/2.png)

3. 选择默认配置，然后选择 Next：

   ![](img/SVN/1.2/3.png)

4. 设置服务器的安装路径、资源的存放目录及端口：

   ![](img/SVN/1.2/4.png)

5. 选择默认配置，然后选择 Next：

   ![](img/SVN/1.2/5.png)

6. 选择默认配置，然后选择 Next：

   ![](img/SVN/1.2/6.png)

7. 点击 install：

   ![](img/SVN/1.2/7.png)

8. 点击 finish：

   ![](img/SVN/1.2/8.png)

9. 出现如下窗口，则表示安装成功：

   <img src="img/SVN/1.2/9.png" style="zoom:50%;" />

<br>

#### 客户端安装步骤

1. 双击下载好的安装包；

2. 点击 Next：

   ![](img/SVN/1.2/10.png)

3. 安装客户端工具（集成到IDE里面需要）：

   ![](img/SVN/1.2/11.gif)

4. 点击 Finish：

   ![](img/SVN/1.2/12.png)

5. 重启让配置生效：

   ![](img/SVN/1.2/13.png)

6. 在任意空白地方，右键，出现如下内容，则表示安装成功：

   ![](img/SVN/1.2/14.png)

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

## 1.3	配置 SVN

#### SVN 服务端的配置项

服务器端需要提供IP、端口、帐号、密码供客户端使用。

<br>

#### 设置IP和端口号

1. 打开服务器，点击 VisualSVN Server，选择 Configure authentication options…

   <img src="img/SVN/1.3/1.png" style="zoom:50%;" />

2. 设置 Server name，建议使用当前 IP：

![](img/SVN/1.3/2.png)

<br>

#### 新建账号密码

1. 右键左侧菜单User，选择 Create User

   ![](img/SVN/1.3/3.png)

2. 填写账号密码，点击 OK：

![](img/SVN/1.3/4.png)

3. 在浏览器输入 IP 地址和端口号，使用创建的账户去访问仓库：

   ![](img/SVN/1.3/5.png)



<br>

#### 新建分组

1. 右键左侧菜单 Group，选择 Create Group：

   ![](img/SVN/1.3/6.png)

2. 演示：新建Boys分组，然后把 codejiao 用户添加到boys分组：

![](img/SVN/1.3/7.gif)

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

# 2	基本使用

## 2.1	新建版本库

#### 步骤

1. 选择 Repositories 右键，选择 Create New Repository…：

   ![](img/SVN/2.1/1.png)

2. 选择默认设置，选择下一步：

   ![](img/SVN/2.1/2.png)

3. 设置仓库名称：

   ![](img/SVN/2.1/3.png)

4. 设置仓库目录（选择任意一个选项都可）：

   ![](img/SVN/2.1/4.png)

5. 设置仓库的访问权限（这里设置所有 svn 用户都有读/写权限）：

   ![](img/SVN/2.1/5.png)

6. 点击 Create，仓库就创建完成：

   ![](img/SVN/2.1/6.png)

7. 点击 Finish：

   ![](img/SVN/2.1/7.png)

8. 在浏览器输入 IP 地址和端口号，并登录，访问新建的版本库：

   ![](img/SVN/2.1/8.png)

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
## 2.2	将项目迁入（import）到版本库

#### 步骤

1. 拷贝远程仓库的地址，一般把项目放在 trunk 目录：

   ![](img/SVN/2.2/1.png)

2. 选择任意项目，右键选择 TortoiseSVN，选择 import：

   ![](img/SVN/2.2/2.png)

3. 将上一步拷贝的仓库地址粘贴到地址栏，然后点击 OK：

   ![](img/SVN/2.2/3.png)

4. 选择永久接收，然后输入账号密码，然后点击 OK：

   ![](img/SVN/2.2/4.png)

   ![](img/SVN/2.2/5.png)

   ![](img/SVN/2.2/6.png)

5. 打开浏览器，输入用户名和密码，访问刚刚导入的项目：

   ![](img/SVN/2.2/7.png)

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

## 2.3	拉取（check out）项目

#### 步骤

1. 复制要下载的项目的远程地址：

   ![](img/SVN/2.3/1.png)

2. 在为将要拉取的项目准备的本地目录中，右键选择 SVN Checkout…：

   ![](img/SVN/2.3/2.png)

3. 输入远程地址，设置项目的存放位置，然后点击 OK：

   ![](img/SVN/2.3/3.png)

4. 拉取完成：

   ![](img/SVN/2.3/4.png)

5. 查看拉取到本地的项目。


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

## 2.4	提交（commit）代码

#### 提交单个新文件

1. 新建一个文件：

   ![](img/SVN/2.4/1.png)

2. 右键新文件，选择 TortoiseSVN，选择 Add，将文件添加到版本库列表：

   ![](img/SVN/2.4/2.png)

3. add 后，文件上会出现蓝色加号标志，再右键文件，选择 SVN Commit：

   ![](img/SVN/2.4/3.png)

4. 设置提交信息：

   ![](img/SVN/2.4/4.png)

5. 完成提交：

   ![](img/SVN/2.4/5.png)

6. 完成提交的文件会显示绿色勾号标志。

<br>

#### 提交新增的所有文件

1. 在项目根目录下点击右键：

   ![](img/SVN/2.4/6.png)

2. add 完成后，在项目根目录下点击右键选择 SVN Commit，其他步骤与提交单个文件时相同。

<br>

#### 提交对文件的修改

对于不涉及文件增加的修改，直接使用 SVN Commit 即可提交。

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
## 2.5	更新代码

##### 说明

如果当前资源不是最新版本，则可在项目中空白地方右键，选择 SVN Update。

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


# 3	其他

## 3.1	版本回退

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

## 3.2	权限

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

## 3.3	分支

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

## 3.4	提交忽略

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

## 3.5	删除本地文件并同步到版本库

#### 步骤

1. 进入项目目录，右键空白处，打开版本库浏览器：

   ![](img/SVN/3.5/1.png)

2. 在版本库浏览器中选择需要删除的文件或文件夹：

   ![](img/SVN/3.5/2.png)

3. 选中文件后，右键删除：

   ![](img/SVN/4.5/3.png)

4. 输入备注，点击 OK：

   ![](img/SVN/3.5/4.png)

5. 删除后会自动提交到服务端：

   ![](img/SVN/3.5/5.png)

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

## 3.6	解决合并冲突问题

#### 冲突发生的原因

如果两个用户 **同时** 修改了同一个文件， SVN 可以合并这两个程序员的改动，因为 SVN 管理源代码是以行为单位的，只要不是修改了同一行程序，SVN 会自动合并两种修改。如果是同一行，SVN 会提示文件 conflict，需要手动确认。

<br>

#### 模拟冲突发生的场景

1. A、B 两用户都将最新的项目文件 update 到本地：

   ![](img/SVN/3.6/1.png)

2. A、B 对同一个文件的同一行进行了各自的修改：

   ![](img/SVN/3.6/2.png)

   ![](img/SVN/4.6/3.png)

   

3. A 成功提交。

4. B 提交失败：

   ![](img/SVN/3.6/4.png)

5. 更新 B 的本地代码，出现以下状况：

   ![](img/SVN/3.6/5.png)

<br>

#### 解决冲突

###### 注意

出现冲突时，尽量不要直接用自己的代码覆盖别人的代码，如果确实需要覆盖，需要先与对方进行协商。

###### 步骤

1. 右键冲突文件，选择 Edit conflicts：

   ![](img/SVN/3.6/6.png)

2. 将 A 和 B 的代码都添加到修改，修改完成后选择 "Mark as resolved"，然后选择"Save”，关闭窗口即可：

   ![](img/SVN/3.6/7.gif)

<br>

##### 如何降低冲突发生的概率

1. 当文档编辑完成后，尽快提交，频繁的提交/更新可以降低在冲突发生的概率，以及发生时解决冲突的复杂度。
2. 在提交时，写上明确的信息，方便以后查找用户更新的原因，毕竟随着时间的推移，对当初更新的原因有可能会遗忘。
3. 养成良好的使用习惯：
   1. 每天开始工作时，首先从版本库获取最新版本；
   2. 每次提交后，都进行一次更新；
   3. 每天下班前，将已经编辑过的文档提交到版本库。

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
# 4	IDEA 集成 SVN

## 4.1	在 IDEA 中使用 SVN

#### 配置 IDEA 的 SVN 相关设置

1. 进入全局配置：

   ![](img/SVN/4.1/1.png)

2. 配置 SVN：

   ![](img/SVN/4.1/2.png)

3. 重启 IDEA。

<br>

#### 将本地项目上传到 SVN 服务器

1. 选择 VCS—> lmport into Version Control —> lmport into Subversion；
2. 选择"+"添加项目导入的地址（可手动添加一个文件夹，项目中的文件会放置在该文件夹中，文件名自定义）；
3. 选择要导入的路径，选择 lmport；
4. 选择要导入的项目，点击 OK；
5. 检查导入的路径，填写导入信息，选择 OK；
6. 在远程仓库中检查是否导入成功即可。

<br>

#### 从 SVN 服务器上获取项目

1. 选择 Get from VCS：

   ![](img/SVN/4.1/3.gif)

2. 选择项目要存放的位置：

   ![](img/SVN/4.1/4.png)

<br>

#### 提交代码

1. 选择 VCS-> Compmit…

   ![](img/SVN/4.1/5.png)

2. 选择需要提交的文件，填写提交信息，选择 Commit

   ![](img/SVN/4.1/6.png)

<br>

#### 更新代码

1. 选择 VCS->Update Project…

   ![](img/SVN/4.1/7.png)

2. 点击 OK：

   ![](img/SVN/4.1/8.png)

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

## 4.2	在 IDEA 中解决版本冲突问题

#### 步骤

1. 如果未更新，就提交资源（有其他用户也提交过资源），则提交失败

   ![](img/SVN/4.2/1.png)

2. 此时，执行更新操作，将其他人提交过的资源更新到本地，会提示冲突

   ![](img/SVN/4.2/2.png)

3. 通常选择合并，再选择需要保留的代码，选择好之后选择 Apply

   ![](img/SVN/4.2/3.png)

4. 提示更新成功：
   ![](img/SVN/4.2/4.png)

5. 再次选择提交，成功解决冲突
   ![](img/SVN/4.2/5.png)

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

- 主要参考资料——[SVN的安装和介绍以及SVN的配置和使用（包含IDEA集成SVN、SVN解决版本冲突问题）](https://blog.csdn.net/I_r_o_n_M_a_n/article/details/124935799) 发布于 【0000/00/00】；
- [4.5	删除本地文件并同步到版本库](#4.5	删除本地文件并同步到版本库)——[如何删除SVN上的文件](https://jingyan.baidu.com/article/5d6edee2b3622199eadeecee.html) 发布于 2018/10/20；

<br>