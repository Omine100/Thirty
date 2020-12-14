import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

class MethodStandards {
  //Mechanics: Returns current time
  String getCurrentDate() {
    String formattedDate =
        DateFormat('yyyy-MM-dd-HH:mm:ss').format(DateTime.now());
    return formattedDate;
  }

  //Mechanics: Show theme changer
  void themeSwitch(context) {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }
}
