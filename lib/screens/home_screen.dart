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
                child: Image.asset('assets/images/Imprint_Lupe_Suche.png'
                ),
              ),
            ),
            Hero(
              tag: 'startLogo',
              child: Container(
                width: 235,
                child: Image.asset('assets/images/Drag_LEAF.png'),
              ),
            ),
            Container(
              width: 500,
              child: Image.asset('assets/images/Imprint_Hand_Biete.png'),
            ),
          ],
        ),
      ),
    );
  }
}
