import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Function toSearchScreen;
  final Function toCreateRideScreen;

  HomeScreen({
    this.toSearchScreen,
    this.toCreateRideScreen,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
  static final String id = 'home_screen';
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111e2e),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                width: 500,
                child: DragTarget(
                  builder: (context, List<int> candidateData, rejectedData) {
                    return Image.asset('assets/images/Imprint_Lupe_Suche.png');
                  },
                  onWillAccept: (data) {
                    return true;
                  },
                  onAccept: (data) {
                    if (data == 1) {
                      widget.toSearchScreen();
                    }
                  },
                ),
              ),
            ),
            Container(
              width: 245,
              child: Draggable(
                axis: Axis.vertical,
                //dragAnchor: ,
                child: Image.asset(
                  'assets/images/Drag_LEAF.png',
                ),
                feedback: Container(
                  width: 245,
                  child: Image.asset(
                    'assets/images/Drag_LEAF.png',
                  ),
                ),

                childWhenDragging: Container(
                  height: 142,
                ),
                data: 1,
              ),
            ),
            Container(
              width: 500,
              child: DragTarget(
                builder: (context, List<int> candidateData, rejectedData) {
                  return Image.asset('assets/images/Imprint_Hand_Biete.png');
                },
                onWillAccept: (data) {
                  return true;
                },
                onAccept: (data) {
                  if (data == 1) {
                    widget.toCreateRideScreen();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
