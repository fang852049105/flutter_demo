import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/routers/router_handler.dart';

class Routes {
  static String root = '/';
  static String home = 'home';
  static String goodsDetailPage = 'goods_detail';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print('ERROR====>ROUTE WAS NOT FONUND!!!');
        });
    router.define(goodsDetailPage, handler: goodsDetailHanderl);
  }
}