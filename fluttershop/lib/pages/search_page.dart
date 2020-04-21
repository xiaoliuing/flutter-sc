import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttershop/service/http_service.dart';
import '../config/index.dart';
import 'goods_list_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 告诉页面允许缓存

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(  // 改变按钮颜色
          color: Colors.white, //change your color here
        ),
        // leading: IconButton(icon: Icon(Icons.search), onPressed: null),
        title: Container(
          //修饰黑色背景与圆角
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.grey, width: 1.0), //灰色的一层边框
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          alignment: Alignment.center,
          height: 40.0,
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
          child: SearchWidget(),
        )
      ),
      body: FutureBuilder(
        future: _getTags(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return Column(
              children: <Widget>[
                _hotTitle(context, '热门标签'),
                _hotTags(context, snapshot.data)
              ]
            );
          }else{
            return Center(
              child: Text(
                STitle.loading,
                style: TextStyle(color: Colors.black38)
              ),
            );
          }
        },
      )
    );
  }

  Future _getTags()async{
    var res = await request('hottags', formData: {'type': '2'});
    var data = json.decode(res.toString());
    return json.decode(data['data']['query'][0]['data']);
  }

  Widget _hotTitle(BuildContext context, String title){
    return Container(
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(left: 10, top: 20),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(width: 5, color: SColor.primaryColor)
        )
      ),
      child: Text(
        title,
        style: TextStyle(
          color: SColor.primaryColor,
        ),
      ),
    );
  }

  Widget _hotTags(BuildContext context, List list){
    if(list.length > 0){
      List<Widget> listWidget = list.map((val){
        return InkWell(
          onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context){
              return GoodsListPage(val);
            },
            fullscreenDialog: false
            ));
          },
          child: _hotTagItem(context, val),
        );
      }).toList();
      return Wrap(
        direction: Axis.horizontal,
        spacing: 10.0,
        children: listWidget
      );
    }else{
      return Text('');
    }
  }

  Widget _hotTagItem(BuildContext context, String val){
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: SColor.primaryColor)
      ),
      child: Text(val, style: TextStyle(color: SColor.primaryColor),),
    );
  }
}

class SearchWidget extends StatelessWidget {
  final editControll = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: editControll,
      decoration: InputDecoration(
        //输入框decoration属性
        // contentPadding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 1.0),
        contentPadding: EdgeInsets.only(bottom: 6.0),
        fillColor: Colors.white,
        border: InputBorder.none,
        // icon: ImageIcon(AssetImage("image/search_meeting_icon.png",),),
        icon: Icon(Icons.search),
        hintText: "搜索商品",
        hintStyle: TextStyle(color: Colors.grey)
      ),
      onSubmitted: (text) {//内容提交(按回车)的回调
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return GoodsListPage(text);
        },
        fullscreenDialog: false
        ));
      },
      style: TextStyle(color: Colors.black),
    );
  }
}