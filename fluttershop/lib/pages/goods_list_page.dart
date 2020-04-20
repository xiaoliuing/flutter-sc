import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/routes/application.dart';
import 'package:fluttershop/service/http_service.dart';

class GoodsListPage extends StatelessWidget {
  final String text;
  GoodsListPage(this.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text('搜索结果', style: TextStyle(color: Colors.white),),
      ),
      body: FutureBuilder(
        future: _getSearchGoods(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          var data = snapshot.data;
          if(snapshot.hasData && data.length > 0){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: SColor.defaultBorderColor)
                    )
                  ),
                  child: _goodsList(context, snapshot.data, index)
                );
              },
            );
          }else if(data.length <= 0){
            return Center(
              child: Text(STitle.noMoreData, style: TextStyle(color: Colors.black38),)
            );
          }else{
            return Text(STitle.loading);
          }
        },
      ),
    );
  }

  Future _getSearchGoods()async{
    var res = await request('search', formData: {'text': text});
    print(res.toString());
    return json.decode(res.toString())['data']['query'];
  }

  Widget _goodsList(context, list, index){
    return InkWell(
      onTap: (){
        Application.router.navigateTo(context, '/details?id=${list[index]['goods_id']}');
      },
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            width: ScreenUtil().setWidth(200.0),
            height: ScreenUtil().setHeight(200.0),
            child: Image.network(list[index]['s_img']),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8.0),
                  width: ScreenUtil().setWidth(500),
                  child: Text(
                    list[index]['g_name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(25)
                    )
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 8.0),
                  width: ScreenUtil().setWidth(500),
                  child: Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('价格：'),
                          Text(
                            '￥${list[index]['pre_price']}',
                            style: TextStyle(
                              color: Colors.black26,
                              decoration: TextDecoration.lineThrough,
                            ),
                          )
                        ]
                      ),
                      Text(
                        '￥${list[index]['price']}',
                        style: TextStyle(
                          color: Colors.red
                        )
                      ),
                    ]
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