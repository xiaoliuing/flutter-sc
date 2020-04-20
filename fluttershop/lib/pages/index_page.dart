import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../config/index.dart';
import './home_page.dart';
import './member_page.dart';
import './car.dart';
import './category_page.dart';
// import './login_page.dart';
import '../provider/current_page_index.dart';

class IndexPage extends StatelessWidget {

  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text(STitle.homeTitle), // 首页
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      title: Text(STitle.categoryTitle), // 分类
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      title: Text(STitle.shopCarTitle), // 购物车
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text(STitle.memberTitle), // 会员中心
    ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    ShopCarPage(),
    // LoginPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Provide<CurrentIndexProvide>(
      builder: (context, child, val) {
        int currentIndex = Provide.value<CurrentIndexProvide>(context).currentIndex;
        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            items: bottomTabs,
            onTap: (index) {
              Provide.value<CurrentIndexProvide>(context).changeIndex(index);
            },
          ),
          body: IndexedStack(
            index: currentIndex,
            children: tabBodies,
          ),
        );
      }
    );
  }
}