import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leaf/screens/search_results_screen.dart';

/*
class SearchTimeScreen extends StatefulWidget {
  @override
  _SearchTimeScreenState createState() => _SearchTimeScreenState();
}

class _SearchTimeScreenState extends State<SearchTimeScreen> {

  // Variables
  DateTime _dateTime;
  TimeOfDay _time;

  String selectedDate = 'DATUM AUSWÄHLEN';
  String selectedTime = 'UHRZEIT WÄHLEN';

  /// Date Picker --------------------------------------------------------------
  changeDate() {
    setState(() {
      if(DateFormat('EEEE').format(_dateTime) == "Monday") {
        final dateFormatter = DateFormat("'Montag, den 'dd.MM.yyyy");
        selectedDate = dateFormatter.format(_dateTime);
      };
      if(DateFormat('EEEE').format(_dateTime) == "Tuesday") {
        final dateFormatter = DateFormat("'Dienstag, den 'dd.MM.yyyy");
        selectedDate = dateFormatter.format(_dateTime);
      };
      if(DateFormat('EEEE').format(_dateTime) == "Wednesday") {
        final dateFormatter = DateFormat("'Mittwoch, den 'dd.MM.yyyy");
        selectedDate = dateFormatter.format(_dateTime);
      };
      if(DateFormat('EEEE').format(_dateTime) == "Thursday") {
        final dateFormatter = DateFormat("'Donnerstag, den 'dd.MM.yyyy");
        selectedDate = dateFormatter.format(_dateTime);
      };
      if(DateFormat('EEEE').format(_dateTime) == "Friday") {
        final dateFormatter = DateFormat("'Fridays for Future, den 'dd.MM.yyyy");
        selectedDate = dateFormatter.format(_dateTime);
      };
      if(DateFormat('EEEE').format(_dateTime) == "Saturday") {
        final dateFormatter = DateFormat("'Samstag, den 'dd.MM.yyyy");
        selectedDate = dateFormatter.format(_dateTime);
      };
      if(DateFormat('EEEE').format(_dateTime) == "Sunday") {
        final dateFormatter = DateFormat("'Sonntag, den 'dd.MM.yyyy");
        selectedDate = dateFormatter.format(_dateTime);
      };
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
    if(picked != null) {
      setState(() => _dateTime = picked); changeDate();
    }
    else {
      print('DatePicker cancelled');
    }
  }

  /// Time Picker --------------------------------------------------------------
  changeTime() {
    setState(() {
      final timeFormatter = DateFormat("HH:mm' Uhr'");
      final now = new DateTime.now();
      final fakeTime = DateTime(now.year, now.month, now.day, _time.hour, _time.minute);
      selectedTime = timeFormatter.format(fakeTime);
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
    if(picked != null) {
      setState(() => _time = picked); changeTime();
    }
    else {
      print('TimePicker cancelled');
    }
  }



  /// User Interface -----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
*/