import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/model/category_goods_list_model.dart';


class CategoryGoodsListProvide with ChangeNotifier{

  List<CategoryListData> goodsList = [];
  bool canLoadMore = true;

  //点击类别导航时更换商品列表
  setGoodsList(List<CategoryListData> list) {
    goodsList = list;
    notifyListeners();
  }

  addGoodsList(List<CategoryListData> list) {
    goodsList.addAll(list);
    notifyListeners();
  }

  changeLoadMoreStatus(bool status) {
    canLoadMore = status;
    notifyListeners();
  }

}