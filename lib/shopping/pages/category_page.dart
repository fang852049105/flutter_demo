import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/components/category_goods_list.dart';
import 'package:flutter_demo/shopping/components/left_category_nav.dart';
import 'package:flutter_demo/shopping/components/right_category_nav.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList()
              ],
            )
          ],
        ),
      ),
    );
  }

}
