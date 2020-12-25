import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/standards/interfaceStandards.dart';
import 'package:thirty/pages/welcome.dart';
import 'package:thirty/pages/home.dart';

class RouteNavigation extends StatefulWidget {
  RouteNavigation({this.isLight});

  //Variable reference
  final bool isLight;

  @override
  State<StatefulWidget> createState() => _RouteNavigationState();
}

class _RouteNavigationState extends State<RouteNavigation> {
  //Class initialization
  CloudFirestore cloudFirestore = new CloudFirestore();
  InterfaceStandards interfaceStandards = new InterfaceStandards();
  WelcomeScreen welcomeScreen = new WelcomeScreen();

  //Variable initialization
  final db = Firestore.instance;
  String _userId = "";
  bool _isSignedIn;

  //Initial state
  @override
  void initState() {
    super.initState();
    cloudFirestore.getSignedInStatus().then((isSignedIn) {
      _isSignedIn = isSignedIn;
    });
  }

  //Mechanics: Route navigation
  Future<Object> navigator(BuildContext context, WelcomeScreen page()) {
    return Navigator.push(
      MaterialPageRoute(builder: (context) => page);
    );
  }

  //Mechanics: Route to Welcome screen

  //Mechanics: Route to Login screen

  //Mechanics: Route to Forgot Password screen

  //Mecahnics: Route to Intro screen

  //Mechanics: Route to Home screen

  //User interface: Root screen
  @override
  Widget build(BuildContext context) {
    if (!_isSignedIn) {
      navigator(context, welcomeScreen());
    } else {
      interfaceStandards.showWaitingScreen();
    }
  }
}
