import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/model/cart_info_model.dart';
import 'package:flutter_demo/shopping/provide/cart_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class GoodsNum extends StatelessWidget {

  final CartInfoModel item;
  GoodsNum(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(210),
      margin: EdgeInsets.only(top:10.0),
      decoration: BoxDecoration(
          border:Border.all(width: 1 , color:Colors.black12)
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _countArea(),
          _addBtn(context),
        ],
      ),
    );
  }

  // 减少按钮
  Widget _reduceBtn(BuildContext context){
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).reduceGoodsNum(item.goodsId);
      },
      child: Container(
        width: ScreenUtil().setWidth(50),
        height: ScreenUtil().setHeight(50),
        alignment: Alignment.center,

        decoration: BoxDecoration(
            color: Colors.white,
            border:Border(
                right:BorderSide(width:1,color:Colors.black12)
            )
        ),
        child: Text('-'),
      ),
    );
  }

  //添加按钮
  Widget _addBtn(BuildContext context){
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).addGoodsNum(item.goodsId);
      },
      child: Container(
        width: ScreenUtil().setWidth(50),
        height: ScreenUtil().setHeight(50),
        alignment: Alignment.center,

        decoration: BoxDecoration(
            color: Colors.white,
            border:Border(
                left:BorderSide(width:1,color:Colors.black12)
            )
        ),
        child: Text('+'),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea(){
    return Container(
      width: ScreenUtil().setWidth(100),
      height: ScreenUtil().setHeight(50),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(item.count.toString()),
    );
  }
}
