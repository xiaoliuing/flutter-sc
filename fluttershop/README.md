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