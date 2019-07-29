import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/components/category_goods_list.dart';
import 'package:flutter_demo/shopping/components/left_category_nav.dart';
import 'package:flutter_demo/shopping/components/loader_container.dart';
import 'package:flutter_demo/shopping/components/right_category_nav.dart';
import 'package:flutter_demo/shopping/config/loader_state.dart';
import 'package:flutter_demo/shopping/model/category_goods_list_model.dart';
import 'package:flutter_demo/shopping/model/category_model.dart';
import 'package:flutter_demo/shopping/provide/category_goods_list.dart';
import 'package:flutter_demo/shopping/provide/child_category.dart';
import 'package:flutter_demo/shopping/provide/page_loader_model.dart';
import 'package:flutter_demo/shopping/provide/tab_index_provide.dart';
import 'package:flutter_demo/shopping/utils/http_util.dart';
import 'package:provider/provider.dart';

class CategoryPage2 extends StatefulWidget {
  @override
  _CategoryPage2State createState() => _CategoryPage2State();
}


class _CategoryPage2State extends State<CategoryPage2> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  List<CategoryBigModel> categoryList = [];

  PageLoaderStateModel _loaderStateModel;

  @override
  void initState() {
    print('======CategoryPage 初始化======');
    super.initState();
    new Timer(Duration(milliseconds: 200) , () {
      _loaderStateModel= Provider.of<PageLoaderStateModel>(context);
      getCategory();
    });
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
   return Consumer<PageLoaderStateModel>(
     builder: (context, date , child) {
       return LoaderContainer(
         loaderState: date.loaderState,
         onReload: getCategory,
         contentView: Scaffold(
           appBar: AppBar(
             title: Text('商品分类'),
           ),
           body: Consumer<TabIndexProvide>(
             builder: (context, val, child) {
               return Container(
                 child: Row(
                   children: <Widget>[
                     LeftCategoryNav(categoryList, val.categoryId.isEmpty ? '4' : val.categoryId),
                     Column(
                       children: <Widget>[
                         RightCategoryNav(),
                         CategoryGoodsList()
                       ],
                     )
                   ],
                 ),
               );
             },
           ),
         ),
       );
     },
   );
  }


  void getCategory() async{
    _loaderStateModel.changeState(LoaderState.loading);
    HttpUtil.getInstance().post('getCategory',
        successCallBack: (val) {
          var data = json.decode(val.toString());
          CategoryBigListModel model = CategoryBigListModel.formJson(
              data['data']);
          categoryList = model.CategoryBigModelList;
          Provider.of<ChildCategory>(context).setChildCategory(
              categoryList[0].bxMallSubDto, categoryList[0].mallCategoryId);
          _getGoodsList();
        },
        errorCallBack: (val) {
          _loaderStateModel.changeState(LoaderState.fail, val);
        });
  }

  void _getGoodsList({String categoryId}) async {
    var data = {
      'categoryId':categoryId == null ? '4' : categoryId,
      'categorySubId':"",
      'page':1
    };
    HttpUtil.getInstance().post('getMallGoods',
        successCallBack: (val) {
          var data = json.decode(val.toString());
          CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(
              data);
          if (goodsList.data == null) {
            Provider.of<CategoryGoodsListProvide>(context).setGoodsList([]);
          } else {
            Provider.of<CategoryGoodsListProvide>(context).setGoodsList(
                goodsList.data);
          }
          _loaderStateModel.changeState(LoaderState.success);
        },
        errorCallBack: (val) {
          _loaderStateModel.changeState(LoaderState.fail, val);
        },
        params: data);

  }

}
