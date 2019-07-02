import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_demo/main_page.dart';

void main() => runApp(_widgetForRoute(ui.window.defaultRouteName));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MainPage(),
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
