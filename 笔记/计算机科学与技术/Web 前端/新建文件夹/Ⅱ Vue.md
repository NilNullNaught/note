# Ⅱ	Vue

## Ⅱ.1	Vue.js 概述

##### Vue.js 是什么

Vue是一套用于构建用户界面的渐进式框架。

Vue 的核心库只关注视图层，不仅易于上手，还便于与第三方库或既有项目整合。另一方面，当与现代化的工具链以及各种支持类库结合使用时，Vue 也完全能够为复杂的单页应用提供驱动。

<br>

##### 声明式渲染

Vue.js 的核心是一个允许采用简洁的模板语法来声明式地将数据渲染进 DOM 的系统，这里的核心思想就是没有繁琐的 DOM 操作，例如 jQuery 中，我们需要先找到 div 节点，获取到 DOM 对象，然后进行一系列的节点操作。 

<br>

##### 官方网站

https://cn.vuejs.org

<br>

----

<div STYLE="page-break-after: always;">
    <br>
	<br>
	<br>
	<br>
	<br>
</div>
## Ⅱ.2	初识 Vue.js

##### 例——Hello World

```js
<!-- id标识vue作用的范围 -->
<div id="app">
    <!-- {{}} 插值表达式，绑定vue中的data数据 -->
    {{ message }}
</div>
<script src="vue.min.js"></script>
<script>

    // 创建一个vue对象
    new Vue({
        el: '#app',//绑定vue作用的范围
        data: {//定义页面中显示的模型数据
            message: 'Hello World!'
        }
    })

</script>
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

## Ⅱ.3	基本语法

##### 指令

vue 指令带有前缀 `v-`。

<br>

##### 单向数据绑定

###### 使用 v-bind

```html
<body>
    <div id="app">
        <h1 v-bind:title="message"><!--使用浏览器右键菜单功能，检查元素，可以看到 title 属性被渲染-->
            标题一
        </h1>

        <!-- v-bind 指令的简写形式： 冒号（:） -->
        <h1 :title="message"><!--使用浏览器右键菜单功能，检查元素，可以看到 title 属性被渲染-->
            标题二
        </h1>

        <h1 ></h1>
    </div>

    <script src="vue.min.js"></script>
    <script>
        new Vue({
            el: '#app',
            data: {
                message: '页面加载于 '+ new Date().toLocaleString()
            }
        })
    </script>
</body>
```

###### 使用 插值表达式

```html
<body>
    <div id="app">
        <h1>
            {{content}}
        </h1>
    </div>

    <script src="vue.min.js"></script>
    <script>
        new Vue({
            el: '#app',
            data: {
                content: '我是标题',
            }
        })
    </script>
</body>
```

<br>

##### 双向数据绑定

使用 v-model 进行双向数据绑定：

```html
<body>
    <div id="app">
        
        <span>双向绑定</span><input type="text" v-model="message" ></input><!-- 修改输入框中的内容，message 会改变-->
        <span>单向绑定</span><input type="text" v-bind:value="message" ></input><!-- message 不会改变-->
        
        <p>{{message}}</p>
    </div>


    <script src="vue.min.js"></script>
    <script>
        new Vue({
            el: '#app',
            data: {
                message: `3.1415926535`
            }
        })
    </script>
</body>
```

<br>

##### 事件

用 v-on 进行事件处理，比如 `v-on:click` 表示处理鼠标点击事件，事件调用的方法定义在 vue 对象声明的 methods 节点中。

```html
<body>

<div id="app">
	<input type="text" v-model="keyword"/>
    <button v-on:click="search()">查询</button>
    <button @:click="search()">查询</button><!-- v-on 指令的简写形式 @ -->

    <p>{{result}}</p>    
</div>

<script src="vue.min.js"></script>
<script>
        new Vue({
            el: '#app',
            data: {
                keyword:``,
                result:``
            },
            methods:{
                search(){
                    this.result = '进行了一次查询，关键字是'+this.keyword
                }
            }
        })
</script>
</body>
```

<br>

##### 修饰符

修饰符（Modifiers）是以半角句号 `.` 指明的特殊后缀，用于指出一个指令应该以特殊方式绑定。

###### 例

```html
<body>

<div id="app">
	<!-- 这里的 .prevent 修饰符告诉 v-on 指令对于触发的事件调用 js 的 event.preventDefault(),
         在表单提交前 -->
    <form action="save" v-on:submit.prevent="onSubmit">
        <label for="username">
            <input type="text" id="username" v-model="user.username">
            <button type="submit">保存</button>
        </label>
    </form>
</div>

<script src="vue.min.js"></script>
<script>
        new Vue({
            el: '#app',
            data: {
                user: {}
            },
            methods:{
                onSubmit() {
                    if (this.user.username) {
                        console.log('提交表单')
                    } else {
                        alert('请输入用户名')
                    }
                }
            }
        })
