import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/components/left_caategory_nav.dart';

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
        child: LeftCategoryNav(),
      ),
    );
  }

}
