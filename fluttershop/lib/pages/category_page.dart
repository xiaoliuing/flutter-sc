import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttershop/model/category_goods_model.dart';
import 'package:fluttershop/provider/category_goods_provider.dart';
import 'package:fluttershop/routes/application.dart';
import 'package:provide/provide.dart';
import '../config/index.dart';
import '../service/http_service.dart';
import '../model/category_model.dart';
import '../provider/category_page_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
bool isSec = false;
class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(STitle.categoryPageTitle, style: TextStyle(color: Colors.white),)
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                RightCategoryGoods()
              ]
            )
          ]
        )
      ),
    );
  }
}
// 左侧分类导航
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0; // 索引

  @override
  void initState(){
    super.initState();
    _getCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryProvider>(
      builder: (context, child, val) {
        _getGoodList(context);
        listIndex = val.firstCategoryIndex;
        return Container(
          width: ScreenUtil().setWidth(160),
          decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1, color: SColor.defaultBorderColor))
          ),
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index){
              return _leftInkWell(index);
            }
          ),
        );
      },
    );
  }

  Widget _leftInkWell(int index){
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;

    return InkWell(
      onTap: (){
        var secondCategoryList = list[index].secondCategoryVO;
        var firstCategoryId = list[index].firstCategoryId;

        Provide.value<CategoryProvider>(context).changeFirstCategory(firstCategoryId, index);
        Provide.value<CategoryProvider>(context).getSecondCategory(secondCategoryList, firstCategoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(70),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 238, 239, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: SColor.defaultBorderColor),
            left: BorderSide(width: 2, color: isClick ? SColor.primaryColor : Colors.white)
          )
        ),
        child: Center(
          child: Text(
            list[index].firstCategoryName,
            style: TextStyle(
              color: isClick ? SColor.primaryColor : Colors.black,
              fontSize: ScreenUtil().setSp(28),
            )
          )
        ),
      ),
    );
  }
  
  // 获取分类数据
  _getCategoryData() async {
    await request('getCategory', formData: null).then((val){
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      Provide.value<CategoryProvider>(context).getSecondCategory(list[0].secondCategoryVO, '0');
    });
  }

  _getGoodList(context, {String secondCategoryId}){
    if(!isSec){
      var data = {
        'firstCategoryId': Provide.value<CategoryProvider>(context).firstCategoryId,
        'secondCategoryId': '',
        'page': 1
      };
      request('getCategoryGoods', formData: data).then((val){
        var data = json.decode(val.toString());
        CategoryGoodsListModel goodList = CategoryGoodsListModel.fromJson(data);
        if(goodList.data == null) {
          Provide.value<CategoryGoodsProvider>(context).getCategoryGoodsList([]);
        }else {
          Provide.value<CategoryGoodsProvider>(context).getCategoryGoodsList(goodList.data);
        }
      });
    }else{
      isSec = false;
    }
  }
}

// 右侧分类导航
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<CategoryProvider>(
        builder: (context, child, categoryProvider) {
        return Container(
          height: ScreenUtil().setHeight(70),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 1, color: SColor.defaultBorderColor),
            ),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryProvider.secondCategoryList.length,
            itemBuilder: (context, index) {
              return _rightInkWell(index, categoryProvider.secondCategoryList[index]);
            }),
        );
      }),
    );
  }

  Widget _rightInkWell(int index, SecondCategoryVO item){
    bool isClick = false;
    isClick = (index == Provide.value<CategoryProvider>(context).secondCategoryIndex) ? true : false;

    return InkWell(
      onTap: (){
        Provide.value<CategoryProvider>(context).changeSecondIndex(index, item.secondCategoryId);
        _getGoodList(context, secondCategoryId: item.secondCategoryId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Center(
          child: Text(
            item.secondCategoryName,
            style: TextStyle(
              color: isClick ? SColor.primaryColor : Colors.black,
              fontSize: ScreenUtil().setSp(28),
            )
          )
        ),
      ),
    );
  }

  _getGoodList(context, {String secondCategoryId}){
    var data = {
      'firstCategoryId': Provide.value<CategoryProvider>(context).firstCategoryId,
      'secondCategoryId': secondCategoryId,
      'page': 1
    };
    isSec = true;
    print(isSec);
    request('getCategoryGoods', formData: data).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodList = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsProvider>(context).getCategoryGoodsList(goodList.data);
    });
  }
}

