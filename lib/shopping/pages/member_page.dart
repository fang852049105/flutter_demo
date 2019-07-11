import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/provide/counter_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return Scaffold(
//        body:Center(
//          child: Column(
//            children: <Widget>[
//              Number(),
//              MyButton()
//            ],
//          ),
//        )
//    );
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[
          _header(),
          _orderTitle(),
          _orderType(),
          _otherTiles()
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setWidth(300),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            child: ClipOval(
              child: Image.asset('images/ic_oval.png',
                width: ScreenUtil().setWidth(150),
                height: ScreenUtil().setWidth(150),
                fit:BoxFit.fill,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              '程序猿',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  Widget _orderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _orderType() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(160),
      padding: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.party_mode,
                  size: 30,
                ),
                Text('待付款'),
              ],
            ),
          ),
          //-----------------
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.query_builder,
                  size: 30,
                ),
                Text('待发货'),
              ],
            ),
          ),
          //-----------------
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.directions_car,
                  size: 30,
                ),
                Text('待收货'),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.content_paste,
                  size: 30,
                ),
                Text('待评价'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _otherTile(String title){
    return Card(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom:BorderSide(width: 1,color:Colors.black12)
            )
        ),
        child: ListTile(
          leading: Icon(Icons.blur_circular),
          title: Text(title),
          trailing: Icon(Icons.arrow_right),
        ),
      ),
    );
//    return Container(
//      decoration: BoxDecoration(
//          color: Colors.white,
//          border: Border(
//              bottom:BorderSide(width: 1,color:Colors.black12)
//          )
//      ),
//      child: ListTile(
//        leading: Icon(Icons.blur_circular),
//        title: Text(title),
//        trailing: Icon(Icons.arrow_right),
//      ),
//    );
  }

  Widget _otherTiles(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _otherTile('领取优惠券'),
          _otherTile('已领取优惠券'),
          _otherTile('地址管理'),
          _otherTile('客服电话'),
          _otherTile('关于我们'),
        ],
      ),
    );
  }
}

//class Number extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      margin: EdgeInsets.only(top:200),
//      child: Provide<Counter>(
//        builder: (context,child,counter){
//          return Text(
//            '${counter.value}',
//            style: Theme.of(context).textTheme.display1,
//          );
//        },
//      ),
//    );
//  }
//}
//
//
//
//class MyButton extends StatelessWidget {
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        child: RaisedButton(
//          onPressed: () {
//            Provide.value<Counter>(context).increment();
//          },
//          child: Text('递增'),
//        )
//    );
//  }
//}
