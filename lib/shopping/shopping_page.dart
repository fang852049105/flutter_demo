import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/pages/cart_page.dart';
import 'package:flutter_demo/shopping/pages/category_page.dart';
import 'package:flutter_demo/shopping/pages/home_page.dart';
import 'package:flutter_demo/shopping/pages/member_page.dart';
import 'package:flutter_demo/shopping/routers/application.dart';

class ShoppingPage extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}


class _ShoppingPageState extends State<ShoppingPage> with SingleTickerProviderStateMixin {
  //方案一 BottomNavigationBar + pageview/IndexedStack
//  PageController _pageController;
//  final List<BottomNavigationBarItem> bottomTabs = [
//    BottomNavigationBarItem(
//      icon: Icon(CupertinoIcons.home),
//      title: Text('首页')
//    ),
//    BottomNavigationBarItem(
//        icon: Icon(CupertinoIcons.search),
//        title: Text('分类')
//    ),
//    BottomNavigationBarItem(
//        icon: Icon(CupertinoIcons.shopping_cart),
//        title: Text('购物车')
//    ),
//    BottomNavigationBarItem(
//        icon: Icon(CupertinoIcons.profile_circled),
//        title: Text('会员中心')
//    ),
//  ];
  final List<Widget> tabPages = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];
//  int currentIndex = 0;
//  var currentPage;

//方案二 TabBarView + Tabbar + TabController
  TabController controller;
  List<Widget> myTabs = [];
  static List tabData = [
    {'text': '首页', 'icon': new Icon(CupertinoIcons.home)},
    {'text': '分类', 'icon': new Icon(CupertinoIcons.search)},
    {'text': '购物车', 'icon': new Icon(CupertinoIcons.shopping_cart)},
    {'text': '会员中心', 'icon': new Icon(CupertinoIcons.profile_circled)},
  ];
  String appBarTitle = tabData[0]['text'];


  @override
  void initState() {
//    currentPage = tabPages[currentIndex];
//    _pageController = PageController()..addListener((){
//      if (currentPage != _pageController.page.round()) {
//        setState(() {
//          currentPage = _pageController.page.round();
//        });
//      }
//    });
    super.initState();
    controller = new TabController(initialIndex: 0, vsync: this, length: tabData.length); // 这里的length 决定有多少个底导 submenus
    for (int i = 0; i < tabData.length; i++) {
      myTabs.add(new Tab(text: tabData[i]['text'], icon: tabData[i]['icon']));
    }
    controller.addListener(() {
      if (controller.indexIsChanging) {
        _onTabChange();
      }
    });
    Application.controller = controller;
  }

  @override
  Widget build(BuildContext context) {
//    return Scaffold(
//      bottomNavigationBar: BottomNavigationBar(
//          items: bottomTabs,
//      type: BottomNavigationBarType.fixed,
//      currentIndex: currentIndex,
//      onTap: (index) {
//            setState(() {
//              currentIndex = index;
//              currentPage = tabPages[currentIndex];
//            });
//      },),
//      body: IndexedStack(
//        index: currentIndex,
//        children: tabPages
//      ),
//    );
    return new Scaffold(
      body: new TabBarView(controller: controller, children: tabPages),
      bottomNavigationBar: Material(
        color: Colors.white, //底部导航栏主题颜色
        child: SafeArea(
          child: Container(
            height: 65,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xFFd0d0d0),
                  blurRadius: 3.0,
                  spreadRadius: 2.0,
                  offset: Offset(-1.0, -1.0),
                ),
              ],
            ),
            child: TabBar(
                controller: controller,
                indicatorColor: Theme.of(context).primaryColor,
                indicatorWeight: 2.0,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.black26,
                tabs: myTabs),
          ),
        ),
      ),
    );
  }

  void _onTabChange() {
    if (this.mounted) {
      this.setState(() {
        appBarTitle = tabData[controller.index]['text'];
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
