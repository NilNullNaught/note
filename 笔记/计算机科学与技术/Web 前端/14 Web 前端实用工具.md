#### PxCook

#### 代码格式化工具——prettier

#### 日期加减

```
                let date = new Date(Date.parse(this.row.shippingdate))
                date.setDate(date.getDate() - 7);
```

#### 判空

###### 基本类型、数字类型、对象判空

```
if(var){
	...
}
```

###### 数组、集合判空

```
if(arr && arr.length)
```

```
        // 排序
        qw.orderByDesc("createdate");
```

#### 日期控件少一天（实际上是 8 小时）

```
<DatePicker
  :value="form.date"
  @on-change="form.date = $event"
  type="date"
  format="yyyy-MM-dd"
></DatePicker>
```

