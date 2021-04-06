import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';

class AppLocalizations {
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  //VARIABLE REFERENCE
  final Locale locale;

  //VARIABLE INITIALIZATION
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
  Map<String, String> _localizedStrings;

  //MECHANICS: Load strings
  //DESCRIPTION: Preemptively gets the string values from the language file
  //          based on the locale and languageCode provided
  //OUTPUT: Saving values from language file in the _localizedStrings map for
  //      referencing later
  Future load() async {
    String jsonString = await rootBundle
        .loadString('lib/languages/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  //MECHANICS: Translate strings
  //DESCRIPTION: Takes the map filled in load() and searches for a specific
  //          string called 'key'
  //OUTPUT: Returns the string value associated with the 'key' from the map from
  //      the specific language file
  String translate(String key) {
    return _localizedStrings[key];
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  //VARIABLE INITIALIZATION
  const _AppLocalizationsDelegate();

  //MECHANICS: Overriding for support
  //OUTPUT: Returns whether or not a specific locale-languageCode pair is
  //      supported by the application
  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'fr'].contains(locale.languageCode);
  }

  //MECHANICS: Overriding for load
  //OUTPUT: Returns localizations after being loaded by load() function above
  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  //MECHANICS: Don't know, but apparently everyone has this
  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
