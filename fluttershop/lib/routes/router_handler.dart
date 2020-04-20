import 'package:fluro/fluro.dart';
import '../pages/detail_page.dart';
import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../pages/search_page.dart';

Handler detailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params){
    String goodsId = params['id'].first;
    return DetailPage(goodsId);
  }
);

Handler loginHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params){
    return LoginPage();
  }
);

Handler searchHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params){
    return SearchPage();
  }
);