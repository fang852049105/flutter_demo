import 'package:flutter/material.dart';


class ForeFatherWidget extends StatefulWidget {
  _ForeFatherWidgetState myState;
  @override
  _ForeFatherWidgetState createState() {
    myState = _ForeFatherWidgetState();
    return myState;
  }
}

class _ForeFatherWidgetState extends State<ForeFatherWidget> {
  Color _color = Colors.pink;
  Color get color => _color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChildAccessForefatherState'),
      ),
        body: Container(
            child: Center(
              child: ChildWidget(),
            )
        )
    );
  }
}



class ChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ForeFatherWidget widget = context.ancestorWidgetOfExactType(ForeFatherWidget);
    final _ForeFatherWidgetState state = widget?.myState;
    return Container(
      child: Text('child accsee forefather state',
          style: TextStyle(
              color: state != null ? state._color : Colors.black,
              fontSize: 24)
      ),
    );

  }
}


class ChildAccessForeFatherStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ForeFatherWidget(),
    );
  }
}


