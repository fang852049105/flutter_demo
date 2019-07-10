import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/provide/tab_index_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator(this.navigatorList, {Key key}) :super(key: key);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        Provide.value<TabIndexProvide>(context).changeIndex(1);
        Provide.value<TabIndexProvide>(context).changeCategoryId(item['mallCategoryId']);
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        physics: NeverScrollableScrollPhysics(),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      )
    );
  }
}
