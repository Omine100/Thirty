import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';

class AppLocalizations {
  AppLocalizations(this.locale);

  //Variable reference
  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  //Variable initialization
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
  Map<String, String> _localizedStrings;

  //Mechanics: Load strings
  Future load() async {
    String jsonString = await rootBundle
        .loadString('lib/languages/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  //Mechanics: Translate strings
  String translate(String key) {
    return _localizedStrings[key];
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  //Variable initialization
  const _AppLocalizationsDelegate();

  //Mechanics: Overriding for support
  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'fr'].contains(locale.languageCode);
  }

  //Mechanics: Overriding for load
  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  //Mechanics: Don't know, but apparently everyone has this
  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