</script>
</body>
```

<br>

##### 条件渲染

###### v-if

```html
<body>
	<div id="app">
		<input type="checkbox" v-model="ok">是否同意
        	<h1 v-if="ok">同意</h1>
        	<h1 v-else>不同意</h1>
	</div>

	<script src="vue.min.js"></script>
	<script>
        	new Vue({
        	    el: '#app',
        	    data: {
        	        ok: false
        	    }
        	})
	</script>
</body>
```

###### v-show

```
<body>
	<div id="app">
		<input type="checkbox" v-model="ok">是否同意
        	<h1 v-show="ok">同意</h1>
        	<h1 v-show="!ok">不同意</h1>
	</div>

	<script src="vue.min.js"></script>
	<script>
        	new Vue({
        	    el: '#app',
        	    data: {
        	        ok: false
        	    }
        	})
	</script>
</body>
```

###### v-if 和 v-show 之间的区别

- `v-if` 是“真正”的条件渲染，因为它会确保在切换过程中条件块内的事件监听器和子组件适当地被销毁和重建。
- `v-if` 也是**惰性的**：如果在初始渲染时条件为假，则什么也不做——直到条件第一次变为真时，才会开始渲染条件块。
- 相比之下，`v-show` 就简单得多——不管初始条件是什么，元素总是会被渲染，并且只是简单地**基于 CSS 进行切换**。

一般来说，`v-if` 有更高的切换开销，而 `v-show` 有更高的初始渲染开销。因此，如果需要非常频繁地切换，则使用 `v-show` 较好；如果在运行时条件很少改变，则使用 `v-if` 较好。

<br>

##### 列表渲染

###### 例——简单的列表渲染

```html
<body>
    <div id="app">
        <ul>
            <li v-for="n in 10">{{ n }} </li>
        </ul>
    
        <ul>
            <!-- 如果想获取索引，则使用index关键字，注意，圆括号中的index必须放在后面 -->
            <li v-for="(n, index) in 5">{{ n }} - {{ index }} </li>
        </ul>
    </div>

<script src="vue.min.js"></script>
<script>
        new Vue({
            el: '#app'
        })
</script>
</body>
```

###### 例——遍历数据列表

```html
<body>
    <div id="app">
        <table border="1">
            <!-- <tr v-for="item in userList"></tr> -->
            <tr v-for="(item, index) in userList">
                <td>{{index}}</td>
                <td>{{item.id}}</td>
                <td>{{item.username}}</td>
                <td>{{item.age}}</td>
            </tr>
        </table>
    </div>

<script src="vue.min.js"></script>
<script>
        new Vue({
            el: '#app',
            data: {
                userList: [
                    { id: 1, username: 'helen', age: 18 },
                    { id: 2, username: 'peter', age: 28 },
                    { id: 3, username: 'andy', age: 38 }
                ]
            }
        })
</script>
</body>
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
## Ⅱ.4	组件

##### 组件简介

组件（Component）是 Vue.js 最强大的功能之一。组件可以扩展 HTML 元素，封装可重用的代码。

组件系统让我们可以用独立可复用的小组件来构建大型应用，几乎任意类型的应用的界面都可以抽象为一个组件树：

![img](img/0.5887660670164327.png)

<br>

##### 局部组件

```html
<body>
    <div id="app">
        <Navbar></Navbar><!-- 使用局部组件 -->
    </div>
    <script src="vue.min.js"></script>
    <script>
        new Vue({
            el: '#app',
            
            //定义局部组件
            components: {
                //组件的名字
                'Navbar': {
                    //组件的内容
                    template: '<ul><li>首页</li><li>学员管理</li></ul>'
                }
            }
        })
    </script>
</body>
```

<br>

##### 全局组件

###### 定义全局组件

1. 在项目根目录下创建 components 文件夹
2. 在 components 文件夹下创建 Navbar.js 文件

```js
//Navbar.js
Vue.component('Navbar', {
    template: '<ul><li>首页</li><li>学员管理</li><li>讲师管理</li></ul>'
})
```

###### 使用全局组件

1. 引入全局组件
2. 使用全局组件

