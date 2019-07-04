import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/pages/goods_detail_page.dart';

var goodsDetailHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String,List<String>> params){
      String goodsId = params['id']?.first;
      print('details goodsId is ${goodsId}');
      return GoodsDetailPage(goodsId);
    }
);