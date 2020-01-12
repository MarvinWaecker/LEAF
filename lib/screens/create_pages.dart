import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leaf/models/ride_model.dart';
import 'package:leaf/screens/create_ride_overview.dart';
import 'package:leaf/services/database_service.dart';


class CreatePages extends StatefulWidget {
  @override
  _CreatePagesState createState() => _CreatePagesState();
}

class _CreatePagesState extends State<CreatePages> {

  // Variables
  DateTime _dateTime;
  TimeOfDay _time;

  String selectedDate = 'DATUM AUSWÄHLEN';
  String selectedDateFirebase;
  String selectedTime = 'UHRZEIT WÄHLEN';
  String selectedTimeFirebase;

  final _formKeyLocation = GlobalKey<FormState>();
  final _formKeyDateTime = GlobalKey<FormState>();

  String _origin, _destination, _passTime, _date;

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
      /*
      builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(
              primaryColorBrightness: Brightness.dark,
              buttonColor: Color(0xff0cce6b),
              accentColor: Color(0xff0cce6b),
              primaryColor: Color(0xff0cce6b),
              backgroundColor: Color(0xff111e2e),
              cardColor: Color(0xff111e2e),
              highlightColor: Color(0xff111e2e),
            ),
            child: child,
          );
        },
      */
    );
    if (picked != null) {
      setState(() => _dateTime = picked);
      changeDate();
    } else {
      print('DatePicker cancelled');
    }
  }

  /// Time Picker --------------------------------------------------------------
  changeTime() {
    setState(() {
      final timeFormatter = DateFormat("HH:mm' Uhr'");
      final now = new DateTime.now();
      final fakeTime =
      DateTime(now.year, now.month, now.day, _time.hour, _time.minute);
      selectedTime = timeFormatter.format(fakeTime);
      final timeFormatterFirebase = DateFormat("HH:mm");
      selectedDateFirebase = timeFormatterFirebase.format(fakeTime);
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
      print('TimePicker cancelled');
    }
  }

  /// Fahrt in Firebase einfügen -------------------------------------------------

  /*
  _submit() async {
    Ride ride = Ride(
      //  id: Provider.of<UserData>(context).currentUserId =
      //      UserData().currentUserId,
      origin: origin,
      destination: destination,
      date: date,
      time: time,
    );
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DatabaseService.createRide(ride, context);
    }
  }

   */

  /// Fahrt anbieten -------------------------------------------------------------
  PageController _controllerS;
  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _controllerS.animateToPage(
        _selectedIndex,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut
    );
  }

  @override
  void initState() {
    super.initState();
    _controllerS = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controllerS,
        children: <Widget>[
          /// Start Ziel picken ------------------------------------------------
          Form(
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
                    child: TextField(
                      style: TextStyle(
                        color: Color(0xffE6EFE9),
                        fontFamily: 'UbuntuRegular',
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 10.0),
                        labelText: 'Start',
                        labelStyle: TextStyle(
                            color: Color(0xff4171AB),
                            fontFamily: 'UbuntuRegular'
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff4171AB)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff0cce6b)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      style: TextStyle(
                        color: Color(0xffE6EFE9),
                        fontFamily: 'UbuntuRegular',
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 10.0),
                        labelText: 'Ziel',
                        labelStyle: TextStyle(
                            color: Color(0xff4171AB),
                            fontFamily: 'UbuntuRegular'
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff4171AB)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff0cce6b)),
                        ),
                      ),
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
          /// Date Time picken -------------------------------------------------
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
                  leading: IconButton(icon:Icon(Icons.navigate_before, color: Color(0xffe8b641),),
                    onPressed:() {onItemTapped(0);},
                  )
              ),
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
                      onTap: () {_selectDate();},
                      child: AbsorbPointer(
                        child: TextField(
                          style: TextStyle(
                            color: Color(0xffE6EFE9),
                            fontFamily: 'UbuntuRegular',
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 10.0),
                            labelText: "$selectedDate",
                            labelStyle: TextStyle(
                                color: Color(0xff0cce6b),
                                fontFamily: 'UbuntuMedium'
                            ),
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
                      onTap: () {_selectTime();},
                      child: AbsorbPointer(
                        child: TextField(
                          style: TextStyle(
                            color: Color(0xffE6EFE9),
                            fontFamily: 'UbuntuRegular',
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 10.0),
                            labelText: '$selectedTime',
                            labelStyle: TextStyle(
                                color: Color(0xff0cce6b),
                                fontFamily: 'UbuntuMedium'
                            ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CreateRideOverview(
                                //_origin, _destination, _passTime, _date),
                          ),
                        ));
                      },                      color: Color(0xff0cce6b),
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
        ],
      ),
    );
  }
}
