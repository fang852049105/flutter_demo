import 'package:flutter/material.dart';

class FloorTitle extends StatelessWidget {

  final String picUrl;
  FloorTitle(this.picUrl, {Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Image.network(picUrl)
    );
  }
}
