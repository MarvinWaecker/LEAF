import 'package:flutter/material.dart';

class SeatSelectionScreen extends StatefulWidget {

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Sitzwahl', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}