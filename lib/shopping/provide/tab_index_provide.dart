import 'package:flutter/material.dart';

class TabIndexProvide with ChangeNotifier {
  int currentIndex = -1;
  bool status = false;

  changeIndex(int newIndex) {
    status = true;
    currentIndex = newIndex;
    notifyListeners();
  }

  changeStatus() {
    status = false;
    currentIndex = -1;
  }
}