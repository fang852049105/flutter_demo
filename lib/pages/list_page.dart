import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/layout_type.dart';
import 'package:flutter_demo/pages/main_app_bar.dart';
import 'package:flutter_demo/scrollview/scroll_view.dart';

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
        Navigator.push(context, new MaterialPageRoute(builder: (context) {
          return route.widget;
        }));
      },
      onLongPress: route.voidCallback,
      leading: CircleAvatar(child: Text(route.name[0])),

  );
}

List<Route> allContacts = [
  Route(
      name: 'ScrollView Controller Test',
      widget: new ScrollControllerTestRoute()),
  Route(name: 'Jump To Native Page',  widget: new ScrollControllerTestRoute(), voidCallback: jumpToNativePage),
  Route(name: 'Racquel Ricciardi', widget: new ScrollControllerTestRoute()),
  Route(name: 'Teresita Mccubbin', widget: new ScrollControllerTestRoute()),
  Route(name: 'Rhoda Hassinger', widget: new ScrollControllerTestRoute()),
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

void jumpToNativePage() {
  jumpToNativePageFuture();
}

Future<Null> jumpToNativePageFuture() async {
  MethodChannel methodChannel = MethodChannel('com.flutterbus/demo');
  await methodChannel.invokeMethod("gotoUiTestPage");
}
