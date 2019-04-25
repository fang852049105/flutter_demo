import 'package:flutter/material.dart';
import 'package:flutter_demo/bottomnavigationbar/pages_keep_alive/airplay_screen.dart';
import 'package:flutter_demo/bottomnavigationbar/pages_keep_alive/email_screen.dart';
import 'package:flutter_demo/bottomnavigationbar/pages_keep_alive/home_screen.dart';
import 'package:flutter_demo/bottomnavigationbar/pages_keep_alive/pages_screen.dart';

class NavigationKeepAlive extends StatefulWidget {

  @override
  State createState() {
    return new _NavigationKeepAliveState();
  }
}

// SingleTickerProviderStateMixin 实现Tab切换的动画效果（如果有需要多个嵌套动画效果，你可能需要 TickerProviderStateMixin）
class _NavigationKeepAliveState extends State<NavigationKeepAlive>
    with SingleTickerProviderStateMixin {
  final _bottomNavigationColor = Colors.blue;
  int _currentIndex = 0;
  var _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomeScreen(),
          EmailScreen(),
          PagesScreen(),
          AirPlayScreen()
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: _bottomNavigationColor,
                ),
                title: Text(
                  "HOME",
                  style: TextStyle(color: _bottomNavigationColor),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.email,
                  color: _bottomNavigationColor,
                ),
                title: Text(
                  'Email',
                  style: TextStyle(color: _bottomNavigationColor),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.pages,
                  color: _bottomNavigationColor,
                ),
                title: Text(
                  'PAGES',
                  style: TextStyle(color: _bottomNavigationColor),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.airplay,
                  color: _bottomNavigationColor,
                ),
                title: Text(
                  'AIRPLAY',
                  style: TextStyle(color: _bottomNavigationColor),
                )),
          ]),
    );
  }
}
