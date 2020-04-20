import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttershop/config/colors.dart';
import 'package:fluttershop/model/cart_model.dart';
import 'package:fluttershop/provider/cart_provider.dart';
import 'package:provide/provide.dart';

class CartCount extends StatelessWidget {
  final CartInfoModel item;
  CartCount(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: SColor.defaultBorderColor)
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _countArea(),
          _addBtn(context),
        ]
      ),
    );
  }
  Widget _reduceBtn(BuildContext context){
    return InkWell(
      onTap: (){
        Provide.value<CartProvider>(context).addOrReduceAction(item, 'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: item.count > 1 ? Colors.white : Colors.black26,
          border: Border(
            right: BorderSide(width: 1.0, color: SColor.defaultBorderColor)
          )
        ),
        child: item.count > 1 ? Text('-') : Text(''),
      ),
    );
  }

  Widget _addBtn(BuildContext context){
    return InkWell(
      onTap: (){
        Provide.value<CartProvider>(context).addOrReduceAction(item, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 1.0, color: SColor.defaultBorderColor)
          )
        ),
        child: Text('+'),
      ),
    );
  }

   Widget _countArea(){
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}'),
    );
  }
}