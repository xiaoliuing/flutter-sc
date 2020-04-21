import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttershop/model/category_model.dart';
import 'package:fluttershop/provider/category_page_provider.dart';
import 'package:fluttershop/provider/current_page_index.dart';
import 'package:provide/provide.dart';
import '../config/index.dart';
import '../service/http_service.dart';
import '../routes/application.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 告诉页面允许缓存
  int page = 1;
  List<Map> hotGoosList = [];

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
            List<Map> swiperList = (data['data']['banner_imgs'] as List).cast(); // 轮播图·
            List<Map> navigationList = (data['data']['category_imgs'] as List).cast(); // 分类图标
            List<Map> advertImgs = (data['data']['advert_imgs'] as List).cast(); // 广告图片
            List<Map> floorImgs = (data['data']['floor_imgs'] as List).cast(); // 广告图片
            List<Map> recommandGoods = (data['data']['query'] as List).cast(); // 推荐
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
                  ),
                  RecommandList(
                    recommandList: recommandGoods
                  ),
                  MiddleAdert(
                    ad1: advertImgs[0]['img_url']
                  ),
                  Floor(floor: floorImgs),
                  _hotWidget()
                ]
              ),
              loadMore: () async {
                print('开始加载中');
                _getHotGoods();
              },
            );
          } else {
            return Container(child: Text('数据加载中....'));
          }
        },
      )
    );
  }
  void _getHotGoods(){
    var formPage = {'page': page};
    request('getHotGoods', formData: formPage).then((val){
      var data = json.decode(val.toString());
      List<Map> _newList = (data['data']['query'] as List).cast();
      print(_newList);
      setState(() {
        hotGoosList.addAll(_newList);
        page++;
      });
    });
  }

  Widget _hotList(){
    if(hotGoosList.length != 0) {
      List<Widget> listWidget = hotGoosList.map((val){
        return InkWell(
          onTap: (){
            Application.router.navigateTo(context, '/details?id=${val['goods_id']}');
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    val['s_img'],
                    width: ScreenUtil().setWidth(375),
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 6, right: 6, top: 10),
                  child: Text(
                    val['g_name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: ScreenUtil().setSp(26)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 6, right: 6, top: 13),
                  child: Row(
                  children: <Widget>[
                    Text('￥${val['pre_price']}', style: TextStyle(color: Colors.black26, decoration: TextDecoration.lineThrough)),
                    Text('￥${val['price']}', style: TextStyle(color: Colors.red))
                  ],
                ),
                ),
              ]
            ),
          ),
        );
      }).toList();
      return Wrap(
        spacing: 2,
        children: listWidget
      );
    }else{
      return Text('');
    }
  }
  Widget _hotTitle(){
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(5.0),
      child: Text('火爆专区'),
    );
  }
  Widget _hotWidget(){
    return Container(
      child: Column(
        children: <Widget>[
          _hotTitle(),
          _hotList(),
        ]
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
      readOnly: true,
      onTap: (){
        Application.router.navigateTo(context, '/search');
      },
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
      // color: Colors.white,
      height: ScreenUtil().setHeight(250),
      width: ScreenUtil().setWidth(730),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, 15.0), //阴影xy轴偏移量
            blurRadius: 10.0, //阴影模糊程度
            spreadRadius: 10.0 //阴影扩散程度
          )
        ]
      ),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              Application.router.navigateTo(context, '/details?id=00${index+1}');
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network("${swiperList[index]['img_url']}", fit: BoxFit.cover),
            )
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
        _goCategoryPage(context, index, '${index+1}');
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

  // 跳转到分类
  void _goCategoryPage(context, index, String categoryId)async{
    await request('getCategory', formData: null).then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      List list = category.data;
      Provide.value<CategoryProvider>(context).changeFirstCategory(categoryId, index+1);
      Provide.value<CategoryProvider>(context).getSecondCategory(list[index+1].secondCategoryVO, categoryId);
      Provide.value<CurrentIndexProvide>(context).changeIndex(1);  // 页面跳转
    });
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
      height: ScreenUtil().setHeight(260),
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

