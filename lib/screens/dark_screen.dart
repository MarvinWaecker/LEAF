import 'dart:async';
import 'package:flutter/material.dart';
import 'package:leaf/animations/page_transition1.dart';
import 'package:leaf/animations/page_transition3.dart';
import 'package:leaf/screens/mainBar_screen.dart';

class DarkScreen extends StatefulWidget {


  @override
  _DarkScreenState createState() => _DarkScreenState();
}

class _DarkScreenState extends State<DarkScreen>{

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1500), () =>
        Navigator.push(
            context, SlideUpRoute(page: MainBarScreen())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111e2e),
    );
  }
}