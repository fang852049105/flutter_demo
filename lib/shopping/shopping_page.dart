import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/bottomnavigationbar/pages/airplay_screen.dart';
import 'package:flutter_demo/bottomnavigationbar/pages/pages_screen.dart';
import 'package:flutter_demo/shopping/pages/cart_page.dart';
import 'package:flutter_demo/shopping/pages/category_page.dart';
import 'package:flutter_demo/shopping/pages/home_page.dart';

class ShoppingPage extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  PageController _pageController;
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页')
    ),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        title: Text('分类')
    ),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        title: Text('购物车')
    ),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled),
        title: Text('会员中心')
    ),
  ];
  final List<Widget> tabPages = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    AirPlayScreen()
  ];
  int currentIndex = 0;
  var currentPage;


  @override
  void initState() {
    currentPage = tabPages[currentIndex];
    _pageController = PageController()..addListener((){
      if (currentPage != _pageController.page.round()) {
        setState(() {
          currentPage = _pageController.page.round();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
          items: bottomTabs,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) {
            setState(() {
              currentIndex = index;
              currentPage = tabPages[currentIndex];
            });
      },),
      body: IndexedStack(
        index: currentIndex,
        children: tabPages
      ),
    );
  }
}
