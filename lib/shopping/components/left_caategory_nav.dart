import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/model/category.dart';
import 'package:flutter_demo/shopping/service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<CategoryBigModel> categoryList = [];

  @override
  void initState() {
    _getCategory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1, color: Colors.black12)
        )
      ),
      child: ListView.builder(
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return _leftCategoryItem(index);
        },
      ),
    );
  }

  void _getCategory() async {
   await getContent('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryBigListModel model = CategoryBigListModel.formJson(data['data']);
      setState(() {
        categoryList = model.CategoryBigModelList;
      });
    });
  }

  Widget _leftCategoryItem(int index) {
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12)
          )
        ),
        child: Text(
          categoryList[index].mallCategoryName, 
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}
