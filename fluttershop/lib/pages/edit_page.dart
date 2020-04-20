import 'package:flutter/material.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/provider/user_provider.dart';
import 'package:fluttershop/service/http_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';
import '../provider/details_goods_provider.dart';

class EditPage extends StatelessWidget {
  String nickName = '';
  String phone = '';
  String adress = '';

  void update(context)async{
    var formData = {
      'nick_name': nickName,
      'phone': phone,
      'address': adress,
    };
    request('update', formData: formData).then((res)async{
      await Provide.value<UserProvider>(context).changeUserOtherInfo(formData);
      Fluttertoast.showToast(
        msg: '修改完成',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black38,
        textColor: Colors.white,
        webShowClose: true
      );
      Navigator.pop(context);
    });
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
          title: Text('编辑信息', style: TextStyle(color: SColor.primaryColor)),

        ),
        body: Provide<UserProvider>(
          builder: (contxt, child, val){
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
                  child:  TextFormField(
                    decoration:  InputDecoration(
                      labelText: '请输入昵称',
                      labelStyle:  TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                    // onSaved: (value) {
                    //   nickName = value;
                    // },
                    onChanged: (val){
                      nickName = val;
                    },
                    validator: (val) {
                    },
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
                      labelText: '请输入地址',
                      labelStyle:  TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                      border: InputBorder.none,
                    ),
                    keyboardType:  TextInputType.text,
                    // onSaved: (value) {
                    //   adress = value;
                    // },
                    onChanged: (val){
                      adress = val;
                    },
                    validator: (val) {
                    },
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
                      labelText: '请输入手机号',
                      labelStyle:  TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.phone,
                    // onSaved: (value) {
                    //   phone = value;
                    // },
                    onChanged: (val){
                      phone = val;
                    },
                    validator: (val) {
                    },
                  ),
                ),
                Container(
                  height: 45.0,
                  margin: EdgeInsets.only(top: 40.0),
                  child:  SizedBox.expand(   
                    child:  RaisedButton(
                      onPressed: (){
                        update(context);
                      },
                      color: SColor.primaryColor,
                      child:  Text(
                        '确认更改',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 255, 255, 255)
                        ),
                      ), 
                      shape:  RoundedRectangleBorder(borderRadius:  BorderRadius.circular(45.0)),
                    ), 
                  ),  
                ),
              ],
            );
          },
        )
      )
    );
  }
}