import 'package:flutter/material.dart';

class TimepickerService {
  static selectTime(BuildContext context) {
    Future<TimeOfDay> _time = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return _time;
  }
}
