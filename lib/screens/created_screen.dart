import 'dart:async';
import 'package:flutter/material.dart';
import 'package:leaf/animations/page_transition1.dart';
import 'package:leaf/screens/mainBar_screen.dart';

class CreatedScreen extends StatefulWidget {


  @override
  _CreatedScreenState createState() => _CreatedScreenState();
}

class _CreatedScreenState extends State<CreatedScreen>{

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1500), () =>
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
              width: 250,
              child: Image.asset('assets/images/LEAF_check.png'),
            ),
            SizedBox(height: 16,),
            Container(
              child: Text(
                'Fahrt erstellt',
                style: TextStyle(
                  color: Color(0xff0cce6b),
                  fontSize: 24,
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