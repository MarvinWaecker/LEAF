import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  static final String id = 'activity_screen';

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'LEAF',
          style: TextStyle(
            color: Colors.greenAccent,
            fontSize: 35.0,
            fontFamily: 'Raleway',
          ),
        ),
      ),
      body: Center(child: Text(
          'Hurenshohn'
      )),
    );
  }
}
