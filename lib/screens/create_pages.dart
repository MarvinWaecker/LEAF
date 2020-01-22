import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leaf/animations/page_transition2.dart';
import 'package:leaf/models/ride_model.dart';
import 'package:leaf/screens/created_screen.dart';
import 'package:leaf/screens/rides_overview_screen.dart';
import 'package:leaf/screens/seat_selection_screen.dart';
import 'package:leaf/services/database_service.dart';

import 'mainBar_screen.dart';

class CreatePages extends StatefulWidget {
  @override
  _CreatePagesState createState() => _CreatePagesState();
}

class _CreatePagesState extends State<CreatePages> {
  // Variables
  DateTime _dateTime;
  TimeOfDay _time;

  String selectedDate = 'DATUM AUSWÄHLEN';
  String selectedDateFirebase = "";
  String selectedTime = 'UHRZEIT WÄHLEN';
  String selectedTimeFirebase = "test";

  final _formKeyLocation = GlobalKey<FormState>();
  final _formKeyDateTime = GlobalKey<FormState>();
  final _formKeyPrice = GlobalKey<FormState>();

  String _origin, _destination;
  double _priceDouble = 10.0;

  /// Date Picker --------------------------------------------------------------
  changeDateFirebase() {
    final dateFormatter = DateFormat("dd.MM.yyyy");
    selectedDateFirebase = dateFormatter.format(_dateTime);
  }

