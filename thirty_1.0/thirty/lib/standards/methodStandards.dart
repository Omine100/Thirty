import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:thirty/languages/language.dart';

class MethodStandards {
  //Mechanics: Returns current time
  String getCurrentDate() {
    String formattedDate =
        DateFormat('yyyy-MM-dd-HH:mm:ss').format(DateTime.now());
    return formattedDate;
  }

  //Mechanics: Changes language
  void changeLanguage(Language language) {
    print(language.languageCode);
  }
}
