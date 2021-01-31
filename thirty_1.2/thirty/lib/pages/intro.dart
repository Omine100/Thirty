import 'package:flutter/material.dart';

import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/standards/languageStandards.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/gradientStandards.dart';
import 'package:thirty/standards/interfaceStandards.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({this.email, this.password});

  //Variable references
  final String email, password;

  @override
  State<StatefulWidget> createState() => new _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  //Class initialization
  RouteNavigation routeNavigation = new RouteNavigation();
  CloudFirestore cloudFirestore = new CloudFirestore();
  Themes themes = new Themes();
  GradientStandards gradientStandards = new GradientStandards();
  InterfaceStandards interfaceStandards = new InterfaceStandards();

  //User interface: Intro screen
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: Text("Testing"),
      ),
    );
  }
}
