import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:thirty/services/appLocalizations.dart';
import 'package:thirty/main.dart';

class Languages {
  Languages(this.id, this.name, this.flag, this.languageCode);

  //VARIABLE REFERENCE
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  //MECHANICS: Returns language list
  //DESCRIPTION: Static list of languages in the application
  //OUTPUT: Returns a list of type language containing the languages supported
  static List<Languages> getLanguageList() {
    return <Languages>[
      Languages(1, "🇺🇸", "English", "en"),
      Languages(2, "🇪🇸", "Español", "es"),
      Languages(3, "🇫🇷", "Français", "fr"),
    ];
  }

  //MECHANICS: Changes language
  //DESCRIPTION: Actual function to call locale change for language between
  //            interfaceStandards and main
  void changeLanguage(BuildContext context, Languages language) async {
    Locale _temp = await setLocale(language.languageCode);
    Thirty.setLocale(context, _temp);
  }
}

//MECHANICS: Locale cases
//DESCRIPTION: Based on the languageCode provided, return a locale
//OUTPUT: Returns appropriate locale, this is used in startup
Locale _locale(String languageCode) {
  Locale _temp;
  switch (languageCode) {
    case "en":
      _temp = Locale(languageCode, "en");
      break;
    case "es":
      _temp = Locale(languageCode, "es");
      break;
    case "fr":
      _temp = Locale(languageCode, "fr");
      break;
    default:
      _temp = Locale(languageCode, "en");
      break;
  }
  return _temp;
}

//MECHANICS: Sets locale
//DESCRIPTION:
Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString("LanguageCode", languageCode);
  return _locale(languageCode);
}

//Mechanics: Gets locale
Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString("LanguageCode") ?? "en";
  return _locale(languageCode);
}

//Mechanics: Gets translated string
String getTranslated(BuildContext context, String key) {
  return AppLocalizations.of(context).translate(key);
}
