import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/model/goods_detail_model.dart';

class GoodsDetailInfoProvide with ChangeNotifier {
  GoodsDetailModel goodsDetailInfo = null;
  int tabIndex = 0;

  //分离业务代码和UI
   setGoodsInfo(GoodsDetailModel goosInfo) {
     goodsDetailInfo = goosInfo;
     notifyListeners();
   }

   setIndxe(int index) {
     tabIndex = index;
     notifyListeners();
   }

}