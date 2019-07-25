import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/provide/goods_detail_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GoodsDetailWeb extends StatelessWidget {
  int index = 0;
  GoodsDetailWeb(this.index);

  @override
  Widget build(BuildContext context) {

    if (index == 0) {
      return Container(
          child: Image.network("http://images.baixingliangfan.cn/shopGoodsDetailImg/20181210/20181210150058_1059.jpg")
      );
    } else {
      return Container(
          width: ScreenUtil().setWidth(750),
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child:Text('暂时没有数据')
      );
    }
    /*var goodsDetail = Provider.of<GoodsDetailInfoProvide>(context).goodsDetailInfo?.data?.goodInfo?.goodsDetail;

    return Provide<GoodsDetailInfoProvide>(
      builder: (context, child, val) {
        int index = Provider.of<GoodsDetailInfoProvide>(context).tabIndex;
        if (index == 0) {
          return Container(
            child: Image.network("http://images.baixingliangfan.cn/shopGoodsDetailImg/20181210/20181210150058_1059.jpg")
          );
        } else {
          return Container(
              width: ScreenUtil().setWidth(750),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child:Text('暂时没有数据')
          );
        }
      },
    );*/
  }
}
