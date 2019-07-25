import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/components/Goods_datail_web.dart';
import 'package:flutter_demo/shopping/provide/goods_detail_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GoodsDetailTabView extends StatefulWidget {
  @override
  _GoodsDetailTabViewState createState() => _GoodsDetailTabViewState();
}

class _GoodsDetailTabViewState extends State<GoodsDetailTabView> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Widget> myTabs = [
    Tab(text: '详情'),
    Tab(text: '评论',)
  ];

  List<Widget> pages = [
    GoodsDetailWeb(0),
    GoodsDetailWeb(1)
  ];
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _tabController =  TabController(vsync: this, length: 2);// 和下面的 TabBar.tabs 数量对应
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        //Provider.of<GoodsDetailInfoProvide>(context).setIndxe(_tabController.index);
        print('tab index = ${_tabController.index}' );
        _pageController.jumpToPage(_tabController.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          TabBar(
              controller: _tabController,
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 2.0,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.black26,
              tabs: myTabs
          ),
          _getPageView()
        ],
      ),
    );
  }

  _getPageView() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(300),
      child: PageView(
        children: pages,
        controller: _pageController,
        onPageChanged: _onPageChanged,
      ),
    );
  }

  _onPageChanged(int index) {
    _pageController.jumpToPage(index);
    _tabController.animateTo(index);
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

