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
  //MECHANICS: Sets locale
  //LOCALE INPUT: 'locale' referenced for setting the locale state
  static void setLocale(BuildContext context, Locale locale) {
    _ThirtyState state = context.findAncestorStateOfType<_ThirtyState>();
    state.setLocale(locale);
  }

  @override
  _ThirtyState createState() => _ThirtyState();
}

class _ThirtyState extends State<Thirty> {
  //CLASS INITILIZATION
  CloudFirestore cloudFirestore = new CloudFirestore();
  RouteNavigation routeNavigation = new RouteNavigation();
  InterfaceStandards interfaceStandards = new InterfaceStandards();

  //VARIABLE INITIALIZATION
  Locale locale;
  bool isSignedIn = false;

  //INITIAL STATE
  //DESCRIPTION: Gets signed in status prior to the application loading
  void initState() {
    super.initState();
    cloudFirestore
        .getSignedInStatus()
        .then((_isSignedIn) => {isSignedIn = _isSignedIn});
  }

  //MECHANICS: Set locale
  //LOCALE INPUT: '_locale' referenced for setting the locale in state setting
  void setLocale(Locale _locale) {
    setState(() {
      locale = _locale;
    });
  }

  //MECHANICS: Changing dependencies
  //DESCRIPTION: Gets the locale and then sets the locale in the state
  @override
  void didChangeDependencies() {
    getLocale().then((_locale) => {
          setState(() {
            this.locale = _locale;
          })
        });
    super.didChangeDependencies();
  }

  //USER INTERFACE: THIRTY APP
  @override
  Widget build(BuildContext context) {
    if (locale == null) {
      interfaceStandards.showWaitingScreen(context);
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
