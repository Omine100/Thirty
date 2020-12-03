import 'package:flutter/material.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/services/root.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/themesGradients.dart';
import 'package:thirty/standards/interfaceStandards.dart';
import 'package:thirty/pages/intro.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.userId});

  //Variable reference
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Class initialization
  CloudFirestore cloudFirestore = new CloudFirestore();
  Themes themes = new Themes();
  ThemesGradients themesGradients = new ThemesGradients();
  InterfaceStandards interfaceStandards = new InterfaceStandards();

  //Variable initialization
  String goal;

  //User interface: Home screen
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: Column(
          children: [
            Text("Testing"),
            GestureDetector(
              onTap: () {
                cloudFirestore.signOut();
                Navigator.pushReplacementNamed(context, "/RootScreen");
              },
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}
