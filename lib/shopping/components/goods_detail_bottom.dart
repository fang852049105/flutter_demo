import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/model/goods_detail_model.dart';
import 'package:flutter_demo/shopping/provide/cart_provide.dart';
import 'package:flutter_demo/shopping/provide/tab_index_provide.dart';
import 'package:flutter_demo/shopping/utils/NavigatorUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class GoodsDetailBottom extends StatelessWidget {
  GoodInfo goodsInfo = null;
  GoodsDetailBottom(this.goodsInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(130),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: (){},
            child: Container(
              width: ScreenUtil().setWidth(150) ,
              alignment: Alignment.center,
              child:Icon(
                Icons.shopping_cart,
                size: 35,
                color: Colors.red,
              ),
            ) ,
          ),
          InkWell(
            onTap: (){
              Provide.value<CartProvide>(context).save(goodsInfo.goodsId, goodsInfo.goodsName, 1, goodsInfo.presentPrice, goodsInfo.image1);
              Provide.value<TabIndexProvide>(context).changeIndex(2);
              NavigatorUtil.goBack(context);
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(300),
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),
              ),
            ) ,
          ),
          InkWell(
            onTap: (){},
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(300),
              color: Colors.red,
              child: Text(
                '马上购买',
                style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),
              ),
            ) ,
          ),
        ],
      ),
    );
  }
}
