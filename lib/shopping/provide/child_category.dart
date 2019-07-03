import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/model/category_model.dart';

//ChangeNotifier的混入是不用管理听众
class ChildCategory with ChangeNotifier{

  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;
  String categoryId = '4';

  setChildCategory(List<BxMallSubDto> list, String id) {
    categoryId = id;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(index){
    childIndex=index;
    notifyListeners();
  }
}