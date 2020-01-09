import 'package:flutter/material.dart';

class DatepickerService {
  static selectDate(BuildContext context) {
    Future<DateTime> _date = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );
    return _date;
  }
}
