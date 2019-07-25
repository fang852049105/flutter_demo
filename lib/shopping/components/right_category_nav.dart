import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/components/loading_dialog.dart';
import 'package:flutter_demo/shopping/model/category_goods_list_model.dart';
import 'package:flutter_demo/shopping/model/category_model.dart';
import 'package:flutter_demo/shopping/provide/category_goods_list.dart';
import 'package:flutter_demo/shopping/provide/child_category.dart';
import 'package:flutter_demo/shopping/service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RightCategoryNav extends StatefulWidget {
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Consumer<ChildCategory>(
          builder: (context, childCategory, child) {
            return Container(
                height: ScreenUtil().setHeight(80),
                width: ScreenUtil().setWidth(570),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black12)
                    )
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: childCategory.childCategoryList.length,
                  itemBuilder: (context, index) {
                    return _rightInkWell(childCategory.childCategoryList[index], index);
                  },
                )
            );
          },
        )
    );
  }

  Widget _rightInkWell(BxMallSubDto item, int index) {
    bool isHighLight = (index==Provider.of<ChildCategory>(context).childIndex);
    return InkWell(
      onTap: () {
        Provider.of<CategoryGoodsListProvide>(context).changeLoadMoreStatus(true);
        Provider.of<ChildCategory>(context).changeChildIndex(index, item.mallSubId);
        _getGoodList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: isHighLight ? Colors.pink : Colors.black),
        ),
      ),
    );
  }

  void _getGoodList(String categorySubId) {

    var data = {
      'categoryId':Provider.of<ChildCategory>(context).categoryId,
      'categorySubId':categorySubId,
      'page':1
    };
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: LoadingDialog(
              text: "加载中...",
            ),
          );
        });

    getContent('getMallGoods',formData:data ).then((val){
      var  data = json.decode(val.toString());
      CategoryGoodsListModel goodsList=  CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Provider.of<CategoryGoodsListProvide>(context).setGoodsList([]);
      } else {
        Provider.of<CategoryGoodsListProvide>(context).setGoodsList(goodsList.data);
      }
      Navigator.pop(context);
    });

//    HttpUtil.getInstance().post(servicePath['getMallGoods'], (val) {
//      var  data = json.decode(val.toString());
//      CategoryGoodsListModel goodsList=  CategoryGoodsListModel.fromJson(data);
//      if (goodsList.data == null) {
//        Provider.of<CategoryGoodsListProvide>(context).setGoodsList([]);
//      } else {
//        Provider.of<CategoryGoodsListProvide>(context).setGoodsList(goodsList.data);
//      }
//    }, params: data);
  }

}