import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttershop/config/colors.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/provider/cart_provider.dart';
import 'package:fluttershop/provider/current_page_index.dart';
import 'package:fluttershop/provider/details_goods_provider.dart';
import 'package:fluttershop/provider/user_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';

class DetailsBottom extends StatefulWidget {
  @override
  _DetailsBottomState createState() => _DetailsBottomState();
}

class _DetailsBottomState extends State<DetailsBottom> {
  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provide.value<DeatilsGoodsProvide>(context).goodsInfo.data.goodInfo;

    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.presentPrice;
    var image = goodsInfo.image1;
    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: (){
                  Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                  width: ScreenUtil().setWidth(110),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 35,
                    color: Colors.red
                  )
                )
              ),
              Provide<CartProvider>(
                builder: (context, child, val){
                  int goodsCount = Provide.value<CartProvider>(context).allGoodsCount;
                  return  Positioned(
                    top: 3,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                      decoration: BoxDecoration(
                        color: SColor.primaryColor,
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        '$goodsCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(22),
                        ),
                      ),
                    ),
                  );
                },
              )
            ]
          ),
          InkWell(
            onTap: () async {
              //添加至购物车
              var isLogin = await Provide.value<UserProvider>(context).getShareInfo('isLogin');
              if(isLogin == '1') {
                Provide.value<CartProvider>(context).save(goodsId, goodsName, count, price, image);
              }else{
                Fluttertoast.showToast(
                  msg: '请先登录',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black38,
                  textColor: Colors.white,
                  webShowClose: true
                );
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.green,
              child: Text(
                STitle.addToCartText, //'加入购物车'
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(28),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              //添加立即购买
              var isLogin = await Provide.value<UserProvider>(context).getShareInfo('isLogin');
              if(isLogin == '1') {
                // 购买逻辑
              }else{
                Fluttertoast.showToast(
                  msg: '请先登录',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black38,
                  textColor: Colors.white,
                  webShowClose: true
                );
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: SColor.primaryColor,
              child: Text(
                STitle.buyGoodsText, //'加入购物车'
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(28),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}