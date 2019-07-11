import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/routers/routes.dart';
import 'package:flutter_demo/shopping/utils/NavigatorUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

//首页banner，使用Swiper插件
class WheelBanner extends StatelessWidget {
  final List bannerList;

  WheelBanner(this.bannerList, {Key key}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(300.0),
      width: ScreenUtil().setWidth(750.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
         return _imageWidget(context, bannerList[index]);
        },
        itemCount: bannerList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }

  Widget _imageWidget(BuildContext context, item) {
    return Container(
      child: InkWell(
        onTap: () {
          NavigatorUtil.goTransitionFromRightPage(context, Routes.goodsDetailPage, 'id=${item['goodsId']}');
        },
        child:  Image.network(item['image'], fit: BoxFit.fill),
      ),
    );
  }
}
