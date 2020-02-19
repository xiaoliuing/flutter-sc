import 'package:flutter/material.dart';
import './config/index.dart';
import './provider/current_page_index.dart';
import 'package:provide/provide.dart';
import './pages/index_page.dart';

void main() {
  var currentIndexProvide = CurrentIndexProvide();
  var providers = Providers();

  providers
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));

  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: STitle.appTitle,
        // debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: SColor.primaryColor,
        ),
        home: IndexPage(),
      ),
    );
  }
}

