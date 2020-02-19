import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/index.dart';
import '../service/http_service.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 告诉页面允许缓存

  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  @override
  void initState() { // 重写父类的initState方法
    super.initState();
    print('页面刷新了');
  }
// Text(STitle.homeTitle, style: TextStyle(color: Colors.white),)
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(icon: Icon(Icons.search), onPressed: null),
        title: Container(
          //修饰黑色背景与圆角
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.grey, width: 1.0), //灰色的一层边框
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          alignment: Alignment.center,
          height: 40.0,
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
          child: SearchWidget(),
        )
      ),
      body: FutureBuilder(
        future: request('getHomePageContent', formData: null),
        builder: (context, snapshot){
          if(snapshot.hasData) { // 判断响应结果是否还有数据
            var data = json.decode(snapshot.data.toString());
            List<Map> swiperList = (data['data']['banner_imgs'] as List).cast();
            List<Map> navigationList = (data['data']['category_imgs'] as List).cast();
            return EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: SColor.refreshTextColor,
                moreInfoColor: SColor.refreshTextColor,
                showMore: true,
                moreInfo: STitle.loading,
                loadReadyText: STitle.loadReadyText,
              ),
              child: ListView(
                children: <Widget>[
                  SwiperDiy(   // 轮播图
                    swiperList: swiperList
                  ),
                  ToNavigationBar(
                    navigationList: navigationList
                  )
                ]
              ),
              loadMore: () async {
                print('开始加载中');
              },
            );
          } else {
            return Container(child: Text('数据加载中....'));
          }
        },
      )
    );
  }
}

// 搜索组件
class SearchWidget extends StatelessWidget {
  final editControll = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: editControll,
      decoration: InputDecoration(
        //输入框decoration属性
        // contentPadding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 1.0),
        contentPadding: EdgeInsets.only(bottom: 6.0),
        fillColor: Colors.white,
        border: InputBorder.none,
        // icon: ImageIcon(AssetImage("image/search_meeting_icon.png",),),
        icon: Icon(Icons.search),
        hintText: "搜索商品",
        hintStyle: TextStyle(color: Colors.grey)
      ),
      style: TextStyle(color: Colors.black),
    );
  }
}

// 轮播图组件
class SwiperDiy extends StatelessWidget {
  final List swiperList;
  SwiperDiy({Key key, this.swiperList}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(300),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){

            },
            child: Image.network("${swiperList[index]['img_url']}", fit: BoxFit.cover),
          );
        },
        itemCount: swiperList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      )
    );
  }
}

// 分类导航
class ToNavigationBar extends StatelessWidget {
  final List navigationList;
  ToNavigationBar({Key key, this.navigationList}): super(key: key);

  Widget _navigationItemWidget(BuildContext context, item, index) {
    return InkWell(
      onTap: (){
        //
      },
      child: Column(
        children: <Widget>[
          Image.network("${item['img_url']}", width: ScreenUtil().setWidth(95)),
          Text(
            STitle.navigationTextList[index],
            style: TextStyle(
              fontSize: 12.0
            ),
          )
        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(navigationList.length > 10) {
      navigationList.removeRange(10, navigationList.length);
    }

    int tempIndex = -1;
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 5.0),
      height: ScreenUtil().setHeight(300),
      padding: const EdgeInsets.all(3.0),
      child: GridView.count(
        //禁止滚动
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: const EdgeInsets.all(4.0),
        children: navigationList.map((item){
          tempIndex++;
          return _navigationItemWidget(context, item, tempIndex);
        }).toList(),
      ),
    );
  }
}