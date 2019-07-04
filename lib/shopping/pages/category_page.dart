import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/components/category_goods_list.dart';
import 'package:flutter_demo/shopping/components/left_category_nav.dart';
import 'package:flutter_demo/shopping/components/loading_dialog.dart';
import 'package:flutter_demo/shopping/components/right_category_nav.dart';
import 'package:flutter_demo/shopping/model/category_goods_list_model.dart';
import 'package:flutter_demo/shopping/model/category_model.dart';
import 'package:flutter_demo/shopping/provide/category_goods_list.dart';
import 'package:flutter_demo/shopping/provide/child_category.dart';
import 'package:flutter_demo/shopping/service/service_method.dart';
import 'package:provide/provide.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}


class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  List<CategoryBigModel> categoryList = [];

  @override
  void initState() {
    _getCategory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (categoryList != null && categoryList.length > 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text('商品分类'),
        ),
        body: Container(
          child: Row(
            children: <Widget>[
              LeftCategoryNav(categoryList),
              Column(
                children: <Widget>[
                  RightCategoryNav(),
                  CategoryGoodsList()
                ],
              )
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: LoadingDialog(
          text: "加载中...",
        ),
      );
    }
  }

  void _getCategory() async {
   await getContent('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryBigListModel model = CategoryBigListModel.formJson(data['data']);
      categoryList = model.CategoryBigModelList;
      Provide.value<ChildCategory>(context).setChildCategory(categoryList[0].bxMallSubDto, categoryList[0].mallCategoryId);
   });
   _getGoodsList();
  }

  void _getGoodsList({String categoryId}) async {
    var data = {
      'categoryId':categoryId == null ? '4' : categoryId,
      'categorySubId':"",
      'page':1
    };

    await getContent('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList =  CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Provide.value<CategoryGoodsListProvide>(context).setGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context).setGoodsList(goodsList.data);
      }
      setState(() {

      });
    });
  }

}
