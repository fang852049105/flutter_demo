import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/components/cart_bottom.dart';
import 'package:flutter_demo/shopping/components/cart_item.dart';
import 'package:flutter_demo/shopping/components/loading_dialog.dart';
import 'package:flutter_demo/shopping/model/cart_info_model.dart';
import 'package:flutter_demo/shopping/provide/cart_provide.dart';
import 'package:provide/provide.dart';


class CartPage extends StatelessWidget {
  List<CartInfoModel> cartList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          cartList = Provide.value<CartProvide>(context).cartList;
          if (snapshot.hasData && cartList != null) {
            return Provide<CartProvide>(
              builder: (context, child, val) {
                cartList = Provide.value<CartProvide>(context).cartList;
                print(cartList);
                return Stack(
                  children: <Widget>[
                    ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        return CartItem(cartList[index]);
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: CartBottom(cartList),
                    )
                  ],
                );
              }
            );
//            return Stack(
//              children: <Widget>[
//                Provide<CartProvide>(
//                    builder: (context, child, childCategory){
//                      cartList = Provide.value<CartProvide>(context).cartList;
//                      print(cartList);
//                      return ListView.builder(
//                        itemCount: cartList.length,
//                        itemBuilder: (context,index){
//                          return CartItem(cartList[index]);
//                        },
//                      );
//                    }
//                ),
//                Positioned(
//                  bottom: 0,
//                  left: 0,
//                  child: CartBottom(cartList),
//                )
//              ],
//            );
          } else {
            return Center(
              child: LoadingDialog(
                text: "加载中...",
              ),
            );
          }
        },
      ),
    );
  }

  Future _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}

