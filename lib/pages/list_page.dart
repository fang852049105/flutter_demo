import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/bottomnavigationbar/pages/bottom_navigation_widget.dart';
import 'package:flutter_demo/layout_type.dart';
import 'package:flutter_demo/pages/main_app_bar.dart';
import 'package:flutter_demo/scrollview/scroll_view.dart';
import 'package:flutter_demo/shopping/index_page.dart';

class Route {
  Route({this.name, this.widget, this.voidCallback});

  final String name;
  final Widget widget;
  final VoidCallback voidCallback;
}

class ListPage extends StatelessWidget implements HasLayoutGroup {
  ListPage({Key key, this.layoutGroup, this.onLayoutToggle}) : super(key: key);
  final LayoutGroup layoutGroup;
  final VoidCallback onLayoutToggle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        layoutGroup: layoutGroup,
        layoutType: LayoutType.list,
        onLayoutToggle: onLayoutToggle,
      ),
      body: Container(
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return ListView.builder(
        itemCount: allContacts.length,
        itemBuilder: (BuildContext content, int index) {
          Route route = allContacts[index];
          return ContactListTile(route, context);
        });
  }
}

class ContactListTile extends ListTile {
  ContactListTile(Route route, BuildContext context)
      : super(
      title: Text(route.name),
      onTap: () {
        if (route.voidCallback == null) {
          navigatoionPush(route, context);
        } else {
          route.voidCallback();
        }
      },
      leading: CircleAvatar(child: Text(route.name[0])),
  );
}

List<Route> allContacts = [
  Route(
      name: 'ScrollView Controller Test',
      widget: new ScrollControllerTestRoute()),
  Route(name: 'Jump To Native Page',  widget: new ScrollControllerTestRoute(), voidCallback: jumpToNativePage),
  Route(name: 'sendMessageToPlatfrom', widget: new ScrollControllerTestRoute(), voidCallback: sendMessageToPlatfrom),
  Route(name: 'receiveMessageFromPlatfrom', widget: new BottomNavigationWidget()),
  Route(name: 'shopping', widget: new IndexPage()),
  Route(name: 'Carson Cupps', widget: new ScrollControllerTestRoute()),
  Route(name: 'Devora Nantz', widget: new ScrollControllerTestRoute()),
  Route(name: 'Tyisha Primus', widget: new ScrollControllerTestRoute()),
  Route(name: 'Muriel Lewellyn', widget: new ScrollControllerTestRoute()),
  Route(name: 'Hunter Giraud', widget: new ScrollControllerTestRoute()),
  Route(name: 'Corina Whiddon', widget: new ScrollControllerTestRoute()),
  Route(name: 'Meaghan Covarrubias', widget: new ScrollControllerTestRoute()),
  Route(name: 'Ulysses Severson', widget: new ScrollControllerTestRoute()),
  Route(name: 'Richard Baxter', widget: new ScrollControllerTestRoute()),
  Route(name: 'Alessandra Kahn', widget: new ScrollControllerTestRoute()),
  Route(name: 'Libby Saari', widget: new ScrollControllerTestRoute()),
  Route(name: 'Valeria Salvador', widget: new ScrollControllerTestRoute()),
  Route(name: 'Fredrick Folkerts', widget: new ScrollControllerTestRoute()),
  Route(name: 'Delmy Izzi', widget: new ScrollControllerTestRoute()),
  Route(name: 'Leann Klock', widget: new ScrollControllerTestRoute()),
  Route(name: 'Rhiannon Macfarlane', widget: new ScrollControllerTestRoute()),
];

void navigatoionPush(Route route, BuildContext context) {
  Navigator.push(context, new MaterialPageRoute(builder: (context) {
    return route.widget;
  }));
}


void jumpToNativePage() {
  jumpToNativePageFuture();
}

void sendMessageToPlatfrom() {
  sendMessage();
}


Future<Null> jumpToNativePageFuture() async {
  MethodChannel methodChannel = MethodChannel('com.flutterbus/demo/method');
  Map<String, String> map = {"object": "qadad"};
  await methodChannel.invokeMethod("gotoUiTestPage", map);
  //await methodChannel.invokeMethod("gotoUiTestPage");
}

BasicMessageChannel<Object> _basicMessageChannel = BasicMessageChannel<Object>('com.flutterbus/demo/message', StandardMessageCodec());

//发送消息到platform端并受到回复
Future<String> sendMessage() async {
  String reply = await _basicMessageChannel.send("i am dart side");
  print('dart receive message + $reply');
  return reply;
}
