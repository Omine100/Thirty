import 'package:flutter/material.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/services/root.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/themesGradients.dart';
import 'package:thirty/standards/interfaceStandards.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.signInCallback, this.signOutCallback, this.userId});

  //Variable reference
  final VoidCallback signInCallback;
  final VoidCallback signOutCallback;
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
                widget.signOutCallback;
                cloudFirestore.signOut();
              },
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}
