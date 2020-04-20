import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttershop/pages/user_info_page.dart';
import 'package:fluttershop/provider/user_provider.dart';
import 'package:provide/provide.dart';
import '../config/index.dart';
import '../routes/application.dart';
import './edit_page.dart';

class MemberPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心', style: TextStyle(color: Colors.white),),//会员中心
      ),
      body: ListView(
        children: <Widget>[
          _topHeader(context),
          // _orderTitle(),
          // _orderType(),
          _actionList(context),
        ],
      ),
    );
  }

  //头像区域
  Widget _topHeader(BuildContext context){
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: SColor.primaryColor,
      child: Center(
        child: Provide<UserProvider>(
          builder: (context, child, val){
            return FutureBuilder(
              future: Provide.value<UserProvider>(context).getAllShareInfo(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasData) {
                  var data = snapshot.data;
                  if(data['isLogin'] == '1') {
                    return Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: ClipOval(
                            child: SizedBox(
                              width: 200,
                              height: 200,
                              child: Image.asset('assets/images/boy.jpg',fit: BoxFit.cover,),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            data['nick_name'] == null ? '' : data['nick_name'],
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(36),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  }else{
                    return Padding(
                      padding: EdgeInsets.only(top: 150, bottom: 150),
                      child: InkWell(
                        child: FlatButton(
                          color: Colors.white,
                          onPressed: (){
                            Application.router.navigateTo(context, '/login');
                          },
                          child: Text('登录',style: TextStyle(color: SColor.primaryColor))
                        )
                      ),
                    );
                  }
                }else {
                  return Text(STitle.loading);
                }
              },
            );
          },
        ),
      )
    );
  }

  // //我的订单标题
  // Widget _orderTitle(){
  //   return Container(
  //     margin: EdgeInsets.only(top: 10),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       border: Border(
  //         bottom: BorderSide(width: 1,color: SColor.defaultBorderColor),
  //       ),
  //     ),
  //     child: ListTile(
  //       leading: Icon(Icons.list),
  //       title: Text('我的订单'),
  //       trailing: Icon(Icons.arrow_right),
  //     ),
  //   );
  // }


  // //我的订单类型
  // Widget _orderType(){
  //   return Container(
  //     margin: EdgeInsets.only(top: 5),
  //     width: ScreenUtil().setWidth(750),
  //     height: ScreenUtil().setHeight(150),
  //     padding: EdgeInsets.only(top: 20),
  //     color: Colors.white,
  //     child: Row(
  //       children: <Widget>[
  //         Container(
  //           width: ScreenUtil().setWidth(187),
  //           child: Column(
  //             children: <Widget>[
  //               Icon(
  //                 Icons.payment,
  //                 size: 30,
  //               ),
  //               Text('待付款'),//'待付款'
  //             ],
  //           ),
  //         ),
  //         Container(
  //           width: ScreenUtil().setWidth(187),
  //           child: Column(
  //             children: <Widget>[
  //               Icon(
  //                 Icons.directions_car,
  //                 size: 30,
  //               ),
  //               Text('待发货'),//'待发货'
  //             ],
  //           ),
  //         ),
  //         Container(
  //           width: ScreenUtil().setWidth(187),
  //           child: Column(
  //             children: <Widget>[
  //               Icon(
  //                 Icons.directions_car,
  //                 size: 30,
  //               ),
  //               Text('待收货'),//'待收货'
  //             ],
  //           ),
  //         ),
  //         Container(
  //           width: ScreenUtil().setWidth(187),
  //           child: Column(
  //             children: <Widget>[
  //               Icon(
  //                 Icons.message,
  //                 size: 30,
  //               ),
  //               Text('待评价'),//'待评价'
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }


  Widget _myListTile(BuildContext context, Icon icon, String title, [option = '']){
    return InkWell(
      onTap: ()async{
        if(option != ''){
          if(option == '/loginout'){
            var a = await showDialogModel(context);
            if(a != null){
              await Provide.value<UserProvider>(context).cleanUserInfo();
            }
          }else{
            Navigator.push(context, MaterialPageRoute(builder: (context){
              switch(option){
                case '/edit': return EditPage();
                case '/look': return UserInfoPage();
              }
            },
            fullscreenDialog: false
            ));
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1,color: SColor.defaultBorderColor),
          ),
        ),
        child: ListTile(
          leading: icon,
          title: Text(title),
          trailing: Icon(Icons.arrow_right),
        ),
      ),
    );
  }

  //其它操作列表
  Widget _actionList(context){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _myListTile(context, Icon(Icons.edit), '编辑信息', '/edit'),
          _myListTile(context, Icon(Icons.info), '信息查看', '/look'),
          _myListTile(context, Icon(Icons.timeline), '关于我们'),
          _myListTile(context, Icon(Icons.time_to_leave), '退出登录', '/loginout'),
        ],
      ),
    );
  }

  Future showDialogModel(BuildContext context) {  //弹出提示框
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要退出吗?"),
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