// 热门推荐
class RecommandList extends StatelessWidget {
  final List recommandList;
  RecommandList({Key key, this.recommandList}): super(key: key);

  // 推荐标题
  Widget _recommandTitle(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: SColor.defaultBorderColor)
        )
      ),
      child: Text(
        STitle.recommandTitle,
        style: TextStyle(
          color: SColor.recommandTextColor
        ),
      ),
    );
  }

  // 推荐的商品
  Widget _recommandList(BuildContext context){
    return Container(
      height: ScreenUtil().setHeight(300),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommandList.length,
        itemBuilder: (context, index){
          return _item(context, index);
        }
      )
    );
  }

  Widget _item(context, index){
    return InkWell(
      onTap: (){
        Application.router.navigateTo(context, '/details?id=${recommandList[index]['goods_id']}');
      },
      child: Container(
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border(
          //   left: BorderSide(width: 0.5, color: SColor.defaultBorderColor)
          // )
        ),
        child: Column(
          children: <Widget>[
            // 防止溢出
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(recommandList[index]['s_img'], height: ScreenUtil().setHeight(100),)
              )
            ),
            Text(
              '￥${recommandList[index]['price']}',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            Text(
              '￥${recommandList[index]['pre_price']}',
              style: TextStyle(
                color: Colors.black26,
                decoration: TextDecoration.lineThrough
              ),
            )
          ],
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _recommandTitle(),
          _recommandList(context),
        ],
      ),
    );
  }
}

// 广告
class MiddleAdert extends StatelessWidget {
  final String ad1;
  MiddleAdert({Key key, this.ad1}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: InkWell(
        onTap: (){},
        child: Image.network(
          ad1,
          fit: BoxFit.cover
        )
      ),
    );
  }
}

// 火爆专区
class Floor extends StatelessWidget {
  final List floor;
  Floor({Key key, this.floor}) : super(key: key);

  void _jumpGoodsDetail(BuildContext context, [String id]){
    if(id != null){
      Application.router.navigateTo(context, '/details?id=$id');
    }
  }

  @override
  Widget build( BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 4),
                  height: ScreenUtil().setHeight(400),
                  child: InkWell(
                    onTap: (){
                      _jumpGoodsDetail(context);
                    },
                    child: Image.network(
                      '${floor[0]['img_url']}',
                      fit: BoxFit.cover
                    ),
                  )
                ),
                Container(
                  padding: EdgeInsets.only(top: 1, right: 1),
                  height: ScreenUtil().setHeight(400),
                  child: InkWell(
                    onTap: (){
                      _jumpGoodsDetail(context);
                    },
                    child: Image.network(
                      '${floor[1]['img_url']}',
                      fit: BoxFit.cover
                    ),
                  )
                )
              ]
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 4, left: 1),
                  height: ScreenUtil().setHeight(200),
                  child: InkWell(
                    onTap: (){
                      _jumpGoodsDetail(context);
                    },
                    child: Image.network(
                      '${floor[3]['img_url']}',
                      fit: BoxFit.cover
                    ),
                  )
                ),
                Container(
                  padding: EdgeInsets.only(top: 1, left: 1),
                  height: ScreenUtil().setHeight(200),
                  child: InkWell(
                    onTap: (){
                      _jumpGoodsDetail(context);
                    },
                    child: Image.network(
                      '${floor[4]['img_url']}',
                      fit: BoxFit.cover
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 1, left: 1),
                  height: ScreenUtil().setHeight(200),
                  child: InkWell(
                    onTap: (){
                      _jumpGoodsDetail(context);
                    },
                    child: Image.network(
                      '${floor[5]['img_url']}',
                      fit: BoxFit.cover
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 1, left: 1),
                  height: ScreenUtil().setHeight(200),
                  child: InkWell(
                    onTap: (){
                      _jumpGoodsDetail(context);
                    },
                    child: Image.network(
                      '${floor[6]['img_url']}',
                      fit: BoxFit.cover
                    ),
                  ),
                )
              ]
            ),
          )
        ]
      ),
    );
  }
}