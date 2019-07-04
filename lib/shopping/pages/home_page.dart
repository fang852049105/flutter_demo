import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/components/ad_banner.dart';
import 'package:flutter_demo/shopping/components/floor_content.dart';
import 'package:flutter_demo/shopping/components/floor_title.dart';
import 'package:flutter_demo/shopping/components/leader_phone.dart';
import 'package:flutter_demo/shopping/components/loading_dialog.dart';
import 'package:flutter_demo/shopping/components/recommend.dart';
import 'package:flutter_demo/shopping/components/top_navigator.dart';
import 'package:flutter_demo/shopping/components/wheel_banner.dart';
import 'package:flutter_demo/shopping/routers/application.dart';
import 'package:flutter_demo/shopping/routers/routes.dart';
import 'package:flutter_demo/shopping/service/service_method.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  String homePageContent = '正在获取数据';
  int page = 2;
  List<Map> hotGoodsList=[];
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  var data = null;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _getPageContent();
    super.initState();
    print('======home_page 初始化======');
  }

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      List<Map> bannerList = (data['data']['slides'] as List)
          .cast(); //cast() 类型提升；as 类型转换
      String advertesPicture = data['data']['advertesPicture']['PICTURE_ADDRESS']; //广告图片
      List<Map> navigatorList = (data['data']['category'] as List).cast(); //类别列表
      if (navigatorList.length > 10) {
        navigatorList.removeRange(10, navigatorList.length);
      }
      List<Map> recommendList = (data['data']['recommend'] as List).cast(); // 商品推荐
      String leaderImage = data['data']['shopInfo']['leaderImage']; //店长图片
      String leaderPhone = data['data']['shopInfo']['leaderPhone']; //店长电话
      String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
      String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
      String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
      List<Map> floor1 = (data['data']['floor1'] as List).cast(); //楼层1商品和图片
      List<Map> floor2 = (data['data']['floor2'] as List).cast(); //楼层1商品和图片
      List<Map> floor3 = (data['data']['floor3'] as List).cast(); //楼层1商品和图片

      return Scaffold(
        appBar: AppBar(
          title: Text('百姓生活+'),
        ),
        body: Container(
          child: EasyRefresh(
            child: ListView(
              children: <Widget>[
                WheelBanner(bannerList),
                TopNavigator(navigatorList),
                AdBanner(advertesPicture),
                LeaderPhone(leaderImage, leaderPhone),
                Recommend(recommendList),
                FloorTitle(floor1Title),
                FloorContent(floor1),
                FloorTitle(floor2Title),
                FloorContent(floor2),
                FloorTitle(floor3Title),
                FloorContent(floor3),
                _hotGoods(),
              ],
            ),
            loadMore: () async {
              print('======开始加载更多======');
              _getHotGoods();
            },
            refreshFooter: ClassicsFooter(
              key: _footerKey,
              bgColor: Colors.white,
              textColor: Colors.orange,
              moreInfoColor: Colors.orange,
              noMoreText: '',
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: LoadingDialog(
          text: "加载中...",
        ),
      );
    }

  }

  Future _getPageContent() {
    var fromData =  {'lon':'115.02932','lat':'35.76189'};
    getContent('homePageContent', formData: fromData).then((val) {
      setState(() {
        data = json.decode(val.toString());
      });
    });
  }

  void _getHotGoods(){
    var formPage={'page': page};
    getContent('homePageHotContent', formData:formPage).then((val){
      var data = json.decode(val.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }

  //火爆专区标题
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),

    padding: EdgeInsets.all(5.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.black12)
        )
    ),
    child: Text('火爆专区'),
  );

  //火爆专区子项
  Widget _wrapList(){
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
            onTap: () {
              Application.router.navigateTo(context, Routes.goodsDetailPage + '?id=${val['goodsId']}');
            },
            child:
            Container(
              width: ScreenUtil().setWidth(372),
              color: Colors.white,
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(bottom: 3.0),
              child: Column(
                children: <Widget>[
                  Image.network(
                    val['image'], width: ScreenUtil().setWidth(375),),
                  Text(
                    val['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                  ),
                  Row(
                    children: <Widget>[
                      Text('￥${val['mallPrice']}'),
                      Text(
                        '￥${val['price']}',
                        style: TextStyle(color: Colors.black26,
                            decoration: TextDecoration.lineThrough),

                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                ],
              ),
            )

        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    }else{
      return Text(' ');
    }
  }

  Widget _hotGoods(){

    return Container(

        child:Column(
          children: <Widget>[
            hotTitle,
            _wrapList(),
          ],
        )
    );
  }
}
