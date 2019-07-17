import 'package:flutter/material.dart';

///SnackBar 是 Scaffold 的子 Widget, 它不能被 Scaffold 内部任何其他子节点直接访问,于是通过父 Widget 使用GlobalKey.currentState来访问
class FatherAccessChildStateWidget extends StatefulWidget {
  @override
  _FatherAccessChildStateWidgetState createState() => _FatherAccessChildStateWidgetState();
}

class _FatherAccessChildStateWidgetState extends State<FatherAccessChildStateWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('AccessChildStateState'),
      ),
      body: Center(
        child: RaisedButton(
            child: Text('AccessChildState'),
            onPressed: (){
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text('This is SnackBar...'),
                )
              );
            }),
      ),
    );
  }
}

