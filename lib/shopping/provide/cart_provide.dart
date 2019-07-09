import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/model/cart_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvide with ChangeNotifier {
  String cartStr = ""; //shared_preferences 不支持对象持久化
  List<CartInfoModel> cartList = [];
  final String CART_INFO = 'cartInfo';

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartStr = prefs.getString(CART_INFO);
    var temp = cartStr == null ? [] : json.decode(cartStr.toString());
    List<Map> tempList = (temp as List).cast();
    //声明变量，用于判断购物车中是否已经存在此商品ID
    var isHave = false; //默认为没有
    int ival = 0; //用于进行循环的索引使用
    for (var map in tempList) {
      if (map['goodsId'] == goodsId) {
        tempList[ival]['count'] = map['count'] + 1;
        isHave = true;
        cartList[ival].count ++;
        break;
      }
      ival++;
    }
    //  如果没有，进行增加
    if (!isHave) {
      Map<String, dynamic> goods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true
      };
      tempList.add(goods);
      cartList.add(new CartInfoModel.fromJson(goods));
    }
    //把字符串进行encode操作，
    cartStr = json.encode(tempList).toString();
    print(cartStr);
    prefs.setString('cartInfo', cartStr); //进行持久化
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove(CART_INFO);
    print('清空完成-----------------');
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartStr = prefs.getString(CART_INFO);
    if (cartStr != null) {
      List<Map> tempList = (json.decode(cartStr.toString()) as List).cast<Map>();
      cartList.clear();
      for (var map in tempList) {
        cartList.add(new CartInfoModel.fromJson(map));
      }
    }
  }

  removeGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartStr = prefs.getString(CART_INFO);
    if (cartStr != null) {
      List<Map> tempList = (json.decode(cartStr.toString()) as List).cast<Map>();
      int tempIndex = 0;
      int delIndex = 0;
      for (var map in tempList) {
        if (map['goodsId'] == goodsId) {
          delIndex = tempIndex;
          break;
        }
        tempIndex ++;
      }
      tempList.removeAt(delIndex);
      cartStr = json.encode(tempList).toString();
      prefs.setString(CART_INFO, cartStr);
      await getCartInfo();
      notifyListeners();
    }
  }

  addGoodsNum(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartStr = prefs.getString(CART_INFO);
    if (cartStr != null) {
      List<Map> tempList = (json.decode(cartStr.toString()) as List).cast<Map>();
      for (var map in tempList) {
        if (map['goodsId'] == goodsId) {
          map['count'] ++;
          break;
        }
      }
      cartStr = json.encode(tempList).toString();
      prefs.setString(CART_INFO, cartStr);
      await getCartInfo();
      notifyListeners();
    }
  }

  reduceGoodsNum(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartStr = prefs.getString(CART_INFO);
    if (cartStr != null) {
      List<Map> tempList = (json.decode(cartStr.toString()) as List).cast<Map>();
      for (var map in tempList) {
        if (map['goodsId'] == goodsId) {
          if (map['count'] > 1) {
            map['count'] --;
          }
          break;
        }
      }
      cartStr = json.encode(tempList).toString();
      prefs.setString(CART_INFO, cartStr);
      await getCartInfo();
      notifyListeners();
    }
  }

  changeCheckStatus(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartStr = prefs.getString(CART_INFO);
    if (cartStr != null) {
      List<Map> tempList = (json.decode(cartStr.toString()) as List).cast<Map>();
      int tempIndex = 0;
      int addIndex = 0;
      for (var map in tempList) {
        if (map['goodsId'] == goodsId) {
          addIndex = tempIndex;
          break;
        }
        tempIndex ++;
      }
      tempList[addIndex]['isCheck'] = !tempList[addIndex]['isCheck'];
      cartStr = json.encode(tempList).toString();
      prefs.setString(CART_INFO, cartStr);
      await getCartInfo();
      notifyListeners();
    }
  }

  changeAllCheckStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartStr = prefs.getString(CART_INFO);
    if (cartStr != null) {
      List<Map> tempList = (json.decode(cartStr.toString()) as List).cast<Map>();
      for (var map in tempList) {
        map['isCheck'] = !map['isCheck'];
      }
      cartStr = json.encode(tempList).toString();
      prefs.setString(CART_INFO, cartStr);
      await getCartInfo();
      notifyListeners();
    }
  }

}
