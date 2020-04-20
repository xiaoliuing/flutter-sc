  import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttershop/config/colors.dart';
import 'package:fluttershop/provider/user_provider.dart';
import 'package:provide/provide.dart';
  import '../service/http_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() =>  _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey =  GlobalKey<FormState>();
  String userName;
  String password;
  bool isShowPassWord = false;

  void login(BuildContext context)async{
    //读取当前的Form状态
    var loginForm = loginKey.currentState;
    //验证Form表单
    if(loginForm.validate()){
      loginForm.save();
      var formData = {
        'userName': userName,
        'password': password
      };
      await request('login', formData: formData).then((res)async{
        var data = json.decode(res.toString());
        if(data['data']['token'] != null){
          print(data);
          var res = {
            'token': data['data']['token'],
            'address': data['data']['address'],
            'phone': data['data']['phone'],
            'nick_name': data['data']['nick_name'],
            'isLogin': '1'
          };
          await Provide.value<UserProvider>(context).changeUserOtherInfo(res);
        }
        Navigator.pop(context);
      });
    }
  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }
  @override
  Widget build(BuildContext context){
    return  Scaffold(
        body:  Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 100.0, bottom: 10.0),
              child:  Text(
                'LOGIN',
                style: TextStyle(
                  color: Color.fromARGB(255, 53, 53, 53),
                  fontSize: 50.0
                ),
              )
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child:  Form(
                key: loginKey,
                autovalidate: true,
                child:  Column(
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
                      child:  TextFormField(
                        decoration:  InputDecoration(
                          labelText: '请输入手机号',
                          labelStyle:  TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.phone,
                        onSaved: (value) {
                          userName = value;
                        },
                        validator: (phone) {
                          // if(phone.length == 0){
                          //   return '请输入手机号';
                          // }
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
                      child:  TextFormField(
                        decoration:   InputDecoration(
                          labelText: '请输入密码',
                          labelStyle:  TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                          suffixIcon:  IconButton(
                            icon:  Icon(
                              isShowPassWord ? Icons.visibility : Icons.visibility_off,
                              color: Color.fromARGB(255, 126, 126, 126), 
                            ),
                            onPressed: showPassWord,
                          )
                        ),
                        obscureText: !isShowPassWord,
                        onSaved: (value) {
                          password = value;
                        },
                      ),
                    ), 
                    Container(
                      height: 45.0,
                      margin: EdgeInsets.only(top: 40.0),
                      child:  SizedBox.expand(   
                        child:  RaisedButton(
                          onPressed: (){
                            login(context);
                          },
                          color: SColor.primaryColor,
                          child:  Text(
                            '登录',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color.fromARGB(255, 255, 255, 255)
                            ),
                          ), 
                          shape:  RoundedRectangleBorder(borderRadius:  BorderRadius.circular(45.0)),
                        ), 
                      ),  
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30.0),
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child:  Text(
                              '注册账号',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Color.fromARGB(255, 53, 53, 53)
                              ),
                            ),
                          ),
                         
                          Text(
                            '忘记密码？',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Color.fromARGB(255, 53, 53, 53)
                            ),
                          ),
                        ],
                      ) ,
                    ),
                    
                  ],
                ),
              ),
            )
          ],
        ),
      );
  }
}