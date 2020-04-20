import 'package:flutter/material.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/provider/user_provider.dart';
import 'package:fluttershop/service/http_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';
import '../provider/details_goods_provider.dart';

class UserInfoPage extends StatelessWidget {

  void update(context)async{
    
  }

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
              Navigator.pop(context);
            },
          ),
          title: Text('用户信息', style: TextStyle(color: SColor.primaryColor)),

        ),
        body: Provide<UserProvider>(
          builder: (contxt, child, val){
            return FutureBuilder(
              future: _getUserInfo(context),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  var info = snapshot.data;
                  return Column(
                    children: <Widget>[
                      Container(
                        decoration:  BoxDecoration(
                          border:  Border(
                            bottom: BorderSide(
                              color: Color.fromARGB(255, 240, 240, 240),
                              width: 1.0
                            )
                          )
                        ),
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                        child:  TextField(
                          decoration:  InputDecoration(
                            labelText: '昵称',
                            labelStyle:  TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          controller: TextEditingController.fromValue(TextEditingValue(
                            // 设置内容
                            text: info['nick_name'] == null ? '用户未设置' : info['nick_name'],
                            )
                          ),
                        )
                      ),
                      Container(
                        decoration:  BoxDecoration(
                          border:  Border(
                            bottom: BorderSide(
                              color: Color.fromARGB(255, 240, 240, 240),
                              width: 1.0
                            )
                          )
                        ),
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child:  TextField(
                          decoration:  InputDecoration(
                            labelText: '地址',
                            labelStyle:  TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                            border: InputBorder.none,
                          ),
                          keyboardType:  TextInputType.text,
                          readOnly: true,
                          controller: TextEditingController.fromValue(TextEditingValue(
                            // 设置内容
                            text: info['address'] == null ? '用户未设置' : info['address'],
                            )
                          ),
                        ),
                      ),
                      Container(
                        decoration:  BoxDecoration(
                          border:  Border(
                            bottom: BorderSide(
                              color: Color.fromARGB(255, 240, 240, 240),
                              width: 1.0
                            )
                          )
                        ),
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child:  TextFormField(
                          decoration:  InputDecoration(
                            labelText: '手机号',
                            labelStyle:  TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.phone,
                          readOnly: true,
                          controller: TextEditingController.fromValue(TextEditingValue(
                            // 设置内容
                            text: info['phone'] == null ? '用户未设置' : info['phone'],
                            )
                          ),
                        ),
                      ),
                    ],
                  );
                }else{
                  return Text(STitle.loading);
                }
              },
            );
          },
        )
      )
    );
  }

  Future _getUserInfo(BuildContext context){
    var info = Provide.value<UserProvider>(context).getAllShareInfo();
    print(info.toString());
    return info;
  }
}