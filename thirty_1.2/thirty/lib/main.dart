import 'package:flutter/material.dart';

import 'package:thirty/services/appLocalizations.dart';
import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/standards/languageStandards.dart';

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
  //Class initialization
  CloudFirestore cloudFirestore = new CloudFirestore();
  RouteNavigation routeNavigation = new RouteNavigation();

  //Variable initialization
  Locale _locale;
  bool isSignedIn = false;

  //Initial state
  void initState() {
    super.initState();
    cloudFirestore.getSignedInStatus().then((_isSignedIn) {
      isSignedIn = _isSignedIn;
    });
  }

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

  //User interface: Thirty app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Thirty",
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: routeNavigation.NavigateLogin(context, isSignedIn),
    );
  }
}
