import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/pages/cart_page.dart';
import 'package:flutter_demo/shopping/pages/category_page.dart';
import 'package:flutter_demo/shopping/pages/category_page_provider.dart';
import 'package:flutter_demo/shopping/pages/home_page.dart';
import 'package:flutter_demo/shopping/pages/member_page.dart';
import 'package:flutter_demo/shopping/provide/tab_index_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ShoppingPageView extends StatefulWidget {
  @override
  _ShoppingPageViewState createState() => _ShoppingPageViewState();
}


class _ShoppingPageViewState extends State<ShoppingPageView> with SingleTickerProviderStateMixin {
  PageController _pageController;
  TabController _tabController;

  static List tabData = [
    {'text': '首页', 'icon': new Icon(CupertinoIcons.home)},
    {'text': '分类', 'icon': new Icon(CupertinoIcons.search)},
    {'text': '购物车', 'icon': new Icon(CupertinoIcons.shopping_cart)},
    {'text': '会员中心', 'icon': new Icon(CupertinoIcons.profile_circled)},
  ];

  final List<Widget> tabPages = [
    HomePage(),
    CategoryPage2(),
    CartPage(),
    MemberPage()
  ];
  List<Widget> myTabs = [];
  int currentIndex = 0;
  var currentPage;



  @override
  void initState() {
    currentPage = tabPages[currentIndex];
    _pageController = PageController();
//    _pageController.addListener((){
//      if (currentPage != _pageController.page.round()) {
//        setState(() {
//          currentPage = _pageController.page.round();
//        });
//      }
//    });
    for (int i = 0; i < tabData.length; i++) {
      myTabs.add(new Tab(text: tabData[i]['text'], icon: tabData[i]['icon']));
    }
    _tabController = new TabController(initialIndex: 0, vsync: this, length: tabData.length); // 这里的length 决定有多少个底导 submenus
    _tabController.addListener(() {
      currentIndex = _tabController.index;
      print('=========== controller currentIndex = $currentIndex');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Consumer<TabIndexProvide>(
      builder: (context, val, child) {
        int index = Provider.of<TabIndexProvide>(context).currentIndex;
        bool status = Provider.of<TabIndexProvide>(context).status;

        print('=========== index = $index');
        print('=========== currentIndex = $currentIndex');
        if (index != -1 && status &&  currentIndex != index) {
          _tabController.animateTo(index);
          _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
          //Provider.of<TabIndexProvide>(context).changeStatus();
        }
        print('=========== index = $index ========');
        print('=========== currentIndex = $currentIndex =======');
        return Scaffold(
          body: new PageView(
            ///必须有的控制器，与tabBar的控制器同步
            controller: _pageController,
            ///每一个 tab 对应的页面主体，是一个List<Widget>
            children: tabPages,
            onPageChanged: (index) {
              _tabController.animateTo(index);
            },
          ),
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
                  controller: _tabController,
                  indicatorColor: Theme.of(context).primaryColor,
                  indicatorWeight: 2.0,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.black26,
                  tabs: myTabs,
                  onTap: (index) {
                   _pageController.jumpToPage(index);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
