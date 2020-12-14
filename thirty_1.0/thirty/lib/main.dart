import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            title: "Thirty",
            debugShowCheckedModeBanner: false,
            debugShowMaterialGrid: false,
            home: RootScreen(),
            theme: notifier.darkTheme ? dark : light,
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
        },
      ),
    );
  }
}
