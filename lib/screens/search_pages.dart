import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leaf/screens/search_results_screen.dart';
import 'package:flutter/cupertino.dart';

class SearchPages extends StatefulWidget {
  @override
  _SearchPagesState createState() => new _SearchPagesState();
}

class _SearchPagesState extends State<SearchPages> {
  // Variables
  DateTime _dateTime;
  TimeOfDay _time;

  String selectedDate = 'DATUM AUSWÄHLEN';
  String selectedDateFirebase;
  String selectedTime = 'UHRZEIT WÄHLEN';
  String selectedTimeFirebase;

  final _formKeyLocation = GlobalKey<FormState>();
  final _formKeyDateTime = GlobalKey<FormState>();

  String _origin, _destination, _price;

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

  /// Fahrt suchen -------------------------------------------------------------
  PageController _controllerS;
  int _selectedIndex = 0;

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
                    'Fahrt suchen',
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
                        'Wohin willst du?',
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
                        onSaved: (input) => _origin = input.trim(),
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
                            ? 'Bitte gib ein gültiges Ziel an.'
                            : null,
                        onSaved: (input) => _destination = input.trim(),
                        //destination = input,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16.0, right: 16, left: 16),
                      alignment: Alignment.bottomRight,
                      child: RaisedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
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

          /// Date und Time eingeben -------------------------------------------------
          Form(
            key: _formKeyDateTime,
            child: Scaffold(
              backgroundColor: Color(0xff111e2e),
              appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Color(0xff111e2e),
                  automaticallyImplyLeading: true,
                  title: Text(
                    'Fahrt suchen',
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
                        if (_formKeyDateTime.currentState.validate()) {
                          _formKeyDateTime.currentState.save();

                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => SearchResultsScreen(
                                  _origin,
                                  _destination,
                                  selectedTimeFirebase,
                                  selectedDateFirebase,
                                  _price),
                            ),
                          );
                        }
                      },
                      color: Color(0xff0cce6b),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        'SUCHEN',
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
