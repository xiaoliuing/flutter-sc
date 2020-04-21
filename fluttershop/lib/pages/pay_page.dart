import 'package:flutter/material.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/provider/user_provider.dart';
import 'package:fluttershop/service/http_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';
import '../provider/cart_provider.dart';
import './cart_page/cart_item.dart';

class PayPage extends StatefulWidget {
  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('支付', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder(
        future: _getGoodsInfo(context),
        builder: (contxet, snapShot){
          var userInfo = Provide.value<UserProvider>(context).userInfo;
          if(snapShot.hasData) {
            var cartList = snapShot.data;
            return Stack(
              children: <Widget>[
                Provide<CartProvider>(
                  builder: (context, child, val){
                    return ListView.builder(
                      itemCount: cartList.length+2,
                      itemBuilder: (context, index){
                        if(index < cartList.length){
                          return CartItem(cartList[index], true);
                        }else{
                          return Provide<UserProvider>(
                            builder: (context, child, val){
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
                                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                                    child:  TextField(
                                      decoration:  InputDecoration(
                                        labelText: index == cartList.length ? '地址' : '联系方式',
                                        labelStyle:  TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                                        border: InputBorder.none,
                                      ),
                                      keyboardType:  TextInputType.text,
                                      readOnly: true,
                                      controller: TextEditingController.fromValue(TextEditingValue(
                                        // 设置内容
                                        text: userInfo[index == cartList.length ? 'address' : 'phone'] == null ?
                                          '用户未设置' : 
                                          userInfo[index == cartList.length ? 'address' : 'phone'],
                                        )
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    );
                  },
                ),
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 46.0,
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: RaisedButton(
                      onPressed: ()async{
                        var isPay = await showDialogModel(context, Provide.value<CartProvider>(context).allPrice);
                        if(isPay != null){
                          await Provide.value<CartProvider>(context).deleteAnyCartGoods();
                          var formData = {
                            'paied': cartList,
                            'cart': Provide.value<CartProvider>(context).cartList
                          };
                          await request('paied', formData: formData);
                          Fluttertoast.showToast(
                            msg: '支付成功',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: SColor.refreshTextColor,
                            textColor: Colors.white,
                            fontSize: 16.0
                          );
                          Navigator.pop(context);
                        }
                      },
                      color: SColor.primaryColor,
                      child:  Text(
                        '立即支付',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 255, 255, 255)
                        ),
                      ), 
                      shape:  RoundedRectangleBorder(borderRadius:  BorderRadius.circular(45.0)),
                    ),
                  ),
                )
              ]
            );
          }else{
            return Text(STitle.loading);
          }
        },
      ),
    );
  }

  Future _getGoodsInfo(BuildContext context) async {
    await Provide.value<CartProvider>(context).getCartInfo();
    await Provide.value<UserProvider>(context).syncUserInfo();
    var checkedList =  await Provide.value<CartProvider>(context).getChechGoods();
    return checkedList;
  }
  Future showDialogModel(BuildContext context, int allPrice) {  //弹出提示框
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要支付￥$allPrice?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            FlatButton(
              child: Text("确定"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}