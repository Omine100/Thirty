import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:thirty/services/appLocalizations.dart';

class MethodStandards {
  //Mechanics: Returns current time
  String getCurrentDate() {
    String formattedDate =
        DateFormat('yyyy-MM-dd-HH:mm:ss').format(DateTime.now());
    return formattedDate;
  }
}
