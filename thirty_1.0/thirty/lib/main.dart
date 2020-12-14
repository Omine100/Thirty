import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

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
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => ThemeData(brightness: brightness),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            title: "Thirty",
            debugShowCheckedModeBanner: false,
            debugShowMaterialGrid: false,
            home: RootScreen(),
            theme: Theme.of,
            supportedLocales: [Locale('en'), Locale('es'), Locale('fr')],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
          );
        });
  }
}
