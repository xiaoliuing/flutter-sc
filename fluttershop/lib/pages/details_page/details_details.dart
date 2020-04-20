import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provide/provide.dart';
import '../../provider/details_goods_provider.dart';

class DetailsDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DeatilsGoodsProvide>(
      builder: (context, child, val){
        bool isLeft = Provide.value<DeatilsGoodsProvide>(context).isLeft;
        String goodsDetails = Provide.value<DeatilsGoodsProvide>(context).goodsInfo.data.goodInfo.goodsDetail;
        if(isLeft) {
          return Container(
            child: Html(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              data: goodsDetails
            )
          );
        }else {
          return Container(
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: Text(
              '暂时没有数据'
            ),
          );
        }
      },
    );
  }
}