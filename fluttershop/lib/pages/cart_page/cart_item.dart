import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttershop/config/colors.dart';
import 'package:fluttershop/model/cart_model.dart';
import 'package:fluttershop/provider/cart_provider.dart';
import 'package:provide/provide.dart';
import './cart_count.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel item;
  final bool isPay;
  CartItem(this.item, [this.isPay = false]);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.fromLTRB(5, 10, 10, 2),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: SColor.defaultBorderColor)
        )
      ),
      child: Row(
        children: <Widget>[
          isPay ? Text('') : _checkBox(context, item),
          _cartImage(item),
          _cartGoodsName(item),
          _cartPrice(context, item),
        ]
      ),
    );
  }

  Widget _checkBox(BuildContext context, CartInfoModel item){
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: SColor.primaryColor,
        onChanged: (bool val){
          item.isCheck = val;
          Provide.value<CartProvider>(context).changeCheckState(item);
        }
      ),
    );
  }

  //商品图片
  Widget _cartImage(CartInfoModel item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: SColor.defaultBorderColor)),
      child: Image.network(item.images),
    );
  }

  //商品名称
  Widget _cartGoodsName(CartInfoModel item) {
    return Container(
      width: ScreenUtil().setWidth(isPay ? 400 : 300),
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName),
          isPay ? Text(
            'x ${item.count}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(40),
              color: SColor.primaryColor
            ),
          ) : CartCount(item),
        ],
      ),
    );
  }

  //商品价格
  Widget _cartPrice(BuildContext context, CartInfoModel item) {
    return Container(
      width: ScreenUtil().setWidth(100),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text(
            '￥${item.price}',
            style: TextStyle(color: Colors.red),
          ),
          isPay ? Text('') : Container(
            child: InkWell(
              onTap: () {
                //删除商品
                Provide.value<CartProvider>(context).deleteOneGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.black38,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}