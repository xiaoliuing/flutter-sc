import 'package:flutter/material.dart';
import '../model/category_model.dart';

//分类Provide
class CategoryProvider with ChangeNotifier{

  List<SecondCategoryVO> secondCategoryList = [];//二级分类列表
  int secondCategoryIndex = 0;//二级分类索引
  int firstCategoryIndex = 0;//一级分类索引
  String firstCategoryId = '0';//二级ID
  String secondCategoryId = '';//一级ID
  int page = 1;//列表页数, 当改变一级分类或者二级分类时进行改变
  String noMoreText = '';//显示更多的表示
  bool isNewCategory = true;

  //首页点击类别时更改类别
  changeFirstCategory(String id,int index){
    firstCategoryId = id;
    firstCategoryIndex = index;
    secondCategoryId = '';
    notifyListeners();
  }

  //获取二级分类数据
  getSecondCategory(List<SecondCategoryVO> list, String id){
    isNewCategory = true;
    firstCategoryId = id;
    secondCategoryIndex = 0;
    page = 1;
    secondCategoryId = '';//点击一级分类时, 把二级分类的ID清空
    noMoreText = '';
    SecondCategoryVO all = SecondCategoryVO();
    all.secondCategoryId = '';
    all.firstCategoryId = '00';
    all.secondCategoryName = '全部';
    all.comments = 'null';
    secondCategoryList = [all];
    secondCategoryList.addAll(list);
    notifyListeners();
  }

  //改变二类索引
  changeSecondIndex(int index, String id){
    isNewCategory = true;
    secondCategoryIndex = index;
    secondCategoryId = id;
    page = 1;
    noMoreText = '';
    notifyListeners();
  }


  //增加page的方法
  addPage(){
    page++;
  }

  //改变noMoreText数据
  chageNoMore(String text){
    noMoreText = text;
    notifyListeners();
  }

  changeFale(){
    isNewCategory = false;
  }
}