import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future request(url,{formData})async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userString = prefs.getString('userInfo'); //获取持久化存储数据
  Map userInfo = userString == null ? {} : json.decode(userString.toString());
  try{
    Response response;
    Dio dio = Dio();
    var authenticateHeader = Options(
    headers: {
      Headers.wwwAuthenticateHeader: userInfo['token'], // set content-length
    });
    if(formData == null){
      response = await dio.post(servicePath[url], options: authenticateHeader);
    }else{
      response = await dio.post(servicePath[url],data: formData,options: authenticateHeader);
    }
    if(response.statusCode == 200){
      return response;
    }else{
      throw Exception('后端接口异常,请检查测试代码和服务器运行情况...');
    }

  }catch(e){
    return print('error:::$e');
  }
}