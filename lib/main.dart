import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/provide/category_goods_list.dart';
import 'package:flutter_demo/shopping/provide/child_category.dart';
import 'package:flutter_demo/shopping/provide/counter_provide.dart';
import 'package:flutter_demo/shopping/provide/goods_detail_info.dart';
import 'package:flutter_demo/shopping/routers/application.dart';
import 'package:flutter_demo/shopping/routers/routes.dart';
import 'package:provide/provide.dart';
import 'dart:ui' as ui;
import 'package:flutter_demo/main_page.dart';
import 'package:flutter_demo/shopping/shopping_page.dart';

void main() {
  //runApp(_widgetForRoute(ui.window.defaultRouteName));

  //-------------------路由注册start
  final router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
  //-------------------路由注册end

  //将状态放入顶层
  var counter = Counter();
  var childCategory = ChildCategory();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var goodsDetailInfoProvide = GoodsDetailInfoProvide();
  var providers = Providers();
  //将对象添加进providers
  providers..provide(Provider<Counter>.value(counter));
  providers..provide(Provider<ChildCategory>.value(childCategory));
  providers..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide));
  providers..provide(Provider<GoodsDetailInfoProvide>.value(goodsDetailInfoProvide));
  runApp(ProviderNode(child: _widgetForRoute(ui.window.defaultRouteName), providers: providers));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      //home: MainPage(),
      home: ShoppingPage(),
      onGenerateRoute: Application.router.generator, //生成路由
    );
  }
}

Widget _widgetForRoute(String routeStr) {
  print("routeStr = " + routeStr);
  String route = "";
  String pageParamJsonStr = "";
  if (routeStr.length > 0) {
    route = _getPageName(routeStr);
    pageParamJsonStr = _getPageParamJsonStr(routeStr);
  }
  print("route = " + route);
  print("pageParamJsonStr = " + pageParamJsonStr);

  switch (route) {
    case 'route1':
      return Center(
        child: Text('Unknown route: $route', textDirection: TextDirection.ltr),
      );
    default:
      return MyApp();
  }
}

String _getPageName(String s) {
  if (s.indexOf("?") == -1) {
    return s;
  } else {
    return s.substring(0, s.indexOf("?"));
  }
}

String _getPageParamJsonStr(String s) {
  if (s.indexOf("?") == -1) {
    return "{}";
  } else {
    return s.substring(s.indexOf("?") + 1);
  }
}
