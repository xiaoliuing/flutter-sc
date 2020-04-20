import 'package:flutter/material.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/provider/user_provider.dart';
import 'package:provide/provide.dart';
import '../provider/cart_provider.dart';
import './cart_page/cart_item.dart';
import './cart_page/cart_bottom.dart';

class ShopCarPage extends StatefulWidget {
  @override
  _ShopCarPageState createState() => _ShopCarPageState();
}

class _ShopCarPageState extends State<ShopCarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(STitle.cartText, style: TextStyle(color: Colors.white)),
      ),
      body: Provide<UserProvider>(
        builder: (context, child, val){
          return FutureBuilder(
            future: _getGoodsInfo(context),
            builder: (contxet, snapShot){
              var cartList = Provide.value<CartProvider>(context).cartList;
              if(snapShot.hasData && cartList != null) {
                print(snapShot.data);
                if(snapShot.data == '1'){
                  return Stack(
                    children: <Widget>[
                      Provide<CartProvider>(
                        builder: (context, child, val){
                          cartList = Provide.value<CartProvider>(context).cartList;
                          return ListView.builder(
                            itemCount: cartList.length,
                            itemBuilder: (context, index){
                              return CartItem(cartList[index]);
                            }
                          );
                        },
                      ),
                      cartList.length > 0 ? Positioned(
                        bottom: 0,
                        left: 0,
                        child: CartBottom()
                      ) : Center(
                        child: Text('购物车为空哦', style: TextStyle(color: Colors.black38))
                      )
                    ]
                  );
                }else{
                  return Center(
                    child: Text('请先登录哦', style: TextStyle(color: Colors.black38))
                  );
                }
              }else{
                return Text(STitle.loading);
              }
            },
          );
        }
      )
      
    );
  }

  Future _getGoodsInfo(BuildContext context) async {
    await Provide.value<CartProvider>(context).getCartInfo();
    var isLogin = await Provide.value<UserProvider>(context).getShareInfo('isLogin');
    return isLogin;
  }
}