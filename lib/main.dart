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
        primarySwatch: Colors.orange,
      ),
      home: MainPage(),
    );
  }
}

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'route1':
      return Center(
        child: Text('Unknown route: $route', textDirection: TextDirection.ltr),
      );
    default:
      return MyApp();
  }
}
