import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/routers/routes.dart';
import 'package:flutter_demo/shopping/utils/NavigatorUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend(this.recommendList, {Key key}): super(key: key);

  /**
   *  推荐标题
   */
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border( //组件描边
          bottom: BorderSide(width: 0.5, color: Colors.black12)
        ),
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink)
      ),
    );
  }

  /**
   *  推荐商品item
   */
  Widget _itemWidget(BuildContext context, index) {
    return InkWell(
      onTap: (){
        NavigatorUtil.goTransitionFromRightPage(context, Routes.goodsDetailPage, 'id=${recommendList[index]['goodsId']}');
      },
      child: Container(
        height: ScreenUtil().setHeight(340),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5, color: Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('${recommendList[index]['mallPrice']}'),
            Text(
              '${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough, //删除线
                color: Colors.grey
              ),
            )
          ],
        ),
      ),
    );
  }

  /**
   * 推荐商品横向列表
   */
  Widget _recommendListWidget(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(340),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
          itemBuilder: (context, index){
            return _itemWidget(context, index);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(400),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendListWidget(context)
        ],
      ),
    );
  }
}
