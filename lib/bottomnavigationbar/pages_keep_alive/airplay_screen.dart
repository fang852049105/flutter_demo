import 'package:flutter/material.dart';

class AirPlayScreen extends StatefulWidget {
  @override
  State createState() {
    return new _AirPlayScreenState();
  }
}

/**场景 ：Flutter中为了节约内存不会保存widget的状态，widget都是临时变量。当我们使用TabBar，TabBarView是我们就会发现，
 *切换tab后再重新切换回上一页面，这时候tab会重新加载重新创建，体验很不友好。
 *解决方案：继承AutomaticKeepAliveClientMixin，并实现wantKeepAlive方法。它是一个抽象状态，继承这个状态后，widget在不显示之后也不会被销毁仍然保存在内存中，所以慎重使用这个方法。
 */
class _AirPlayScreenState extends State<AirPlayScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive {
    return true;
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AirPlayScreen'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
