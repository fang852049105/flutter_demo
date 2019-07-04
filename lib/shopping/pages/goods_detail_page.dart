import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/components/loading_dialog.dart';
import 'package:flutter_demo/shopping/model/goods_detail_model.dart';
import 'package:flutter_demo/shopping/provide/goods_detail_info.dart';
import 'package:flutter_demo/shopping/service/service_method.dart';
import 'package:provide/provide.dart';

class GoodsDetailPage extends StatelessWidget {

  final String goodsId;
  GoodsDetailModel goodsInfo = null;
  // 如果父类没有无名无参数的默认构造函数，则子类必须手动代用一个父类的构造函数
  GoodsDetailPage(this.goodsId, {Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    var formData = {'goodId': goodsId};
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:Icon(Icons.arrow_back),
          onPressed: (){
            print('返回上一页');
            Navigator.pop(context);
          },
        ),
        title: Text('商品详细页'),
      ),
      body: FutureBuilder(
          future: getContent('getGoodDetailById', formData:formData),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              goodsInfo = GoodsDetailModel.fromJson(data);
              return Container(
                child: Column(
                  children: <Widget>[
                    _goodsInfoWidget(),
                  ],
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
      ),
    );
  }

  Widget _goodsInfoWidget() {
    return Container(
      child: Text('加载完成'),
    );
  }

//  Future _getGoodsInfo(BuildContext context) async {
//    await Provide.value<GoodsDetailInfoProvide>(context).getGoodsInfo(goodsId);
//  }
}
