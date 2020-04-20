import 'package:flutter/material.dart';
import './provider/category_page_provider.dart';
import './config/index.dart';
import './provider/current_page_index.dart';
import 'package:provide/provide.dart';
import './pages/index_page.dart';
import './provider/category_goods_provider.dart';
import './provider/details_goods_provider.dart';
import './provider/cart_provider.dart';
import './provider/user_provider.dart';
import './routes/application.dart';
import './routes/routes.dart';
import 'package:fluro/fluro.dart';

void main() {
  var currentIndexProvide = CurrentIndexProvide();
  var categoryProvide = CategoryProvider();
  var categoryGoodsProvide = CategoryGoodsProvider();
  var deatilsGoodsProvide = DeatilsGoodsProvide();
  var cartProvide = CartProvider();
  var userProvider = UserProvider();
  var providers = Providers();

  providers
    ..provide(Provider<CategoryProvider>.value(categoryProvide))
    ..provide(Provider<CategoryGoodsProvider>.value(categoryGoodsProvide))
    ..provide(Provider<DeatilsGoodsProvide>.value(deatilsGoodsProvide))
    ..provide(Provider<CartProvider>.value(cartProvide))
    ..provide(Provider<UserProvider>.value(userProvider))
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));

  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;  // 全局使用router
    return Container(
      child: MaterialApp(
        color: Colors.white,
        title: STitle.appTitle,
        // debugShowCheckedModeBanner: false,
        onGenerateRoute: Application.router.generator,  // 配置路由回调到配置的路由
        theme: ThemeData(
          primaryColor: SColor.primaryColor,
        ),
        home: IndexPage(),
      ),
    );
  }
}

