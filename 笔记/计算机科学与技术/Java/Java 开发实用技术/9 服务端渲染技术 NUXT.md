# 9	服务端渲染技术 NUXT

## 9.1	NUXT 概述

### 9.1.1	NUXT 技术

##### 异步 ajax 动态加载数据渲染页面为何不利于 SEO[^9.1-1]

搜索引擎爬虫定时爬取页面，因为爬虫不是浏览器，它不是实时等待的，获取到的基本是没有动态渲染数据的 html 静态页面。也就是说**爬虫不会等待 ajax 异步请求数据渲染页面完成再对数据进行抓取**，因为爬虫不知道网站要多久才能渲染完成。

**由于爬虫获取不到异步请求的页面数据，所以就算网页包含搜索引擎的关键字，搜索引擎也不会针对该关键字对你的网页进行收录并建立索引；**

<br>

##### 服务端渲染

服务端渲染又称 SSR（Server Side Render）是在服务端完成页面的内容，而不是在客户端通过 AJAX 获取数据。

服务器端渲染的优势主要在于**更好的 SEO**，也就是说**搜索引擎爬虫抓取工具可以直接查看完全渲染的页面**。如果 SEO 对你的站点至关重要，而你的页面又是异步获取内容，则你可能需要服务器端渲染(SSR)解决此问题。

另外，使用服务器端渲染，我们可以获得更快的内容到达时间（time-to-content），无需等待所有的 JavaScript 都完成下载并执行，产生更好的用户体验，对于那些内容到达时间与转化率直接相关的应用程序而言，服务器端渲染至关重要。

<br>

##### 什么是 NUXT

Nuxt.js 是一个基于 Vue.js 的轻量级应用框架,可用来创建服务端渲染应用,也可充当静态站点引擎生成静态站点应用,具有优雅的代码结构分层和热加载等特性。

<br>

##### 官网网站

https://zh.nuxtjs.org/

<br>

---

[^9.1-1]: SEO（Search Engine Optimization，搜索引擎优化），指利用搜索引擎的规则提高网站在有关搜索引擎内的自然排名。目的是让其在行业内占据领先地位，获得品牌收益。很大程度上是网站经营者的一种商业行为，将自己或自己公司的排名前移。

<div STYLE="page-break-after: always;">
    <br>
	<br>
	<br>
	<br>
	<br>
</div>
### 9.1.2	快速开始

##### 使用步骤

###### 第一步

下载安装包，地址：https://github.com/nuxt-community/starter-template/archive/master.zip

###### 第二步

解压，并将 template 中的内容复制到项目文件夹下。

###### 第三步

安装 ESLint，将 .eslintrc.js 配置文件复制到创建好的项目空目录下。

###### 第四步

修改 package.json：

```json
 "name": "Edu",
 "version": "1.0.0",
 "description": "在线教育前台网站",
 "author": "nilnullnaught <xxx@xxx.com>",
```

###### 第五步

修改 nuxt.config.js

```js
head: {
    title: '谷粒学院 - Java视频|HTML5视频|前端视频|Python视频|大数据视频-自学拿1万+月薪的IT在线视频课程，谷粉力挺，老学员为你推荐',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'keywords', name: 'keywords', content: '谷粒学院,IT在线视频教程,Java视频,HTML5视频,前端视频,Python视频,大数据视频' },
      { hid: 'description', name: 'description', content: '谷粒学院是国内领先的IT在线视频学习平台、职业教育平台。截止目前,谷粒学院线上、线下学习人次数以万计！会同上百个知名开发团队联合制定的Java、HTML5前端、大数据、Python等视频课程，被广大学习者及IT工程师誉为：业界最适合自学、代码量最大、案例最多、实战性最强、技术最前沿的IT系列视频课程！' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
},
```

###### 第六步

在编辑器（VS Code）的命令提示终端中进入项目目录。

###### 第七步

安装依赖

```
npm install
```

###### 第八步

测试运行

```
npm run dev
```

<br>

---

<div STYLE="page-break-after: always;">
    <br>
	<br>
	<br>
	<br>
	<br>
</div>

### 9.1.3	NUXT 目录结构

##### 资源目录 assets

 用于组织未编译的静态资源如 LESS、SASS 或 JavaScript。

<br>

##### 组件目录 components

用于组织应用的 Vue.js 组件。Nuxt.js 不会扩展增强该目录下 Vue.js 组件，即这些组件不会像页面组件那样有 asyncData 方法的特性。

<br>

##### 布局目录 layouts

用于组织应用的布局组件。

<br>

##### 页面目录 pages

用于组织应用的路由及视图。Nuxt.js 框架读取该目录下所有的 .vue 文件并自动生成对应的路由配置。

<br>

##### 插件目录 plugins

用于组织那些需要在 根vue.js应用 实例化之前需要运行的 Javascript 插件。

<br>

##### nuxt.config.js 文件

nuxt.config.js 文件用于组织Nuxt.js 应用的个性化配置，以便覆盖默认配置。

<br>

---

<div STYLE="page-break-after: always;">
    <br>
	<br>
	<br>
	<br>
	<br>
</div>

### 8.1.4	NBUT 项目安装插件

##### 例——安装幻灯片插件

###### 第一步

安装插件

```
npm install vue-awesome-swiper
```

###### 第二步

配置插件，在 plugins 文件夹下新建文件 nuxt-swiper-plugin.js，内容是：

```
import Vue from 'vue'
import VueAwesomeSwiper from 'vue-awesome-swiper/dist/ssr'
Vue.use(VueAwesomeSwiper)
```

在 nuxt.config.js 文件中配置插件，将 plugins 和 css节点 复制到 module.exports节点下：

```
module.exports = {
  // some nuxt config...
  plugins: [
    { src: '~/plugins/nuxt-swiper-plugin.js', ssr: false }
  ],
  css: [
    'swiper/dist/css/swiper.css'
  ]
}
```

<br>

---

<div STYLE="page-break-after: always;">
    <br>
	<br>
	<br>
	<br>
	<br>
</div>
