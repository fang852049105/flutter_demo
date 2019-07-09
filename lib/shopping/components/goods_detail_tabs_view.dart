import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/provide/goods_detail_info.dart';
import 'package:provide/provide.dart';

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
  @override
  void initState() {
    super.initState();
    _tabController =  TabController(vsync: this, length: 2);// 和下面的 TabBar.tabs 数量对应
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        Provide.value<GoodsDetailInfoProvide>(context).setIndxe(_tabController.index);
        print('tab index = ${_tabController.index}' );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).primaryColor,
          indicatorWeight: 2.0,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.black26,
          tabs: myTabs
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

