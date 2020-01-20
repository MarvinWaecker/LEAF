import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatepickerService {

  String selectedDate = 'DATUM AUSWÄHLEN';
  DateTime _dateTime;

  Future _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: _dateTime == null ? DateTime.now() : _dateTime,
      firstDate: DateTime.now().add(Duration(days: -1)),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(
              primaryColorBrightness: Brightness.dark,
              buttonColor: Color(0xff0cce6b),
              accentColor: Color(0xff0cce6b),
              primaryColor: Color(0xff0cce6b),
              backgroundColor: Color(0xff111e2e),
              cardColor: Color(0xff111e2e),
              buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.accent
              ),
              highlightColor: Color(0xff111e2e),

            ),
            child: child,
          );
        },

    );
    if (picked != null) {
      //setState(() => _dateTime = picked);
    }
    else {
    }
  }

  setState() {
    if (DateFormat('EEEE').format(_dateTime) == "Monday") {
      final dateFormatter = DateFormat("'Montag, den 'dd.MM.yyyy");
      selectedDate = dateFormatter.format(_dateTime);
    }
    ;
    if (DateFormat('EEEE').format(_dateTime) == "Tuesday") {
      final dateFormatter = DateFormat("'Dienstag, den 'dd.MM.yyyy");
      selectedDate = dateFormatter.format(_dateTime);
    }
    ;
    if (DateFormat('EEEE').format(_dateTime) == "Wednesday") {
      final dateFormatter = DateFormat("'Mittwoch, den 'dd.MM.yyyy");
      selectedDate = dateFormatter.format(_dateTime);
    }
    ;
    if (DateFormat('EEEE').format(_dateTime) == "Thursday") {
      final dateFormatter = DateFormat("'Donnerstag, den 'dd.MM.yyyy");
      selectedDate = dateFormatter.format(_dateTime);
    }
    ;
    if (DateFormat('EEEE').format(_dateTime) == "Friday") {
      final dateFormatter = DateFormat("'Fridays for Future, den 'dd.MM.yyyy");
      selectedDate = dateFormatter.format(_dateTime);
    }
    ;
    if (DateFormat('EEEE').format(_dateTime) == "Saturday") {
      final dateFormatter = DateFormat("'Samstag, den 'dd.MM.yyyy");
      selectedDate = dateFormatter.format(_dateTime);
    }
    ;
    if (DateFormat('EEEE').format(_dateTime) == "Sunday") {
      final dateFormatter = DateFormat("'Sonntag, den 'dd.MM.yyyy");
      selectedDate = dateFormatter.format(_dateTime);
    }
    ;
  }
}
