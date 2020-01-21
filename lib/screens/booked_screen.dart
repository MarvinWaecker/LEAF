import 'dart:async';
import 'package:flutter/material.dart';
import 'package:leaf/animations/page_transition1.dart';
import 'package:leaf/screens/mainBar_screen.dart';

class BookedScreen extends StatefulWidget {


  @override
  _BookedScreenState createState() => _BookedScreenState();
}

class _BookedScreenState extends State<BookedScreen>{

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 900), () =>
        Navigator.push(
            context, ScaleRoute(page: MainBarScreen())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111e2e),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset('assets/images/LEAF_check.png'),
            ),
            Container(
              child: Text(
                'Buchung erfolgreich',
                style: TextStyle(
                  color: Color(0xff0cce6b),
                  fontSize: 20,
                  fontFamily: 'UbuntuLight',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}