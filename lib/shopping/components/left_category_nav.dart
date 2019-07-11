import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/model/category_goods_list_model.dart';
import 'package:flutter_demo/shopping/model/category_model.dart';
import 'package:flutter_demo/shopping/provide/category_goods_list.dart';
import 'package:flutter_demo/shopping/provide/child_category.dart';
import 'package:flutter_demo/shopping/provide/tab_index_provide.dart';
import 'package:flutter_demo/shopping/service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'loading_dialog.dart';


class LeftCategoryNav extends StatefulWidget {
  List<CategoryBigModel> categoryList = [];
  String categoryId = '4';
  LeftCategoryNav(this.categoryList, this.categoryId, {Key key}): super(key: key);

  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  //List<CategoryBigModel> categoryList = [];
  //var listIndex = 0; //索引
  //String categoryId = '4';

  @override
  void initState() {
    //_getCategory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Provide<TabIndexProvide>(
      builder: (context, child, val) {
        String currentCategoryId = Provide.value<ChildCategory>(context).categoryId;
        if (!val?.categoryId.isEmpty && currentCategoryId != val?.categoryId) {
          var childList = widget.categoryList[_getIndexForCategoryId(val.categoryId)].bxMallSubDto;
          Provide.value<CategoryGoodsListProvide>(context).changeLoadMoreStatus(true);
          Provide.value<ChildCategory>(context).setChildCategory(childList, val.categoryId);
          _delayGetGoodsList(val.categoryId);
        }
        return Container(
          width: ScreenUtil().setWidth(180),
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(width: 1, color: Colors.black12)
              )
          ),
          child: ListView.builder(
            itemCount: widget.categoryList.length,
            itemBuilder: (context, index) {
              return _leftCategoryItem(index);
            },
          ),
        );
      },
    );


//    return Container(
//      width: ScreenUtil().setWidth(180),
//      decoration: BoxDecoration(
//        border: Border(
//          right: BorderSide(width: 1, color: Colors.black12)
//        )
//      ),
//      child: ListView.builder(
//        itemCount: widget.categoryList.length,
//        itemBuilder: (context, index) {
//          return _leftCategoryItem(index);
//        },
//      ),
//    );
  }

  int _getIndexForCategoryId(String categoryId) {
    int index = 0;
    if (categoryId.isEmpty) {
      return index;
    }
    for (var categoryBigModel in widget.categoryList) {
      if (categoryBigModel.mallCategoryId == categoryId) {
        return index;
      }
      index ++;
    }
    return index;
  }

   _delayGetGoodsList(String categoryId) {
    new Timer(Duration(milliseconds: 200) , () {
      _getGoodsList(categoryId: categoryId);
    });
  }

  void _getGoodsList({String categoryId}) async {
    var data = {
      'categoryId':categoryId == null ? '4' : categoryId,
      'categorySubId':"",
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

    await getContent('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList =  CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Provide.value<CategoryGoodsListProvide>(context).setGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context).setGoodsList(goodsList.data);
      }
      Navigator.pop(context);
    });
  }

  Widget _leftCategoryItem(int index) {
    bool isHighLight = (widget.categoryId == widget.categoryList[index]?.mallCategoryId);
    return InkWell(
      onTap: () {
        setState(() {
          widget.categoryId = widget.categoryList[index]?.mallCategoryId;
        });

        var childList = widget.categoryList[index].bxMallSubDto;
        //widget.categoryId = widget.categoryList[index].mallCategoryId;
        Provide.value<CategoryGoodsListProvide>(context).changeLoadMoreStatus(true);
        Provide.value<ChildCategory>(context).setChildCategory(childList, widget.categoryId);
        _getGoodsList(categoryId: widget.categoryId);

      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
        decoration: BoxDecoration(
          color: isHighLight ? Colors.black12 : Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12)
          )
        ),
        child: Text(
          widget.categoryList[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

}
