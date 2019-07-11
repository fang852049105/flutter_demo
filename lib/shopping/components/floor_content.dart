import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/routers/routes.dart';
import 'package:flutter_demo/shopping/utils/NavigatorUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  FloorContent( this.floorGoodsList, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(context),
          _otherGoods(context)
        ],
      ),
    );
  }

  Widget _firstRow(BuildContext context){
    return Row(
      children: <Widget>[
        _goodsItem(context, floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(context, floorGoodsList[1]),
            _goodsItem(context, floorGoodsList[2]),
          ],
        )
      ],
    );
  }


  Widget _otherGoods(BuildContext context){
    return Row(
      children: <Widget>[
        _goodsItem(context, floorGoodsList[3]),
        _goodsItem(context, floorGoodsList[4]),
      ],
    );
  }

  Widget _goodsItem(BuildContext context, Map goods){

    return Container(
      width:ScreenUtil().setWidth(375),
      child: InkWell(
        onTap:(){
          print('点击了楼层商品');
          NavigatorUtil.goTransitionFromRightPage(context, Routes.goodsDetailPage, 'id=${goods['goodsId']}');
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}
