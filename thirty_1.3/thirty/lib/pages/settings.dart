import 'package:flutter/material.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/standards/interfaceStandards.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //CLASS INITITALIZATION
  CloudFirestore cloudFirestore = new CloudFirestore();
  RouteNavigation routeNavigation = new RouteNavigation();
  InterfaceStandards interfaceStandards = new InterfaceStandards();

  //USER INTERFACE: Settings screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100),
          ),
          GestureDetector(
            onTap: () {
              cloudFirestore.signOut().then((test) {
                routeNavigation.routeSignOutWelcome(context);
              });
            },
            child: Text("Sign Out"),
          ),
          interfaceStandards.showThemeSelector(context)
        ],
      ),
    );
  }
}
