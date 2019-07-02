import 'package:flutter/material.dart';

class AdBanner extends StatelessWidget {
  final String advertesPicture;

  AdBanner(this.advertesPicture, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Image.network(advertesPicture),
    );
  }
}