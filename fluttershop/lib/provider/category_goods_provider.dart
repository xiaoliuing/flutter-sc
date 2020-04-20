import 'package:flutter/material.dart';
import '../model/category_goods_model.dart';

class CategoryGoodsProvider with ChangeNotifier{
  List<CategoryListData> goodsList = [];

  getCategoryGoodsList(List<CategoryListData> list){
    goodsList = list;
    notifyListeners();
  }

  addCategoryGoodsList(List<CategoryListData> list){
    goodsList.addAll(list);
    notifyListeners();
  }
}