# flutter学习项目

## 声明常量

```javascript
class STitle {
  static const xxx = xxx;
}

// 使用
STitle.xxx
```

## 状态管理

provider（Google开源的）

## 防止页面返回重新渲染

```javascript
class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
}
```

## 一些包

> provide: 数据共享 <br>
> flutter_screenutil: 适配<br>
> dio:  数据异步请求<br>
> flutter_easyrefresh:  懒加载刷新<br>
> flutter_swiper:  轮播图<br>
> fluttertoast:  弹框<br>
> fluro:  配置路由<br>
> flutter_html:  渲染HTML标签<br>
> shared_preferences: 本地持久化存储<br>