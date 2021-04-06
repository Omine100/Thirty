import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:thirty/services/appLocalizations.dart';
import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/standards/interfaceStandards.dart';
import 'package:thirty/standards/languageStandards.dart';
import 'package:thirty/standards/themes.dart';

void main() {
  runApp(new Thirty());
}

class Thirty extends StatefulWidget {
  //Mechanics: Sets locale
  static void setLocale(BuildContext context, Locale locale) {
    _ThirtyState state = context.findAncestorStateOfType<_ThirtyState>();
    state.setLocale(locale);
  }

  @override
  _ThirtyState createState() => _ThirtyState();
}

class _ThirtyState extends State<Thirty> {
  //Class initialization
  CloudFirestore cloudFirestore = new CloudFirestore();
  RouteNavigation routeNavigation = new RouteNavigation();
  InterfaceStandards interfaceStandards = new InterfaceStandards();

  //Variable initialization
  Locale locale;
  bool isSignedIn = false;

  //Initial state
  void initState() {
    super.initState();
    cloudFirestore
        .getSignedInStatus()
        .then((_isSignedIn) => {isSignedIn = _isSignedIn});
  }

  //Mechanics: Set locale
  void setLocale(Locale _locale) {
    setState(() {
      locale = _locale;
    });
  }

  //Mechanics: Changing dependencies
  @override
  void didChangeDependencies() {
    getLocale().then((_locale) => {
          setState(() {
            this.locale = _locale;
          })
        });
    super.didChangeDependencies();
  }

  //User interface: Thirty app
  @override
  Widget build(BuildContext context) {
    if (locale == null) {
      interfaceStandards.showWaitingScreen();
    } else {
      return ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
            return MaterialApp(
              title: "Thirty",
              debugShowCheckedModeBanner: false,
              debugShowMaterialGrid: false,
              home: routeNavigation.NavigateLogin(context, isSignedIn),
              theme: notifier.darkTheme ? dark : light,
              locale: locale,
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
