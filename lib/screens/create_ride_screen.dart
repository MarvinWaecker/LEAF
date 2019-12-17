import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leaf/models/ride_model.dart';
import 'package:leaf/models/user_data.dart';
import 'package:leaf/models/user_model.dart';
import 'package:leaf/screens/activity_screen.dart';
import 'package:leaf/services/database_service.dart';
import 'package:leaf/services/datepicker_service.dart';
import 'package:leaf/services/timepicker_service.dart';
import 'package:provider/provider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class CreateRideScreen extends StatefulWidget {
  @override
  _CreateRideScreenState createState() => _CreateRideScreenState();
}

class _CreateRideScreenState extends State<CreateRideScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _origin = '';
  String _destination = '';
  //Future<DateTime> _date;
  //Future<DateTime> _time;

  final format = DateFormat("yyy-MM-dd");

  _submit() async {
    Ride ride = Ride(
      //  id: Provider.of<UserData>(context).currentUserId =
      //      UserData().currentUserId,
      origin: _origin,
      destination: _destination,
      //  date: _date,
      //  time: _time,
    );
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DatabaseService.createRide(ride);
    }
  }

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Origin'),
                        validator: (input) => input.trim().isEmpty
                            ? 'Please enter a valid starting point'
                            : null,
                        onSaved: (input) => _origin = input,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Destination'),
                        validator: (input) => input.trim().isEmpty
                            ? 'Please enter a valid destination'
                            : null,
                        onSaved: (input) => _destination = input,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: 250.0,
                      child: FlatButton(
                        onPressed: () async {
                          final selectedDate = await DatepickerService.selectDate(context);
                          print(selectedDate);
                        },
                        color: Colors.green,
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                            'Pick Date',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: 250.0,
                      child: FlatButton(
                        onPressed: () async {
                          final selectedTime = await TimepickerService.selectTime(context);
                          print(selectedTime);
                        },
                        color: Colors.green,
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Pick Time',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: 250.0,
                      child: FlatButton(
                        onPressed: _submit,
                        color: Colors.green,
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Create',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
