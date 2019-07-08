import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/model/cart_info_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'goods_num.dart';

class CartItem extends StatelessWidget {

  final CartInfoModel item;
  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12)
        )
      ),
      child: Row(
        children: <Widget>[
          _checkbox(item),
          _goodsImagas(item),
          _goodsName(item),
          _goodsPrice(item)
        ],
      ),
    );
  }

  //多选按钮
  Widget _checkbox(CartInfoModel item) {
    return Container(
      child: Checkbox(
          value: item.isCheck,
          activeColor: Colors.pink,
          onChanged: (bool val) {},
      )
    );
  }

  Widget _goodsImagas(CartInfoModel item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12)
      ),
      child: FadeInImage.assetNetwork(
          placeholder:  'images/ic_loading.png',
          image: item.images),
    );
  }

  Widget _goodsName(CartInfoModel item) {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName),
          GoodsNum()
        ],
      ),
    );
  }

  //商品价格
  Widget _goodsPrice(item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

}