// 右侧商品列表
class RightCategoryGoods extends StatefulWidget {
  @override
  _RightCategoryGoodsState createState() => _RightCategoryGoodsState();
}

class _RightCategoryGoodsState extends State<RightCategoryGoods> {
  GlobalKey<RefreshFooterState> _footKey = new GlobalKey<RefreshFooterState>();

  ScrollController _scrollControll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsProvider>(
      builder: (context, child, data){
        try{
          if(Provide.value<CategoryProvider>(context).page == 1) {
            _scrollControll.jumpTo(0);
          }
        }catch(e){
          print('init:$e');
        }

        if(data.goodsList.length > 0){
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              child: EasyRefresh(
                refreshFooter: ClassicsFooter(
                  key: _footKey,
                  bgColor: Colors.white,
                  textColor: SColor.refreshTextColor,
                  moreInfoColor: SColor.refreshTextColor,
                  showMore: true,
                  noMoreText: Provide.value<CategoryProvider>(context).noMoreText,
                  moreInfo: STitle.loading,
                  loadReadyText: STitle.loadReadyText,
                ),
                child: ListView.builder(
                  controller: _scrollControll,
                  itemCount: data.goodsList.length,
                  itemBuilder: (context, index){
                    return _listWidget(data.goodsList, index);
                  },
                ),
                loadMore: () async {
                  if(Provide.value<CategoryProvider>(context).noMoreText == STitle.noMoreData) {
                    Fluttertoast.showToast(
                      msg: STitle.toBottomed,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: SColor.refreshTextColor,
                      textColor: Colors.white,
                      fontSize: 16.0
                    );
                  }else {
                    _getMoreGoods();
                  }
                },
              )
            ),
          );
        }else{
          return Container(
            margin: EdgeInsets.only(top: 200),
            child: Text(STitle.noData, style: TextStyle(color: Colors.black38))
          );
        }
      },
    );
  }

  void _getMoreGoods(){
    Provide.value<CategoryProvider>(context).addPage();
    var data = {
      'firstCategoryId': Provide.value<CategoryProvider>(context).firstCategoryId,
      'secondCategoryId': Provide.value<CategoryProvider>(context).secondCategoryId,
      'page': Provide.value<CategoryProvider>(context).page
    };

    request('getCategoryGoods', formData: data).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodList = CategoryGoodsListModel.fromJson(data);
      if(goodList.data == null) {
        Provide.value<CategoryProvider>(context).chageNoMore(STitle.noMoreData);
      }else {
        Provide.value<CategoryGoodsProvider>(context).addCategoryGoodsList(goodList.data);
      }
    });
  }

  // 商品列表项
  Widget _listWidget(list, index){
    return InkWell(
      onTap: (){
        Application.router.navigateTo(context, '/details?id=${list[index].goodsId}');
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: SColor.defaultBorderColor)
          ),
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(list, index),
            Column(
              children: <Widget>[
                _goodsName(list, index),
                _goodsPrice(list, index)
              ]
            )
          ]
        ),
      )
    );
  }

  // 商品图片
  Widget _goodsImage(List newList, int index){
    return Container(
      width: ScreenUtil().setWidth(200),
      padding: EdgeInsets.only(left: 5),
      child: ClipRRect(  // 设置图片圆角
        borderRadius: BorderRadius.circular(4),  
        child: Image.network(newList[index].image, fit: BoxFit.cover),
      )
    );
  }
  // 商品标题
  Widget _goodsName(List newList, int index){
    return Container(
      padding: EdgeInsets.all(8.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(25)
        )
      ),
    );
  }
  // 商品价格
  Widget _goodsPrice(List newList, int index){
    return Container(
      padding: EdgeInsets.only(top: 20.0, left: 8.0),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('价格：'),
              Text(
                '￥${newList[index].presentPrice}',
                style: TextStyle(
                  color: Colors.black26,
                  decoration: TextDecoration.lineThrough,
                ),
              )
            ]
          ),
          Text(
            '￥${newList[index].oriPrice}',
            style: TextStyle(
              color: Colors.red
            )
          ),
        ]
      ),
    );
  }
}

