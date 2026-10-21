import 'package:flutter/material.dart';

extension DateTimeExtesions on TimeOfDay {
  DateTime get dateTime => DateTime(0, 0, 0, hour, minute, 0);
}
