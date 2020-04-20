import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provider/details_goods_provider.dart';
import 'package:provide/provide.dart';
import '../../config/string.dart';

class DetailsTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Provide<DeatilsGoodsProvide>(
      builder: (context, child, val){
        var goodsInfo = Provide.value<DeatilsGoodsProvide>(context).goodsInfo.data.goodInfo;
        if(goodsInfo != null) {
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      _goodsImg(goodsInfo.image1),
                      _goodsTitle(goodsInfo.goodsName),
                      _goodsNum(goodsInfo.goodsSerialNumber),
                      _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice),
                    ]
                  ),
                ),
                _goodsExplain()
              ]
            ),
          );
        }else {
          return Text(STitle.loading);
        }
      }
    );
  }

  Widget _goodsImg(String img){
    return Image.network(
      img,
      width: ScreenUtil().setWidth(750),
    );
  }

  Widget _goodsTitle(name){
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 13.0),
      child: Text(
        name,
        maxLines: 1,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30)
        ),
      )
    );
  }

  Widget _goodsNum(String _num){
    return Container(
      padding: EdgeInsets.only(left: 13.0),
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.centerLeft,
      child: Text(
        '编号：$_num',
        style: TextStyle(
          color: Colors.black26
        ),
      )
    );
  }

  Widget _goodsPrice(int presentPrice, int oriPrice){
    return Container(
      padding: EdgeInsets.only(left: 13.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[
          Text(
            '￥$presentPrice',
            style: TextStyle(
              color: Colors.red,
              fontSize: ScreenUtil().setSp(40)
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 10),),
          Text(
            '市场价￥$oriPrice',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough
            ),
          )
        ]
      )
    );
  }

  Widget _goodsExplain(){
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Colors.white,
      margin: EdgeInsets.only(top: 10.0),
      width: ScreenUtil().setWidth(750),
      child: Text(
        STitle.goodsExapin,
        style: TextStyle(
          color: Colors.red,
          fontSize: ScreenUtil().setSp(26)
        ),
      )
    );
  }
}