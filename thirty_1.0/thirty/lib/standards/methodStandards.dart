import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thirty/main.dart';

import 'package:thirty/services/appLocalizations.dart';
import 'package:thirty/languages/languageList.dart';

class MethodStandards {
  //Mechanics: Returns current time
  String getCurrentDate() {
    String formattedDate =
        DateFormat('yyyy-MM-dd-HH:mm:ss').format(DateTime.now());
    return formattedDate;
  }

  //Mechanics: Changes language
  void changeLanguage(BuildContext context, LanguageList language) {
    Locale _temp;
    switch (language.languageCode) {
      case "en":
        _temp = Locale(language.languageCode, "en");
        break;
      case "es":
        _temp = Locale(language.languageCode, "es");
        break;
      case "fr":
        _temp = Locale(language.languageCode, "fr");
        break;
      default:
        _temp = Locale(language.languageCode, "en");
        break;
    }
    Thirty.setLocale(context, _temp);
  }
}

String getTranslated(BuildContext context, String key) {
  return AppLocalizations.of(context).translate(key);
}
