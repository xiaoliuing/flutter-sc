import 'package:flutter/material.dart';
import 'package:fluttershop/provider/user_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provider/cart_provider.dart';
import '../../config/index.dart';
import '../pay_page.dart';

//购物车底部组件
class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.only(top: 5, bottom: 5),
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      child: Provide<CartProvider>(
        builder: (context, child, val){
          return Row(
            children: <Widget>[
              selectAllBtn(context),
              allPriceArea(context),
              goButton(context),
            ],
          );
        },
      )
    );
  }

  //全选按钮
  Widget selectAllBtn(BuildContext context) {
    bool isAllCheck = Provide.value<CartProvider>(context).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllCheck,
            activeColor: SColor.primaryColor,
            onChanged: (bool val) {
              Provide.value<CartProvider>(context).changeAllCheckBtnState(val);
            },
          ),
          Text('全选'), //'全选'
        ],
      ),
    );
  }

  //合计区域
  Widget allPriceArea(BuildContext context) {
    int allPrice = Provide.value<CartProvider>(context).allPrice;
    String allPriceStr = allPrice.toStringAsFixed(2);

    return Container(
      width: ScreenUtil().setWidth(430),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(200),
                child: Text(
                  '合计',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(230),
                child: Text(
                  '￥$allPriceStr',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36),
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            width: ScreenUtil().setWidth(430),
            child: Text(
              '满10元免配送费,预购免配送费',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(22),
                color: Colors.black38,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //结算按钮
  Widget goButton(BuildContext context) {
    int allGoodsCount = Provide.value<CartProvider>(context).allGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () async{
          if(allGoodsCount > 0){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return PayPage();
            },
            fullscreenDialog: true
            ));
          }
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: SColor.primaryColor,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(
            '结算($allGoodsCount)',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
