import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/model/cart_info_model.dart';
import 'package:flutter_demo/shopping/provide/cart_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class CartBottom extends StatelessWidget {

  final List<CartInfoModel> cartList;
  CartBottom(this.cartList);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      child: Row(
        children: <Widget>[
          _selectAllBtn(context),
          _allPriceArea(),
          _payButton()
        ],
      ),
    );
  }

  Widget _selectAllBtn(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: getAllCheckStatus(),
            activeColor: Colors.pink,
            onChanged: (bool val) {
              Provide.value<CartProvide>(context).changeAllCheckStatus();
            },
          ),
          Text('全选')
        ],
      ),
    );
  }

  // 合计区域
  Widget _allPriceArea() {
    return Container(
      width: ScreenUtil().setWidth(430),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text('合计:',
                    style: TextStyle(fontSize: ScreenUtil().setSp(36))),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(150),
                child: Text('￥${getPrice()}',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(36),
                      color: Colors.red,
                    )),
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                  color: Colors.black38, fontSize: ScreenUtil().setSp(22)),
            ),
          )
        ],
      ),
    );
  }

  Widget _payButton(){
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child:InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(3.0)
          ),
          child: Text(
            '结算${cartList?.length}',
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
      ) ,
    );
  }

  String getPrice() {
    double price = 0.0;
    for (var cartInfoModel in cartList) {
      if (cartInfoModel.isCheck) {
        price = price + cartInfoModel.price * cartInfoModel.count;
      }
    }
    return price.toStringAsFixed(2);
  }

  bool getAllCheckStatus() {
    bool allCheckStatus = true;
    for (var cartInfoModel in cartList) {
     if (!cartInfoModel.isCheck) {
       allCheckStatus = false;
       break;
     }
    }
    return allCheckStatus;
  }

}
