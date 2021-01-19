import 'package:flutter/material.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/gradientStandards.dart';
import 'package:thirty/standards/animationStandards.dart';
import 'package:thirty/standards/interfaceStandards.dart';
import 'package:thirty/standards/languageStandards.dart';
import 'package:thirty/standards/methodStandards.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  //Class initialization

  //Variable initialization

  //User interface Welcome screen
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
