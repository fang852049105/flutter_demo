import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static ToastUtil instance;

  static ToastUtil getInstance() {
    if (instance == null) {
      instance = ToastUtil();
    }
    return instance;
  }

  ToastUtil() {
  }

  showToast(String msg) {
    Fluttertoast.showToast(
        msg: "已经到底了",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.pink,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}