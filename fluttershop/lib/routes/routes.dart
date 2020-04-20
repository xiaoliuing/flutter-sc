import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './router_handler.dart';

class Routes{
  static String root = '/';
  static String detailsPage = '/details';
  static String loginPage = '/login';
  static String searchPage = '/search';

  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params){
        print('no router');
      }
    );

    router.define(detailsPage, handler: detailHandler);
    router.define(loginPage, handler: loginHandler);
    router.define(searchPage, handler: searchHandler);
  }
}