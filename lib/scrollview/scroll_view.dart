import 'package:flutter/material.dart';

class ScrollControllerTestRoute extends StatefulWidget {

  @override
  _ScrollControllerTestRouteState createState() {
    return new _ScrollControllerTestRouteState();
  }
}

class _ScrollControllerTestRouteState extends State<ScrollControllerTestRoute> {
  ScrollController _controller = new ScrollController();
  bool showToTopBtn = false;


  @override
  void initState() {
    _controller.addListener(() {
      print(_controller.offset);
      if (_controller.offset <= 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset > 1000 && !showToTopBtn) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("控制滚动"),),
      body: Scrollbar(
          child: ListView.builder(
              itemCount: 100,
              itemExtent: 50.0, //列表项高度固定，性能消耗小
              controller: _controller,
              itemBuilder: (context, indext) {
                return ListTile(title: Text("$indext"),);
              }),),
      floatingActionButton: !showToTopBtn ? null : FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () {
          _controller.animateTo(0,
              duration: Duration(milliseconds:  200), curve: Curves.ease);
        },
      ),
    );
  }


}