```html
<div id="app">
    <Navbar></Navbar><!-- 使用全局组件 -->
</div>
<script src="vue.min.js"></script>
<script src="components/Navbar.js"></script><!-- 引入全局组件 -->
<script>
    var app = new Vue({
        el: '#app'
    })
</script>
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

## Ⅱ.5	实例生命周期

![Vue å®ä¾çå½å¨æ](img/0.9177152660737906.png)

##### 勾子方法

```js
//===创建时的四个事件
beforeCreate() { // 第一个被执行的钩子方法：实例被创建出来之前执行
    console.log(this.message) //undefined
    this.show() //TypeError: this.show is not a function
    // beforeCreate执行时，data 和 methods 中的 数据都还没有没初始化
},
created() { // 第二个被执行的钩子方法
    console.log(this.message) //床前明月光
    this.show() //执行show方法
    // created执行时，data 和 methods 都已经被初始化好了！
    // 如果要调用 methods 中的方法，或者操作 data 中的数据，最早，只能在 created 中操作
},
beforeMount() { // 第三个被执行的钩子方法
    console.log(document.getElementById('h3').innerText) //{{ message }}
    // beforeMount执行时，模板已经在内存中编辑完成了，尚未被渲染到页面中
},
mounted() { // 第四个被执行的钩子方法
    console.log(document.getElementById('h3').innerText) //床前明月光
    // 内存中的模板已经渲染到页面，用户已经可以看见内容
},


//===运行中的两个事件
beforeUpdate() { // 数据更新的前一刻
    console.log('界面显示的内容：' + document.getElementById('h3').innerText)
    console.log('data 中的 message 数据是：' + this.message)
    // beforeUpdate执行时，内存中的数据已更新，但是页面尚未被渲染
},
updated() {
    console.log('界面显示的内容：' + document.getElementById('h3').innerText)
    console.log('data 中的 message 数据是：' + this.message)
    // updated执行时，内存中的数据已更新，并且页面已经被渲染
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

## Ⅱ.6	路由

##### Vue.js 路由的作用

允许我们通过不同的 URL 访问不同的内容。通过 Vue.js 可以实现多视图的单页 Web 应用（single page web application，SPA）。

<br>

##### 使用步骤

###### 第一步

引入 vue 和 vue-router 库：

```html
<script src="vue.min.js"></script>
<script src="vue-router.min.js"></script>
```

###### 第二步

编写 html：

```html
<div id="app">
    <h1>Hello App!</h1>
    <p>
        <!-- 使用 router-link 组件来导航. -->
        <!-- 通过传入 `to` 属性指定链接. -->
        <!-- <router-link> 默认会被渲染成一个 `<a>` 标签 -->
        <router-link to="/">首页</router-link>
        <router-link to="/student">会员管理</router-link>
        <router-link to="/teacher">讲师管理</router-link>
    </p>
    
    <!-- 路由出口 -->
    <!-- 路由匹配到的组件将渲染在这里 -->
    <router-view></router-view>
</div>
```

###### 第三步

编写js：

```html
<script>
    // 1. 定义（路由）组件。
    // 可以从其他文件 import 进来
    const Welcome = { template: '<div>欢迎</div>' }
    const Student = { template: '<div>student list</div>' }
    const Teacher = { template: '<div>teacher list</div>' }

    // 2. 定义路由
    // 每个路由应该映射一个组件。
    const routes = [
        { path: '/', redirect: '/welcome' }, //设置默认指向的路径
        { path: '/welcome', component: Welcome },
        { path: '/student', component: Student },
        { path: '/teacher', component: Teacher }
    ]

    // 3. 创建 router 实例，然后传 `routes` 配置
    const router = new VueRouter({
        routes // （缩写）相当于 routes: routes
    })

    // 4. 创建和挂载根实例。
    // 从而让整个应用都有路由功能
    const app = new Vue({
        el: '#app',
        router
    })

    // 现在，应用已经启动了！
</script>
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

## Ⅱ.7	axios

##### axios 简介

axios 是独立于 vue 的一个项目，基于 promise 用于浏览器和 node.js 的 http客 户端

- 在浏览器中可以帮助我们完成 ajax请求的发送
- 在node.js中可以向远程接口发送请求

<br>

##### 使用步骤

###### 第一步

```
<script src="vue.min.js"></script>
<script src="axios.min.js"></script>
```

###### 第二步

```
var app = new Vue({
    el: '#app',
    data: {
        memberList: []//数组
    },
    created() {
        this.getList()
    },

    methods: {

        getList(id) {
            //vm = this
            axios.get('http://localhost:8081/admin/ucenter/member')
            .then(response => {
                console.log(response)
                this.memberList = response.data.data.items
            })
            .catch(error => {
                console.log(error)
            })
        }
    }
})
```

###### 第三步

```
<!-- 测试时需要开启后端服务器，并且后端开启跨域访问权限 -->
<div id="app">
    <table border="1">
        <tr>
            <td>id</td>
            <td>姓名</td>
        </tr>
        <tr v-for="item in memberList">
            <td>{{item.memberId}}</td>
            <td>{{item.nickname}}</td>
        </td>
    </tr>
</table>
</div>
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
