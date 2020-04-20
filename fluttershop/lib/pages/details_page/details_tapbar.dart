import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttershop/config/index.dart';
import 'package:provide/provide.dart';
import '../../provider/details_goods_provider.dart';
class DetailsTapBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DeatilsGoodsProvide>(
      builder: (context, child, val){
        bool isLeft = Provide.value<DeatilsGoodsProvide>(context).isLeft;
        bool isRight = Provide.value<DeatilsGoodsProvide>(context).isRight;
        print('$isLeft, $isRight');
        return Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: <Widget>[
              _leftTapBar(context, isLeft),
              _rightTapBar(context, isRight),
            ],
          ),
        );
      },
    );
  }

  Widget _leftTapBar(BuildContext context, bool isLeft){
    return InkWell(
      onTap: (){
        Provide.value<DeatilsGoodsProvide>(context).changeLeftOrRight('left');
      },
      child: Container(
        width: ScreenUtil().setWidth(375),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 2.0,
              color: isLeft ? SColor.primaryColor : Colors.white
            )
          )
        ),
        child: Text(
          '详情',
          style: TextStyle(
            color: isLeft ? SColor.primaryColor : Colors.black54
          )
        ),
      ),
    );
  }

  Widget _rightTapBar(BuildContext context, bool isRight){
    return InkWell(
      onTap: (){
        Provide.value<DeatilsGoodsProvide>(context).changeLeftOrRight('right');
      },
      child: Container(
        width: ScreenUtil().setWidth(375),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isRight ? SColor.primaryColor : Colors.white
            )
          )
        ),
        child: Text(
          '评论',
          style: TextStyle(
            color: isRight ? SColor.primaryColor : Colors.black54
          )
        ),
      ),
    );
  }
}