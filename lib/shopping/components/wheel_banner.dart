import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

//首页banner，使用Swiper插件
class WheelBanner extends StatelessWidget {
  final List bannerList;

  WheelBanner(this.bannerList, {Key key}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Container(
      height: ScreenUtil().setHeight(300.0),
      width: ScreenUtil().setWidth(750.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network('${bannerList[index]['image']}', fit: BoxFit.fill);
        },
        itemCount: bannerList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
