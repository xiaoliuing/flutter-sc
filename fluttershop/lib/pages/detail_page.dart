import 'package:flutter/material.dart';
import 'package:fluttershop/config/index.dart';
import 'package:provide/provide.dart';
import '../provider/details_goods_provider.dart';
import './details_page/detail_top.dart';
import './details_page/details_tapbar.dart';
import './details_page/details_details.dart';
import './details_page/details_bottom.dart';

class DetailPage extends StatelessWidget {

  final String goodsId; // 商品ID
  DetailPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: SColor.primaryColor,
            onPressed: (){
              print('back page');
              Navigator.pop(context);
            },
          ),
          title: Text(STitle.goodsDetails, style: TextStyle(color: SColor.primaryColor)),
        ),
        body: FutureBuilder(
          future: _getGoodsInfo(context),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      DetailsTop(),
                      DetailsTapBar(),
                      DetailsDetails()
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: DetailsBottom()
                  )
                ],
              );
            }else{
              return Text(STitle.loading);
            }
          },
        ),
      )
    );
  }

  Future _getGoodsInfo(BuildContext context) async {
    await Provide.value<DeatilsGoodsProvide>(context).getGoodsInfo(goodsId);
    return 'end';
  }
}