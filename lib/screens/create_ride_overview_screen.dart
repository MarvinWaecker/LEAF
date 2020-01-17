import 'package:flutter/material.dart';
import 'package:leaf/models/ride_model.dart';
import 'package:leaf/models/user_data.dart';
import 'package:leaf/models/user_model.dart';
import 'package:leaf/services/database_service.dart';
import 'package:provider/provider.dart';

class CreateRideOverviewScreen extends StatefulWidget {
  final String origin, destination, date, time, price;
  CreateRideOverviewScreen(this.origin, this.destination, this.date, this.time, this.price);

  @override
  _CreateRideOverviewScreenState createState() =>
      _CreateRideOverviewScreenState();
}

class _CreateRideOverviewScreenState extends State<CreateRideOverviewScreen> {

  _submit() async {
    Ride ride = Ride(
      origin: widget.origin,
      destination: widget.destination,
      date: widget.date,
      time: widget.time,
      price: widget.price,
    );
    DatabaseService.createRide(ride, context);
  }

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
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          Text(
            widget.date,
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          Text(
            widget.origin,
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          Text(
            widget.destination,
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: SizedBox(
              width: double.maxFinite,
              child: RaisedButton(
                onPressed: _submit,
                color: Color(0xff0cce6b),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                child: Text(
                  'FAHRT ANBIETEN',
                  style: TextStyle(
                    color: Color(0xff111e2e),
                    fontSize: 14,
                    fontFamily: 'UbuntuMedium',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
