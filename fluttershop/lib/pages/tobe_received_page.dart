import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/routes/application.dart';
import 'package:fluttershop/service/http_service.dart';

class ToBeReceivedPage extends StatefulWidget {
  final String type;
  ToBeReceivedPage([this.type = 'paied']);
  @override
  _ToBeReceivedPageState createState() => _ToBeReceivedPageState(type);
}

class _ToBeReceivedPageState extends State<ToBeReceivedPage> {
  final String type;
  _ToBeReceivedPageState(this.type);
  List _list = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(type == 'paied' ? '待收货' : '已收货', style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder(
        future: _getReceivedList(context),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            var list = snapshot.data;
            if(list.length > 0){
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index){
                  return paiedGoodsWrap(list, index);
                },
              );
            }else{
              return Center(
                child: Text(STitle.noData, style: TextStyle(color: Colors.black38)),
              );
            }
          }else{
            return Center(
              child: Text(STitle.loading),
            );
          }
        }
      ),
    );
  }

  Future _getReceivedList(BuildContext context)async{
    var res = await request(type, formData: {'type':'get'});
    var data = json.decode(res.toString());
    print(data);
    var paied = json.decode(data['data'][type]);
    _list = paied;
    return paied;
  }

  Widget paiedGoodsWrap(List list, int index){
    return Container(
      width: ScreenUtil().setWidth(710),
      margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
      decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(0.0, 10.0), //阴影xy轴偏移量
          blurRadius: 15.0, //阴影模糊程度
          spreadRadius: 1.0 //阴影扩散程度
        )
      ]),
      child: Column(
        children: <Widget>[
          paiedGoodsItem(list[index], index)
        ],
      )
    );
  }

  Widget paiedGoodsItem(List list, int index){
    int _num = 0;
    if(list.length > 0){
      List<Widget> goodsWidget = list.map((goods){
        _num += goods['count'];
        return Container(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
            child: InkWell(
              onTap: (){
                Application.router.navigateTo(context, '/details?id=${goods['goodsId']}');
              },
              child:Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(200),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(goods['images'], fit: BoxFit.cover,)
                  ),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      width: ScreenUtil().setWidth(350),
                      child: Text(
                        goods['goodsName'],
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(26)
                        ),
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 10.0),
                      padding: EdgeInsets.only(left: 100.0),
                      width: ScreenUtil().setWidth(330),
                      child: Text(
                        'x ${goods['count']}',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(40),
                          color: SColor.primaryColor
                        ),
                      )
                    ),
                  ],
                ),
                Container(
                  child: Text(
                    '￥${goods['price']}',
                    style: TextStyle(
                      color: Colors.red
                    )
                  )
                )
              ],
            )
          ),
        );
      }).toList();
      goodsWidget.add(_cardBootom(context, index, _num));
      return Column(
        children: goodsWidget,
      );
    }else{
      return Text('');
    }
  }

  Widget _cardBootom(BuildContext context, int index, int count){
    return Container(
      width: ScreenUtil().setWidth(710),
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: SColor.defaultBorderColor)
        )
      ),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '共 $count 个商品',
            style: TextStyle(
              color: SColor.primaryColor
            ),
          ),
          InkWell(
            onTap:()async{
              var _is = await _showDialogModel(context);
              if(_is != null){
                var paiedList = _list;
                var received = paiedList.removeAt(index);
                setState(() {
                  _list = paiedList;
                });
                if(type == 'paied'){
                  var formData = {
                    'paied': paiedList,
                    'received': received
                  };
                  await request('received', formData: formData);
                }else{
                  var formData = {
                    'received': paiedList
                  };
                  await request('del', formData: formData);
                }
              }
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: SColor.primaryColor),
                borderRadius: BorderRadius.circular(30)
              ),
              child: Text(
                type == 'paied' ? '确认收货' : '删除',
                style: TextStyle(
                  color: SColor.primaryColor
                ),
              )
            )
          ),
        ],
      ),
    );
  }

    Future _showDialogModel(BuildContext context) {  //弹出提示框
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定吗?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            FlatButton(
              child: Text("确定"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}