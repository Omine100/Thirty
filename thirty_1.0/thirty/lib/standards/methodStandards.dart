import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:thirty/languages/language.dart';
import 'package:thirty/services/appLocalizations.dart';
import 'package:thirty/services/appLocalizationConstants.dart';

class MethodStandards {
  //Mechanics: Returns current time
  String getCurrentDate() {
    String formattedDate =
        DateFormat('yyyy-MM-dd-HH:mm:ss').format(DateTime.now());
    return formattedDate;
  }

  //Mechanics: Change language
  void changeLanguage(Language language) async {
    Locale 
  }
}
