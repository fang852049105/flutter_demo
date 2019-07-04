import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/model/category_model.dart';

//ChangeNotifier的混入是不用管理听众
class ChildCategory with ChangeNotifier{

  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; //子类索引值
  String categoryId = '4';//大类ID
  String subId = ''; //小类ID
  int page = 1;

  setChildCategory(List<BxMallSubDto> list, String id) {
    categoryId = id;
    childIndex = 0;
    page = 1;
    subId = '';
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(int index, String id) {
    subId = id;
    page = 1;
    childIndex = index;
    notifyListeners();
  }

  addPage() {
    page ++;
  }

}