import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:thirty/services/appLocalizations.dart';
import 'package:thirty/services/root.dart';
import 'package:thirty/languages/languages.dart';
import 'package:thirty/standards/themes.dart';

void main() {
  runApp(new Thirty());
}

class Thirty extends StatefulWidget {
  //Mechanics: Sets Locale
  static void setLocale(BuildContext context, Locale locale) {
    _ThirtyState state = context.findAncestorStateOfType<_ThirtyState>();
    state.setLocale(locale);
  }

  @override
  _ThirtyState createState() => _ThirtyState();
}

class _ThirtyState extends State<Thirty> {
  //Class initialiazation
  Themes themes = new Themes();

  //Variable initialization
  Locale _locale;

  //Mechanics: Sets locale
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  //Mechanics: Changing dependencies
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  //User interface: Half app
  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
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
              locale: _locale,
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
}
