import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/model/category_goods_list_model.dart';
import 'package:flutter_demo/shopping/provide/category_goods_list.dart';
import 'package:flutter_demo/shopping/provide/child_category.dart';
import 'package:flutter_demo/shopping/routers/application.dart';
import 'package:flutter_demo/shopping/routers/routes.dart';
import 'package:flutter_demo/shopping/service/service_method.dart';
import 'package:flutter_demo/shopping/utils/toast_util.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  var _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
    builder: (context, child, data) {
        if (data.goodsList.length > 0) {
          try {
            if (Provide.value<ChildCategory>(context).page == 1) {
              _scrollController.jumpTo(0.0);
            }
          } catch (e) {
            print('进入页面第一次初始化：${e}');
          }
          return Expanded(

            child:Container(
                width: ScreenUtil().setWidth(570) ,
                child: EasyRefresh(
                  refreshFooter: ClassicsFooter(
                    key: _footerKey,
                    bgColor: Colors.white,
                    textColor: Colors.pink,
                    moreInfoColor: Colors.pink,
                    noMoreText: '',
                  ),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: data.goodsList.length,
                    itemBuilder: (context, index) {
                      return _ListWidget(data.goodsList, index);
                    },
                  ),
                  loadMore: _loadMore
                )

            ) ,
          );
        } else {
          return Text('暂时没有数据');
        }
      },
    );
  }

  Future _loadMore() async {
    if (Provide.value<CategoryGoodsListProvide>(context).canLoadMore) {
      return _getMoreList();
    } else {
      return null;
    }
  }

  //上拉加载更多的方法
  Future _getMoreList() async{
    var data={
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).subId,
      'page': Provide.value<ChildCategory>(context).page == 1 ? 2 : Provide.value<ChildCategory>(context).page
    };

    getContent('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data != null) {
        Provide.value<CategoryGoodsListProvide>(context).addGoodsList(goodsList.data);
        Provide.value<ChildCategory>(context).addPage();
      } else {
        Provide.value<CategoryGoodsListProvide>(context).changeLoadMoreStatus(false);
        ToastUtil.getInstance().showToast("已经到底了");
      }
    });

  }

  Widget _ListWidget(List<CategoryListData> newList,int index){

    return InkWell(
        onTap: (){
          Application.router.navigateTo(context, Routes.goodsDetailPage + '?id=${newList[index].goodsId}');
        },
        child: Container(
          padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1.0,color: Colors.black12)
              )
          ),

          child: Row(
            children: <Widget>[
              _goodsImage(newList,index)
              ,
              Column(
                children: <Widget>[
                  _goodsName(newList,index),
                  _goodsPrice(newList,index)
                ],
              )
            ],
          ),
        )
    );

  }

  Widget _goodsImage(List<CategoryListData> newList,int index){

    return  Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );

  }

  Widget _goodsName(List<CategoryListData> newList,int index){
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(List<CategoryListData> newList,int index){
    return  Container(
        margin: EdgeInsets.only(top:20.0),
        width: ScreenUtil().setWidth(370),
        child:Row(
            children: <Widget>[
              Text(
                '￥${newList[index].presentPrice}',
                style: TextStyle(color:Colors.pink,fontSize:ScreenUtil().setSp(30)),
              ),
              Text(
                '￥${newList[index].oriPrice}',
                style: TextStyle(
                    color: Colors.black26,
                    decoration: TextDecoration.lineThrough
                ),
              )
            ]
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

}