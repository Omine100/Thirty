import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:thirty/services/appLocalizations.dart';

const String LANGUAGE_CODE = "languageCode";

//Mechanics: Language codes
const String ENGLISH = "en";
const String SPANISH = "es";
const String FRENCH = "fr";

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString(LANGUAGE_CODE, languageCode);
  return _locale(langaugeCode);
}

Future<Locale> getLocale() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String languageCode = preferences.getString(LANGUAGE_CODE) ?? "en";
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return Locale(ENGLISH, "en");
      break;
    case SPANISH:
      return Locale(SPANISH, "es");
      break;
    case FRENCH:
      return Locale(FRENCH, "fr");
      break;
  }
}

String getTranslate(BuildContext context, String key) {
  return AppLocalizations.of(context).translate(key);
}
