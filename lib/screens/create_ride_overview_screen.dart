import 'package:flutter/material.dart';

class CreateRideOverviewScreen extends StatefulWidget {
  final String origin, destination, date, time;
  CreateRideOverviewScreen(this.origin, this.destination, this.date, this.time);

  @override
  _CreateRideOverviewScreenState createState() =>
      _CreateRideOverviewScreenState();
}

class _CreateRideOverviewScreenState extends State<CreateRideOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111e2e),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff111e2e),
        automaticallyImplyLeading: true,
        title: Text(
          'Übersicht',
          style: TextStyle(
            fontFamily: 'UbuntuRegular',
            fontSize: 24,
            color: Color(0xffE6EFE9),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.navigate_before,
            color: Color(0xffe8b641),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Text(
            widget.time,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            widget.date,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