  changeDate() {
    setState(() {
      if (DateFormat('EEEE').format(_dateTime) == "Monday") {
        final dateFormatter = DateFormat("'Montag, den 'dd.MM.yyyy");
        selectedDate = dateFormatter.format(_dateTime);
        changeDateFirebase();
      }

      if (DateFormat('EEEE').format(_dateTime) == "Tuesday") {
        final dateFormatter = DateFormat("'Dienstag, den 'dd.MM.yyyy");
        selectedDate = dateFormatter.format(_dateTime);
        changeDateFirebase();
      }

      if (DateFormat('EEEE').format(_dateTime) == "Wednesday") {
        final dateFormatter = DateFormat("'Mittwoch, den 'dd.MM.yyyy");
        selectedDate = dateFormatter.format(_dateTime);
        changeDateFirebase();
      }

      if (DateFormat('EEEE').format(_dateTime) == "Thursday") {
        final dateFormatter = DateFormat("'Donnerstag, den 'dd.MM.yyyy");
        selectedDate = dateFormatter.format(_dateTime);
        changeDateFirebase();
      }

      if (DateFormat('EEEE').format(_dateTime) == "Friday") {
        final dateFormatter =
            DateFormat("'Fridays for Future, den 'dd.MM.yyyy");
        selectedDate = dateFormatter.format(_dateTime);
        changeDateFirebase();
      }

      if (DateFormat('EEEE').format(_dateTime) == "Saturday") {
        final dateFormatter = DateFormat("'Samstag, den 'dd.MM.yyyy");
        selectedDate = dateFormatter.format(_dateTime);
        changeDateFirebase();
      }

      if (DateFormat('EEEE').format(_dateTime) == "Sunday") {
        final dateFormatter = DateFormat("'Sonntag, den 'dd.MM.yyyy");
        selectedDate = dateFormatter.format(_dateTime);
        changeDateFirebase();
      }
    });
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: _dateTime == null ? DateTime.now() : _dateTime,
      firstDate: DateTime.now().add(Duration(days: -1)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _dateTime = picked);
      changeDate();
    } else {
    }
  }

  /// Time Picker --------------------------------------------------------------
  changeTime() {
    setState(() {
      // Formatter
      final timeFormatter = DateFormat("HH:mm' Uhr'");
      final timeFormatterFirebase = DateFormat("HH:mm");
      // Fake erstellen
      final fakeTime = DateTime(2000, 10, 10, _time.hour, _time.minute);
      // Zeit an Variable übergeben
      selectedTime = timeFormatter.format(fakeTime);
      selectedTimeFirebase = timeFormatterFirebase.format(fakeTime);
    });
  }

  Future _selectTime() async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time == null ? TimeOfDay.now() : _time,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (picked != null) {
      setState(() => _time = picked);
      changeTime();
    } else {
    }
  }

  /// Fahrt anbieten -------------------------------------------------------------
  PageController _controllerS;
  int _selectedIndex = 0;

  _submit() async {
    Ride ride = Ride(
      origin: _origin,
      destination: _destination,
      date: selectedDateFirebase,
      time: selectedTimeFirebase,
      price: _priceDouble.toInt().toString(),
    );
    DatabaseService.createRide(ride, context);
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _controllerS.animateToPage(_selectedIndex,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  void initState() {
    super.initState();
    _controllerS = new PageController();
  }

  /// Origin und Destination eingeben
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: new ClampingScrollPhysics(),
        controller: _controllerS,
        children: <Widget>[
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: _formKeyLocation,
              child: Scaffold(
                backgroundColor: Color(0xff111e2e),
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Color(0xff111e2e),
                  automaticallyImplyLeading: false,
                  title: Text(
                    'Fahrt anbieten',
                    style: TextStyle(
                      fontFamily: 'UbuntuRegular',
                      fontSize: 24,
                      color: Color(0xffE6EFE9),
                    ),
                  ),
                ),
                body: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 16, left: 16),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Welche Strecke fährst du?',
                        style: TextStyle(
                          fontFamily: 'UbuntuLight',
                          fontSize: 20,
                          color: Color(0xffE6EFE9),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: TextFormField(
                        style: TextStyle(
                          color: Color(0xffE6EFE9),
                          fontFamily: 'UbuntuRegular',
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 10.0),
                          labelText: 'Start',
                          labelStyle: TextStyle(fontFamily: 'UbuntuRegular'),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff4171AB)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff0cce6b)),
                          ),
                        ),
                        validator: (input) => input.trim().isEmpty
                            ? 'Bitte gib einen gültigen Abfahrtsort an.'
                            : null,
                        onSaved: (input) => _origin = input,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: TextFormField(
                        style: TextStyle(
                          color: Color(0xffE6EFE9),
                          fontFamily: 'UbuntuRegular',
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 10.0),
                          labelText: 'Ziel',
                          labelStyle: TextStyle(fontFamily: 'UbuntuRegular'),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff4171AB)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff0cce6b)),
                          ),
                        ),
                        validator: (input) => input.trim().isEmpty
                            ? 'Bitte gib ein gültiges Ziel ein.'
                            : null,
                        onSaved: (input) => _destination = input,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      alignment: Alignment.bottomRight,
                      child: RaisedButton(
                        onPressed: () {
                          _formKeyLocation.currentState.save();
                          onItemTapped(1);
                        },
                        color: Color(0xff0cce6b),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                        ),
                        child: Text(
                          'WEITER',
                          style: TextStyle(
                            color: Color(0xff111e2e),
                            fontSize: 14,
                            fontFamily: 'UbuntuMedium',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Date und Time einstellen -------------------------------------------------
          Form(
            key: _formKeyDateTime,
            child: Scaffold(
              backgroundColor: Color(0xff111e2e),
              appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Color(0xff111e2e),
                  automaticallyImplyLeading: true,
                  title: Text(
                    'Fahrt anbieten',
                    style: TextStyle(
                      fontFamily: 'UbuntuRegular',
                      fontSize: 24,
                      color: Color(0xffE6EFE9),
                    ),
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xffe8b641),
                    ),
                    onPressed: () {
                      onItemTapped(0);
                    },
                  )),
              body: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 16, left: 16),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Wann willst du los?',
                      style: TextStyle(
                        fontFamily: 'UbuntuLight',
                        fontSize: 20,
                        color: Color(0xffE6EFE9),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        _selectDate();
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          style: TextStyle(
                            color: Color(0xffE6EFE9),
                            fontFamily: 'UbuntuRegular',
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 10.0),
                            labelText: "$selectedDate",
                            labelStyle: TextStyle(
                                color: Color(0xff0cce6b),
                                fontFamily: 'UbuntuMedium'),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff4171AB)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff0cce6b)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        _selectTime();
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          style: TextStyle(
                            color: Color(0xffE6EFE9),
                            fontFamily: 'UbuntuRegular',
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 10.0),
                            labelText: '$selectedTime',
                            labelStyle: TextStyle(
                                color: Color(0xff0cce6b),
                                fontFamily: 'UbuntuMedium'),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff4171AB)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff0cce6b)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    alignment: Alignment.bottomRight,
                    child: RaisedButton(
                      onPressed: () {
                        _formKeyDateTime.currentState.save();
                        onItemTapped(2);
                      },
                      color: Color(0xff0cce6b),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        'WEITER',
                        style: TextStyle(
                          color: Color(0xff111e2e),
                          fontSize: 14,
                          fontFamily: 'UbuntuMedium',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Preis festlegen --------------------------------------------------
          Form(
            key: _formKeyPrice,
            child: Scaffold(
              backgroundColor: Color(0xff111e2e),
              appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Color(0xff111e2e),
                  automaticallyImplyLeading: true,
                  title: Text(
                    'Fahrt anbieten',
                    style: TextStyle(
                      fontFamily: 'UbuntuRegular',
                      fontSize: 24,
                      color: Color(0xffE6EFE9),
                    ),
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xffe8b641),
                    ),
                    onPressed: () {
                      onItemTapped(1);
                    },
                  )),
              body: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 16, left: 16),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Wie viel kostet das Mitfahren?',
                      style: TextStyle(
                        fontFamily: 'UbuntuLight',
                        fontSize: 20,
                        color: Color(0xffE6EFE9),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Slider(
                            activeColor: Color(0xff0cce6b),
                            inactiveColor: Color(0xff0F774C),
                            min: 0.0,
                            max: 20.0,
                            onChanged: (newPrice) {
                              setState(() => _priceDouble = newPrice);
                            },
                            value: _priceDouble,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Container(
                          width: 40.0,
                          alignment: Alignment.center,
                          child: Text(
                            '${_priceDouble.toInt()}' + ' €',
                            style: TextStyle(
                              fontFamily: 'UbuntuLight',
                              fontSize: 16,
                              color: Color(0xffE6EFE9),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    alignment: Alignment.bottomRight,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKeyPrice.currentState.validate()) {
                          _formKeyPrice.currentState.save();

                          _submit();
                          Navigator.push(
                              context, EnterExitRoute(exitPage: CreatePages(), enterPage: CreatedScreen()));
                        }
                      },
                      color: Color(0xff0cce6b),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        'ANBIETEN',
                        style: TextStyle(
                          color: Color(0xff111e2e),
                          fontSize: 14,
                          fontFamily: 'UbuntuMedium',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
