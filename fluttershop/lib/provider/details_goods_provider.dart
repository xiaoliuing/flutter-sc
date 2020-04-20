import 'dart:convert';

import 'package:flutter/material.dart';
import '../service/http_service.dart';
import '../model/details_model.dart';

class DeatilsGoodsProvide with ChangeNotifier {
  DetailsModel goodsInfo;
  bool isLeft = true;
  bool isRight = false;

  getGoodsInfo(String id) async{
    var formData = {
      'goodsId': id
    };
    await request('getGoodDetail', formData: formData).then((res){
      var data = json.decode(res.toString());
      goodsInfo = DetailsModel.fromJson(data);
    });
    notifyListeners();
  }

  changeLeftOrRight(String changeData){
    if(changeData == 'left') {
      isLeft = true;
      isRight = false;
    }else{
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }
}