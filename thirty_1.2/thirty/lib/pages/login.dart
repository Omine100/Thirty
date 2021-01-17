import 'package:flutter/material.dart';

import 'package:thirty/services/routeNavigation.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen();

  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Class initialization
  RouteNavigation routeNavigation = new RouteNavigation();

  //User interface: Login screen
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        color: Colors.blue,
        child: GestureDetector(
          onTap: () {
            routeNavigation.RouteHome(context);
          },
          child: Container(
            height: 100,
            width: 100,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
