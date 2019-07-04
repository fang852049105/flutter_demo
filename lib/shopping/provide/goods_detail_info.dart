import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/model/goods_detail_model.dart';
import 'package:flutter_demo/shopping/service/service_method.dart';

class GoodsDetailInfoProvide with ChangeNotifier {
  GoodsDetailModel goodsInfo = null;

  //分离业务代码和UI
  void getGoodsInfo(String id) {
    var formData = {'goodId':id};
    getContent('getGoodDetailById', formData: formData).then((val) {
      var data = json.decode(val.toString());
      goodsInfo = GoodsDetailModel.fromJson(data);
      notifyListeners();
    });
  }
}