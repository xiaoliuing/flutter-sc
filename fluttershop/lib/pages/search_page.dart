import 'package:flutter/material.dart';
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
      body: Column(
        children: <Widget>[
          _hotTitle(context, '热门标签'),
          _hotTags(context, ['长裙','擦拭','超大城市的','生存手册','都是','上档次吧触发','滴水穿石大V','风发大V衣',])
        ]
      )
    );
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
      style: TextStyle(color: Colors.black),
    );
  }
}