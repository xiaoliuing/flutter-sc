import 'package:flutter/material.dart';
import 'package:fluttershop/service/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cart_model.dart';

//购物车Provide
class CartProvider with ChangeNotifier {
  String cartString = "[]";
  List<CartInfoModel> cartList = []; //商品列表对象

  int allPrice = 0; //总价格
  int allGoodsCount = 0; //商品总数
  bool isAllCheck = true; //是否全选

  initCartList(List list)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); //获取持久化存储的值
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    //把获取到的值转变为List
    List<Map> tempList = (temp as List).cast();
    if(list.length > 0){
      list.forEach((item){
        tempList.add(item);
        cartList.add(CartInfoModel.fromJson(item));
      });
    }
    cartString = json.encode(tempList).toString();

    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

  save(goodsId, goodsName, count, price, images) async {
    //初始化SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(allGoodsCount == 0) {
      prefs.remove('cartInfo');
    }
    cartString = prefs.getString('cartInfo'); //获取持久化存储的值
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    //把获取到的值转变为List
    List<Map> tempList = (temp as List).cast();
    //声明变量，用于判断购物车中是否已经存在此商品ID
    var isHave = false; //默认为没有
    int ival = 0; //用于进行循环的索引使用
    allPrice = 0;
    allGoodsCount = 0; //把商品总数置为0
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartList[ival].count++;
        isHave = true;
      }
      if (item['isCheck']) {
      //算出总价
        allPrice += (cartList[ival].price * cartList[ival].count);
      //算出总的商品数量
        allGoodsCount += cartList[ival].count;
      }

      ival++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true
      };
      tempList.add(newGoods);
      cartList.add(new CartInfoModel.fromJson(newGoods));
      allPrice += (count * price);
      allGoodsCount += count;
    }

    cartString = json.encode(tempList).toString();

    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

  //得到购物车中的商品
  getCartInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); //获取持久化存储的值

    //把cartList进行初始化,防止数据混乱
    cartList = [];
    if(cartString == null){
      cartList = [];
    }else{
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      //初始化全选为true
      isAllCheck = true;
      tempList.forEach((item){
        //是否为全选择判断
        if(item['isCheck']){
          allPrice += (item['count'] * item['price']);
          allGoodsCount += item['count'];
        }else{
          isAllCheck = false;
        }

        cartList.add(new CartInfoModel.fromJson(item));
      });
    }
    if(cartList.length > 0){
      await request('cart', formData: {'cart': cartList});
    }
    notifyListeners();
  }

  //修改选中状态
  changeCheckState(CartInfoModel cartItem) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); //获取持久化存储的值
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'] == cartItem.goodsId){
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();

  }

  // 删除单个购物车商品
  deleteOneGoods(String goodsId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); //获取持久化存储的值
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item){
    if(item['goodsId'] == goodsId){
      delIndex = tempIndex;
    }
    tempIndex++;

    });
    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }


  // //增加减少数量的操作
  addOrReduceAction(CartInfoModel cartItem,String todo) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); //获取持久化存储的值
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'] == cartItem.goodsId){
      changeIndex = tempIndex;
    }
    tempIndex++;

    });
    if(todo == 'add'){
      cartItem.count++;
    }else if(cartItem.count > 1){
      cartItem.count--;
    }
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }


  // //全选状态处理
  changeAllCheckBtnState(bool isCheck) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); //获取持久化存储的值
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newList = [];
    for(var item in tempList){
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }

    cartString = json.encode(newList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  // 删除选中的商品
  deleteAnyCartGoods()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); //获取持久化存储的值
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    cartList = [];
    tempList.forEach((item){
      if(!item['isCheck']){
        cartList.add(CartInfoModel.fromJson(item));
      }
    });
    cartString = json.encode(cartList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  // 获取选中的商品
  getChechGoods()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); //获取持久化存储的值
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<CartInfoModel> newList = [];
    tempList.forEach((item){
      if(item['isCheck']){
        newList.add(CartInfoModel.fromJson(item));
      }
    });
    return newList;
  }

  // 清空购物车
  cleanCart()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartString = "[]";
    cartList = []; //商品列表对象
    allPrice = 0; //总价格
    allGoodsCount = 0; //商品总数
    notifyListeners();
  }
}