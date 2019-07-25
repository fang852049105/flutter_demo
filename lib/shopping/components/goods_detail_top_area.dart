import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/model/goods_detail_model.dart';
import 'package:flutter_demo/shopping/provide/goods_detail_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GoodsDetailTopArea extends StatelessWidget {
  GoodInfo goodsInfo = null;
  GoodsDetailTopArea(this.goodsInfo, {Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(2),
      child: Column(
        children: <Widget>[
          _goodsImage(goodsInfo.image1),
          _goodsName( goodsInfo.goodsName ),
          _goodsNum(goodsInfo.goodsSerialNumber),
          _goodsPrice(goodsInfo.presentPrice,goodsInfo.oriPrice)
        ],
      ),
    );
//    return Provide<GoodsDetailInfoProvide>(
//      builder: (context, child, val) {
//        var goodsInfo = Provider.of<GoodsDetailInfoProvide>(context).goodsInfo?.data?.goodInfo;
//        if (goodsInfo != null) {
//          return Container(
//            color: Colors.white,
//            padding: EdgeInsets.all(2),
//            child: Column(
//              children: <Widget>[
//                _goodsImage( goodsInfo.image1),
//                _goodsName( goodsInfo.goodsName ),
//                _goodsNum(goodsInfo.goodsSerialNumber),
//                _goodsPrice(goodsInfo.presentPrice,goodsInfo.oriPrice)
//              ],
//            ),
//          );
//        } else {
//          return Text('加载中...');
//        }
//      },
//    );
  }

  //商品图片
  Widget _goodsImage(url){
    return FadeInImage.assetNetwork(
        placeholder: "images/ic_loading.png",
        image: url,
        width: ScreenUtil().setWidth(740));

  }

  //商品名称
  Widget _goodsName(name){
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      child: Text(
        name,
        maxLines: 1,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(30)
        ),
      ),
    );
  }

  //商品编号
  Widget _goodsNum(num){
    return  Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      margin: EdgeInsets.only(top:8.0),
      child: Text(
        '编号:${num}',
        style: TextStyle(
            color: Colors.black26
        ),
      ),

    );
  }

  //商品价格方法
  Widget _goodsPrice(presentPrice,oriPrice){

    return  Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      margin: EdgeInsets.only(top:8.0),
      child: Row(
        children: <Widget>[
          Text(
            '￥${presentPrice}',
            style: TextStyle(
              color:Colors.pinkAccent,
              fontSize: ScreenUtil().setSp(40),

            ),

          ),
          Text(
            '市场价:￥${oriPrice}',
            style: TextStyle(
                color: Colors.black26,
                decoration: TextDecoration.lineThrough
            ),


          )
        ],
      ),
    );

  }
}
