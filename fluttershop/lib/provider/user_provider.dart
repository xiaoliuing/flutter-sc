import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

//购物车Provide
class UserProvider with ChangeNotifier {
  Map<String, dynamic> userInfo = {
    'token': '',
    'headerImg': '',
    'address': '',
    'phone': '',
    'nick_name': '',
    'isLogin': ''
  };
  syncUserInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userString = prefs.getString('userInfo'); //获取持久化存储的值
    Map<String, dynamic> tempMap = userString == null ? {} : json.decode(userString.toString());
    tempMap.keys.forEach((key){
      userInfo[key] = tempMap[key];
    });
  }

  changeUserInfo(String type, dynamic data)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userString = prefs.getString('userInfo'); //获取持久化存储的值
    Map<String, dynamic> tempMap = userString == null ? {} : json.decode(userString.toString());
    tempMap[type] = data;
    userInfo[type] = data;
    userString = json.encode(tempMap).toString();
    prefs.setString('userInfo', userString);
    notifyListeners();
  }

  changeUserOtherInfo(dynamic data)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userString = prefs.getString('userInfo'); //获取持久化存储的值
    Map<String, dynamic> tempMap = userString == null ? {} : json.decode(userString.toString());
    var temp = data.keys;
    temp.forEach((item){
      tempMap[item] = data[item];
      userInfo[item] = data[item];
    });
    userString = json.encode(tempMap).toString();
    prefs.setString('userInfo', userString);
    notifyListeners();
  }

  getShareInfo(String type)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userString = prefs.getString('userInfo'); //获取持久化存储的值
    Map<String, dynamic> tempMap = userString == null ? {} : json.decode(userString.toString());
    return tempMap[type];
  }

  getAllShareInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userString = prefs.getString('userInfo'); //获取持久化存储的值
    Map<String, dynamic> tempMap = userString == null ? {} : json.decode(userString.toString());
    return tempMap;
  }

  cleanUserInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userString = prefs.getString('userInfo'); //获取持久化存储的值
    Map<String, dynamic> tempMap = userString == null ? {} : json.decode(userString.toString());
    userInfo.keys.forEach((key){
      if(tempMap[key] != null){
        print(key);
        tempMap[key] = '';
      }
      userInfo[key] = '';
    });
    userString = json.encode(tempMap).toString();
    prefs.setString('userInfo', userString);
    notifyListeners();
  }
}
