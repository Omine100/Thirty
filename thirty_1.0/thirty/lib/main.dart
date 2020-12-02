import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:thirty/services/appLocalizations.dart';
import 'package:thirty/services/root.dart';
import 'package:thirty/standards/themes.dart';

void main() {
  runApp(new Thirty());
}

class Thirty extends StatelessWidget {
  //Class initialiazation
  Themes themes = new Themes();

  //User interfac: Half app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Thirty",
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      routes: {
        '/RootScreen': (context) => RootScreen(),
      },
      initialRoute: '/RootScreen',
      theme: themes.lightTheme(),
      darkTheme: themes.darkTheme(),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('es', 'ES'),
        Locale('fr', "FR")
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
