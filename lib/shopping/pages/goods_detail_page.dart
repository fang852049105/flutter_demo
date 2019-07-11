
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/components/Goods_datail_web.dart';
import 'package:flutter_demo/shopping/components/goods_detail_bottom.dart';
import 'package:flutter_demo/shopping/components/goods_detail_tabs_view.dart';
import 'package:flutter_demo/shopping/components/goods_detail_top_area.dart';
import 'package:flutter_demo/shopping/components/loading_dialog.dart';
import 'package:flutter_demo/shopping/model/goods_detail_model.dart';
import 'package:flutter_demo/shopping/provide/goods_detail_info.dart';
import 'package:flutter_demo/shopping/service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class GoodsDetailPage extends StatefulWidget {
  final String goodsId;
  // 如果父类没有无名无参数的默认构造函数，则子类必须手动代用一个父类的构造函数
  GoodsDetailPage(this.goodsId, {Key key}): super(key: key);

  @override
  _GoodsDetailPageState createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {

  GoodsDetailModel goodsDtailInfo = null;
  @override
  void initState() {
    _getGoodsInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            print('返回上一页');
            Navigator.pop(context);
          },
        ),
        title: Text('商品详细页'),
      ),
      body: _getBody(),
    );
  }

  Widget _getBody() {
    if (goodsDtailInfo != null) {
      return Stack (
        children: <Widget>[
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 65),
            child: Column(
              children: <Widget>[
                GoodsDetailTopArea(goodsDtailInfo?.data?.goodInfo),
                GoodsExplain(),
                GoodsDetailTabView(),
                //GoodsDetailWeb()
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child: GoodsDetailBottom(goodsDtailInfo?.data?.goodInfo),
          )
        ],
      );
    } else {
      return Center(
        child: LoadingDialog(
          text: "加载中...",
        ),
      );
    }
  }

  void _getGoodsInfo() async {
    var formData = {'goodId': widget.goodsId};
    await getContent('getGoodDetailById', formData: formData).then((val) {
      var data = json.decode(val.toString());
      goodsDtailInfo = GoodsDetailModel.fromJson(data);
      Provide.value<GoodsDetailInfoProvide>(context).setGoodsInfo(goodsDtailInfo);
      setState(() {
      });
    });
    Provide.value<GoodsDetailInfoProvide>(context).setGoodsInfo(goodsDtailInfo);
  }

}

class GoodsExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(10),
      child: Text(
        '说明：>急速送达>正品保证',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}



