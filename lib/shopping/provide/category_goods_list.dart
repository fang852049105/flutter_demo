import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/model/category_goods_list_model.dart';


class CategoryGoodsListProvide with ChangeNotifier{

  List<CategoryListData> goodsList = [];

  //点击大类时更换商品列表
  setGoodsList(List<CategoryListData> list){
    if (list == null) {
      goodsList = [];
    } else {
      goodsList = list;
    }
    notifyListeners();
  }
}